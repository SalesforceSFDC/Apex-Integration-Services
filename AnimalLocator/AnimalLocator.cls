/**
The Apex class must be called 'AnimalLocator', have a 'getAnimalNameById' method that accepts an Integer and returns a String.
The 'getAnimalNameById' method must call https://th-apex-http-callout.herokuapp.com/animals/:id, 
using the ID passed into the method. 
The method returns the value of the 'name' property (i.e., the animal name).
**/

public class AnimalLocator {
  
  public static HttpResponse makeGetCallout {
      Http http = new Http();
      HttpRequest request = new HttpRequest();
      request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/:id');
      request.setMethod('GET');
  }
}
