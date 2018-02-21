## Force.com (Salesforce) REST API

## Description
The Force.com REST API is used for integrate with Force.com applications using HTTP methods, in either XML or JSON formats. The REST APIs use OAuth for authentication.  The wrapper libraries handle low-level tasks such as authentication and request and response handling.  Each request to the APIs must include an authentication token or key.
A REST request consists of four components: a resource URI, an HTTP method, request headers, and a request body. Request headers specify metadata for the request. 
## Use Case
API for developing mobile applications or external clients.
## Limitations
* [General Salesforce REST API limitations](https://developer.salesforce.com/docs/atlas.en-us.212.0.api.meta/api/implementation_considerations.htm?SearchType=Stem)

## Implementation Steps
* Set Up OAuth 2.0
  * Create a connected app
  * From client application, make a request to the appropriate Salesforce token request endpoint that passes in grant_type, client_id, client_secret, and redirect_uri. 
  * Store the access token value as a cookie to use in all subsequent requests. 
  * Once authenticated, every request must pass in the access_token value in the header. 

## Pattern Value-add
* Ubiquitous access: Use standard HTTP method call-outs, available on every language and platform, to make requests and retrieve information from Force.com.
* Standards-based security: Utilize the OAuth protocol for authenticating your REST calls.
* Data model: Gain access to the same data model and standard objects as those in SOAP-based Web services.
* Flexible formats: Serialize data in either the XML or JSON format.
## Resources
* [Salesforce API Basics](https://trailhead.salesforce.com/modules/api_basics)
* [General Salesforce REST API limitations](https://developer.salesforce.com/docs/atlas.en-us.212.0.api.meta/api/implementation_considerations.htm?SearchType=Stem)
* [REST API](https://developer.salesforce.com/page/REST_API)
* [Which API Do I Use?](https://help.salesforce.com/articleView?id=integrate_what_is_api.htm&type=5)
* [Workbench](workbench.developerforce.com/login.php)
* [Force.com REST API Cheatsheet](http://resources.docs.salesforce.com/rel1/doc/en-us/static/pdf/SF_Rest_API_cheatsheet_web.pdf)
# Notes
* Salesforce REST APIs provide a way to integrate with Salesforce through simple HTTP + JSON requests. 
* The REST APIs use OAuth for authentication.
* The wrapper libraries handle low-level tasks such as authentication and request and response handling.
* Each request to the APIs must include an authentication token or key.

### Node.js Sample Using Nforce
```Node.js
var nforce = require('nforce');

// create the connection with the Salesforce connected app
var org = nforce.createConnection({
  clientId: process.env.CLIENT_ID,
  clientSecret: process.env.CLIENT_SECRET,
  redirectUri: process.env.CALLBACK_URL,
  mode: 'single'
});

// authenticate and return OAuth token
org.authenticate({
  username: process.env.USERNAME,
  password: process.env.PASSWORD+process.env.SECURITY_TOKEN
}, function(err, resp){
  if (!err) {
    console.log('Successfully logged in! Cached Token: ' + org.oauth.access_token);
    // execute the query
    org.query({ query: 'select id, name from account limit 5' }, function(err, resp){
      if(!err && resp.records) {
        // output the account names
        for (i=0; i<resp.records.length;i++) {
          console.log(resp.records[i].get('name'));
        }
      }
    });
  }
  if (err) console.log(err);
});
```
### Ruby Sample Using Restforce
```Ruby
require 'restforce'

// create the connection with the Salesforce connected app
client = Restforce.new :username => ENV['USERNAME'],
  :password       => ENV['PASSWORD'],
  :security_token => ENV['SECURITY_TOKEN'],
  :client_id      => ENV['CLIENT_ID'],
  :client_secret  => ENV['CLIENT_SECRET']

// execute the query
accounts = client.query("select id, name from account limit 5")

// output the account names
accounts.each do |account|
  p account.Name
end
```

* Apex HTTP callout programmatically makes a REST call to an outside app.  App receives a request with the event details payload and then performs the action.
* https://developer.salesforce.com/docs/atlas.en-us.212.0.api_rest.meta/api_rest/intro_usage_rest_resources.htm
