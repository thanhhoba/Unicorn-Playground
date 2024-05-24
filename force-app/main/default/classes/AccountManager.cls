@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
  @HttpGet
  global static Account getAccount() {
    RestRequest request = RestContext.request;
    // Grab the accountId from the URL
    String accountId = request.requestURI.substring(
      request.requestURI.lastIndexOf('/') -
      18, // Adjusted to fetch Account ID before /contacts
      request.requestURI.lastIndexOf('/')
    );

    // Query the account with its contacts
    Account account = [
      SELECT Id, Name, (SELECT Id, Name FROM Contacts)
      FROM Account
      WHERE Id = :accountId
      LIMIT 1
    ];

    return account;
  }
}
