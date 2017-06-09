/**
The Apex class must be called 'AnimalLocator', have a 'getAnimalNameById' method that accepts an Integer and returns a String.
**/

public class AnimalLocator {
  
  public static HttpResponse makeGetCallout {
      Http http = new Http();
      HttpRequest request = new HttpRequest();
      request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/:id');
      request.setMethod('GET');
  }
}
