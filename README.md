# Salesforce Integration Patterns and Practices

Apex REST Callouts, Apex SOAP Callouts, Apex Web Services

* Web service callouts to SOAP web services use XML, and typically require a WSDL.
* HTTP callouts to services typically use REST with JSON.

## Apex REST Callouts

* GET - obtain resource from the server.
* PUT - Create or replace the resource sent in the request body.
* URI - the endpoint address at which the service is located.
* JSONParser class converst it to an object.
* Apex test methods do not support callouts, the testing runtime allows to 'mock' the callout.
* To test the callouts, use mock callouts by either implementing an interface or using static resources.  When using the mock callout, the request is not sent to the endpoint.  Instead, the Apex runtime knows to look up the response specified in the static resource and returns it instead.

```Apex
Http http = new Http();
HttpRequest request = new HttpRequest();
request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
request.setMethod('GET');
HttpResponse response = http.send(request);
// If the request is successful, parse the JSON response.
if (response.getStatusCode() == 200) {
    // Deserialize the JSON string into collections of primitive data types.
    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
    // Cast the values in the 'animals' key as a list
    List<Object> animals = (List<Object>) results.get('animals');
    System.debug('Received the following animals:');
    for (Object animal: animals) {
        System.debug(animal);
    }
}
```

```Apex
Http http = new Http();
HttpRequest request = new HttpRequest();
request.setEndpoint('');
request.setMethod('POST');
request.setHeader('Content-Type', 'application/json;charset=UTF-8');
// Set the body as a JSON object
request.setBody('{"name":"mighty moose"}');
HttpResponse response = http.send(request);
if (response.getStatusCode() != 201) {
    System.debug('The status code returned was not expected: 
' + 
        response.getStatusCode() + ' ' +
 response.getStatus());
} else {
    System.debug(response.getBody());
}
```

```Apex
public class AnimalCallouts {

    public static HttpResponse makeGetCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // if the request is successful, parse the JSON resposne.
        if (response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animals' key as a list 
            List<Object> animals = (List<Object>) results.get('animals');
            System.debug('Received the following animals:');
            for (Object animal: animals) {
                System.debug(animal);
            }
         }
         return response:
    }
     
    public static HttpResponse makePostCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name":"mighty moose"}');
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if (response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
            } else {
                System.debug(response.getBody());
            }
            return response;
         }
   } 
```

### Test a Callout with StaticResourceMock

```Apex
@isTest
private class AnimalsCalloutsTest {

    @isTest static void testGetCalloutsTest() {
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test
        HttpResponse result = AnimalsCallouts.makeGetCallout();
        // Verify mock response is not null
        System.assertNotEquals(null, result, 'The callout returned a null response.');
        // Verify status code
        System.assertEquals(200,result.getStatusCode(), 'The status code is not 200.');
        // Verify content type
        System.assertEquals('application/json;charset=UTF-8',
            result.getHeader('Content-Type'),
            'The content value is not expected.');
        // Verify the array contains 3 items
        Map<String, Object> results = (Map<String, Object>)
            JSON.deserializeUntyped(result.getBody());
        List<Object> animals = (List<Object>) results.get('animals');
        System.assertEquals(3, animals.size(),
            'The array should only contain 3 items.');
        }
}
```

* [Invoking Callouts Using Apex](https://developer.salesforce.com/docs/atlas.en-us.206.0.apexcode.meta/apexcode/apex_callouts.htm)


<blockquote>
    <p></p>
</blockquote>

<p><code>There is a literal backtick (`) here.</code></p>

![Alt text](/path/to/img.jpg)

![Alt text](/path/to/img.jpg "Optional title")

<a href="http://www.youtube.com/watch?feature=player_embedded&v=YOUTUBE_VIDEO_ID_HERE
" target="_blank"><img src="http://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg" 
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>

## Pattern Template

### Name

### Context

### Problem

### Forces

### Solution

### Sketch

### Results

### Sidebars


## Pattern Summary


## Pattern Approach
 * Data Integration
 * Process Integration

## Pattern Selection Guide

| **Pattern**       | **Scenario**          |
| ------------- |:-------------:|
| *Remote Process Invocation - Request and Reply*    | Salesforce invokes a process on a remote system, waits for completion of that process, and then tracks state based on the response from the remote system. |
| *Remote Process Invocation - Fire and Forget*  |  Salesforce invokes a process in a remote system but does not wait for completion of a process.  Instead, the remote process receives and acknowledges the request and then hands off control back to Salaeforce |
| *Batch Data Synchronization* | Data stored in Force.com should be created or refreshed to reflect updates from an external system, and when changes from Force.com should be sent to an external system.  Updates in either direction are done in batch manner.      |
| *Remote Call-In* | Data stored in Force.com is created, retrieved, updated, or deleted by a remote system. |
| *UI Update Based on Data Changes* | The Salesforce user interface must be automatically updated as a result of changes to Salesforce data. | 

