# Salesforce Connect
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

## Benefits
* The primary benefit of using Salesforce Connect instead of traditional ETL methods is that the data is always in sync because it's retrieved in near real time and not copied.

## Limitations

## Configuration Steps
1. Provide REST endpoint (i.e. https://ionic2-realty-rest-demo.herokuapp.com/properties/)
2. 
