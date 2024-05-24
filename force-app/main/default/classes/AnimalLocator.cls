public with sharing class AnimalLocator {
  public static String getAnimalNameById(Integer id) {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(
      'https://th-apex-http-callout.herokuapp.com/animals/' + id
    );
    request.setMethod('GET');
    HttpResponse response = http.send(request);

    // If the request is successful, parse the JSON response.
    if (response.getStatusCode() == 200) {
      // Deserializes the JSON string into a map
      Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(
        response.getBody()
      );

      // Cast the 'animal' key to a map and extract the name
      if (results.containsKey('animal')) {
        Map<String, Object> animal = (Map<String, Object>) results.get(
          'animal'
        );
        if (animal.containsKey('name')) {
          return (String) animal.get('name');
        }
      }
    }
    return 'No animal found in the response.';
  }
}
