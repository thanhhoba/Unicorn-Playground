@isTest
global class ParkServiceMock implements WebServiceMock {
  // The doInvoke method is called when the mock response is needed
  global void doInvoke(
    Object stub,
    Object request,
    Map<String, Object> response,
    String endpoint,
    String soapAction,
    String requestName,
    String responseNS,
    String responseName,
    String responseType
  ) {
    // start - specify the response you want to send
    // Create a response object for the SOAP method being mocked
    ParkService.byCountryResponse response_x = new ParkService.byCountryResponse();
    response_x.return_x = new List<String>{ 'Park 1', 'Park 2' };

    // Place the response object in the response map with the correct key
    response.put('response_x', response_x);
    // end
  }
}
