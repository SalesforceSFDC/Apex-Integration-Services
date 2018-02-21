## Force.com (Salesforce) REST API

## Description
The Force.com REST API is used for integrate with Force.com applications using HTTP methods, in either XML or JSON formats. The REST APIs use OAuth for authentication.  The wrapper libraries handle low-level tasks such as authentication and request and response handling.  Each request to the APIs must include an authentication token or key.
A REST request consists of four components: a resource URI, an HTTP method, request headers, and a request body. Request headers specify metadata for the request. 
## Use Case
API for developing mobile applications or external clients.
## Limitations
* [General Salesforce REST API limitations](https://developer.salesforce.com/docs/atlas.en-us.212.0.api.meta/api/implementation_considerations.htm?SearchType=Stem)

## Implementation Steps

## Pattern Value-add
* Ubiquitous access: Use standard HTTP method call-outs, available on every language and platform, to make requests and retrieve information from Force.com.
* Standards-based security: Utilize the OAuth protocol for authenticating your REST calls.
* Data model: Gain access to the same data model and standard objects as those in SOAP-based Web services.
* Flexible formats: Serialize data in either the XML or JSON format.
## Resources
* [Salesforce API Basics](https://trailhead.salesforce.com/modules/api_basics)
* [General Salesforce REST API limitations](https://developer.salesforce.com/docs/atlas.en-us.212.0.api.meta/api/implementation_considerations.htm?SearchType=Stem)
# Notes
* Salesforce REST APIs provide a way to integrate with Salesforce through simple HTTP + JSON requests. 
* The REST APIs use OAuth for authentication.
* The wrapper libraries handle low-level tasks such as authentication and request and response handling.
* Each request to the APIs must include an authentication token or key.
```Node.js
var query = 'SELECT name Account'; var url = 'https://na1.salesforce.com/services/data/v20.0/query/?q=' + encodeURIComponent(query); request.get(url, { 'auth': { 'bearer': 'bearerToken' } }); 
```
* Apex HTTP callout programmatically makes a REST call to an outside app.  App receives a request with the event details payload and then performs the action.
