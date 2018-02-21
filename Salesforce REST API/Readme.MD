## Force.com (Salesforce) REST API

* Salesforce REST APIs provide a way to integrate with Salesforce through simple HTTP + JSON requests. 
* The REST APIs use OAuth for authentication.
* The wrapper libraries handle low-level tasks such as authentication and request and response handling.
* Each request to the APIs must include an authentication token or key.
```Node.js
var query = 'SELECT name Account'; var url = 'https://na1.salesforce.com/services/data/v20.0/query/?q=' + encodeURIComponent(query); request.get(url, { 'auth': { 'bearer': 'bearerToken' } }); 
```
* Apex HTTP callout programmatically makes a REST call to an outside app.  App receives a request with the event details payload and then performs the action

## REST API
* A REST request consists of four components: a resource URI, an HTTP method, request headers, and a request body. Request headers specify metadata for the request. 
* 
#

## Description

## Use Case

## Limitations
* [General Salesforce REST API limitations](https://developer.salesforce.com/docs/atlas.en-us.212.0.api.meta/api/implementation_considerations.htm?SearchType=Stem)
## Pattern Value-add

## Resources
