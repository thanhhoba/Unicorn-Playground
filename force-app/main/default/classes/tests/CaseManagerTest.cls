/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 *
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@IsTest
private class CaseManagerTest {
  @isTest
  static void testGetCaseById() {
    Id recordId = createTestRecord();
    // Set up a test request
    RestRequest request = new RestRequest();
    request.requestUri =
      'https://yourInstance.my.salesforce.com/services/apexrest/Cases/' +
      recordId;
    request.httpMethod = 'GET';
    RestContext.request = request;
    // Call the method to test
    Case thisCase = CaseManager.getCaseById();
    // Verify results
    Assert.isTrue(thisCase != null);
    Assert.areEqual('Test record', thisCase.Subject);
  }

  @isTest
  static void testCreateCase() {
    // Call the method to test
    ID thisCaseId = CaseManager.createCase(
      'Ferocious chipmunk',
      'New',
      'Phone',
      'Low'
    );
    // Verify results
    Assert.isTrue(thisCaseId != null);
    Case thisCase = [SELECT Id, Subject FROM Case WHERE Id = :thisCaseId];
    Assert.isTrue(thisCase != null);
    Assert.areEqual(thisCase.Subject, 'Ferocious chipmunk');
  }

  @isTest
  static void testDeleteCase() {
    Id recordId = createTestRecord();
    // Set up a test request
    RestRequest request = new RestRequest();
    request.requestUri =
      'https://yourInstance.my.salesforce.com/services/apexrest/Cases/' +
      recordId;
    request.httpMethod = 'DELETE';
    RestContext.request = request;
    // Call the method to test
    CaseManager.deleteCase();
    // Verify record is deleted
    List<Case> cases = [SELECT Id FROM Case WHERE Id = :recordId];
    Assert.isTrue(cases.size() == 0);
  }

  @isTest
  static void testUpsertCase() {
    // 1. Insert new record
    ID case1Id = CaseManager.upsertCase(
      'Ferocious chipmunk',
      'New',
      'Phone',
      'Low',
      null
    );
    // Verify new record was created
    Assert.isTrue(Case1Id != null);
    Case case1 = [SELECT Id, Subject FROM Case WHERE Id = :case1Id];
    Assert.isTrue(case1 != null);
    Assert.areEqual(case1.Subject, 'Ferocious chipmunk');
    // 2. Update status of existing record to Working
    ID case2Id = CaseManager.upsertCase(
      'Ferocious chipmunk',
      'Working',
      'Phone',
      'Low',
      case1Id
    );
    // Verify record was updated
    Assert.areEqual(case1Id, case2Id);
    Case case2 = [SELECT Id, Status FROM Case WHERE Id = :case2Id];
    Assert.isTrue(case2 != null);
    Assert.areEqual(case2.Status, 'Working');
  }

  @isTest
  static void testUpdateCaseFields() {
    Id recordId = createTestRecord();
    RestRequest request = new RestRequest();
    request.requestUri =
      'https://yourInstance.my.salesforce.com/services/apexrest/Cases/' +
      recordId;
    request.httpMethod = 'PATCH';
    request.addHeader('Content-Type', 'application/json');
    request.requestBody = Blob.valueOf('{"status": "Working"}');
    RestContext.request = request;
    // Update status of existing record to Working
    ID thisCaseId = CaseManager.updateCaseFields();
    // Verify record was updated
    Assert.isTrue(thisCaseId != null);
    Case thisCase = [SELECT Id, Status FROM Case WHERE Id = :thisCaseId];
    Assert.isTrue(thisCase != null);
    Assert.areEqual(thisCase.Status, 'Working');
  }
  // Helper method
  static Id createTestRecord() {
    // Create test record
    Case caseTest = new Case(
      Subject = 'Test record',
      Status = 'New',
      Origin = 'Phone',
      Priority = 'Medium'
    );
    insert caseTest;
    return caseTest.Id;
  }
}
