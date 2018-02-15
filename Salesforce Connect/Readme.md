# Salesforce Connect

## External Objects
* Salesforce Connect maps data tables in external systems to external objects in your org.  External objects map to data located outside of the Salesforce org.  Accessing an external object fetches the data from the external system in real time.
* Display URL is the OData 2.0 URL representing a record in the external database 
* External ID is the primary key value for each record.
* Salesforce Connect always fetches current data from the external system in real time.
## Use Case
* You have a large amount of data that you don’t want to copy into your Salesforce org.
* You need small amounts of data at any one time.
* You need real-time access to the latest data.
* You store your data in the cloud or in a back-office system, but want to display or process that data in your Salesforce org.
* [Rendering GitHub JSON Data in Salesforce](https://developer.salesforce.com/blogs/developer-relations/2015/08/rendering-github-json-data-salesforce.html)
* Use Salesforce Connect (formerly called Lightning Connect) as a data proxy to pull OData or other data sources into Salesforce on demand. 
* No data is copied to the Salesforce database. 
* Run endpoints that expose OData 2.0 on Heroku or as provided by external systems. 
* [Salesforce Connect custom adapters](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connector_custom_adapter.htm) allow Salesforce to proxy any data source that Apex can talk to, including REST with XML or JSON and SOAP.
* Proxying external data into Salesforce without copying it to the database.
* pull data into Salesforce and correlate that data with other objects in Salesforce.
* Salesforce Connect works with a variety of data sources:
  * Any OData 2.0 data source can be pulled into Salesforce with Salesforce Connect.
  * Heroku Connect can expose a Heroku Postgres database to Salesforce Connect.
  * Any Heroku app can provide endpoints that can be consumed with Salesforce Connect.
* Custom adapters for Salesforce Connect that proxy the data that the REST services provide
* The primary use case for Salesforce Connect custom adapters is when an external system provides data that is useful in the standard Salesforce UI
* [DataSource.Column docs](https://developer.salesforce.com/docs/atlas.en-us.200.0.apexcode.meta/apexcode/apex_class_DataSource_Column.htm#apex_class_DataSource_Column)
* Salesforce Connect custom adapters can also handle data paging, which is essential if your REST services expose large data sets. [Paging with the Apex Connector Framework](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connector_paging.htm)
## Authentication
* [Authentication for Salesforce Connect Custom Adapters
](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_connector_authentication.htm)
* Two options for setting up user authentication for an external data source:
  * Named Principal—Your entire Salesforce org shares one login account on the external system.
  * Per User—Your org uses multiple login accounts on the external system. You or your users can set up their personal authentication settings for the external system.
* [Identity Type for External Data Sources](https://help.salesforce.com/articleView?id=platform_connect_identity_type.htm&type=5)
## Benefits
* The primary benefit of using Salesforce Connect instead of traditional ETL methods is that the data is always in sync because it's retrieved in near real time and not copied.

## Limitations
* [General Limits](https://help.salesforce.com/articleView?id=platform_connect_general_limits.htm&type=5)
## Configuration Steps

* Create the external data source. If your external system hosts multiple services, create an external data source for each service that’s required to access the data.
* Create the external objects and their fields. Create an external object in your Salesforce org for each external data table that you want to access. On each external object, create a custom field for each external table column that you want to access from your Salesforce org.
* Define relationships for the external objects. Create lookup, external lookup, and indirect lookup relationship fields to provide seamless views of data across system boundaries.
* Enable user access to external objects and their fields. Grant object and field permissions through permissions sets or profiles.
* Set up user authentication. For each external data source that uses per-user authentication, do both of the following.
 * Enable users to authenticate to the external data source. Grant users access through permission sets or profiles.
 * Set up each user’s authentication settings. Tell your users how to set up and manage their own authentication settings for external systems in their personal settings. Alternatively, you can perform this task for each user.

### 1. Provide REST endpoint (i.e. https://ionic2-realty-rest-demo.herokuapp.com/properties/)
### 2. Write Apex code to bridge between Salesforce Connect and the service.  
  * Apex adapter that extends the DataSource.Connection class and implements the sync(), query(), and search() methods with a basic structure like:
```Apex
global class RealEstateConnection extends DataSource.Connection { override global List<DataSource.TableResult> search(DataSource.SearchContext searchContext) { } override global List<DataSource.Table> sync() { } override global DataSource.TableResult query(DataSource.QueryContext queryContext) { } }
```
 * Search out-of-the-box utility:
```Apex 
 override global List<DataSource.TableResult> search(DataSource.SearchContext searchContext) { return DataSource.SearchUtils.searchByName(searchContext, this); } 
```

* The sync() method tells Salesforce about the data structure of the External Objects.For this example, we can just add a single table with a few columns. The ExternalId, DisplayUrl, and Name fields are required.
```Apex
override global List<DataSource.Table> sync() { List<DataSource.Column> columns = new List<DataSource.Column>(); columns.add(DataSource.Column.text('ExternalId', 255)); columns.add(DataSource.Column.url('DisplayUrl')); columns.add(DataSource.Column.text('Name', 128)); columns.add(DataSource.Column.text('city', 128)); columns.add(DataSource.Column.text('price', 128)); List<DataSource.Table> tables = new List<DataSource.Table>(); tables.add(DataSource.Table.get('Properties', 'Name', columns)); return tables; } 
```
* When a user in Salesforce accesses an External Object’s list of records, the query() method fetches and parses the data into the data structure defined in the sync() method. Here is an example of the query() method for the real estate REST service.
```Apex
 override global DataSource.TableResult query(DataSource.QueryContext queryContext) { List<Map<String, Object>> properties = DataSource.QueryUtils.process(queryContext, getProperties()); DataSource.TableResult tableResult = DataSource.TableResult.get(queryContext, properties); return tableResult; } public List<Map<String, Object>> getProperties() { Http httpProtocol = new Http(); HttpRequest request = new HttpRequest(); String url = 'https://ionic2-realty-rest-demo.herokuapp.com/properties/'; request.setEndPoint(url); request.setMethod('GET'); HttpResponse response = httpProtocol.send(request); List<Map<String, Object>> properties = new List<Map<String, Object>>(); for (Object item : (List<Object>)JSON.deserializeUntyped(response.getBody())) { Map<String, Object> property = (Map<String, Object>)item; property.put('ExternalId', property.get('id')); property.put('DisplayUrl', 'https://ionic2-realty-rest-demo.herokuapp.com/'); property.put('Name', property.get('title')); properties.add(property); } return properties; } 
```
