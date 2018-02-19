* Salesforce REST APIs provide a way to integrate with Salesforce through simple HTTP + JSON requests. 
* The REST APIs use OAuth for authentication.
* The wrapper libraries handle low-level tasks such as authentication and request and response handling.
* Each request to the APIs must include an authentication token or key.
```Node.js
var query = 'SELECT name Account'; var url = 'https://na1.salesforce.com/services/data/v20.0/query/?q=' + encodeURIComponent(query); request.get(url, { 'auth': { 'bearer': 'bearerToken' } }); 
```
