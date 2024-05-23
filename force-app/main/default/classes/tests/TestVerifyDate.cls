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
@isTest
private class TestVerifyDate {
  @isTest
  static void myUnitTest() {
    // Test when date2 is within 30 days of date1
    Date date1 = Date.newInstance(2024, 5, 1);
    Date date2Within30Days = Date.newInstance(2024, 5, 20);
    Date result = VerifyDate.checkDates(date1, date2Within30Days);
    System.assertEquals(
      date2Within30Days,
      result,
      'Expected date2 to be returned when it is within 30 days of date1'
    );

    // Test when date2 is exactly 30 days from date1
    Date date2Exactly30Days = Date.newInstance(2024, 5, 31);
    result = VerifyDate.checkDates(date1, date2Exactly30Days);
    System.assertEquals(
      date2Exactly30Days,
      result,
      'Expected date2 to be returned when it is exactly 30 days from date1'
    );

    // Test when date2 is more than 30 days from date1
    Date date2MoreThan30Days = Date.newInstance(2024, 6, 2);
    result = VerifyDate.checkDates(date1, date2MoreThan30Days);
    Date endOfMonth = Date.newInstance(2024, 5, 31);
    System.assertEquals(
      endOfMonth,
      result,
      'Expected end of the month to be returned when date2 is more than 30 days from date1'
    );

    // Test when date2 is before date1
    Date date2BeforeDate1 = Date.newInstance(2024, 4, 25);
    result = VerifyDate.checkDates(date1, date2BeforeDate1);
    System.assertEquals(
      endOfMonth,
      result,
      'Expected end of the month to be returned when date2 is before date1'
    );

    // Test the end of the month logic indirectly through checkDates
    Date dateInMonth = Date.newInstance(2024, 2, 15);
    Date endOfFebruary = Date.newInstance(2024, 2, 29);
    result = VerifyDate.checkDates(dateInMonth, dateInMonth.addDays(31)); // Using a date more than 30 days ahead
    System.assertEquals(
      endOfFebruary,
      result,
      'Expected end of February to be returned for a date in February'
    );

    // Test the leap year scenario indirectly through checkDates
    Date leapYearDate = Date.newInstance(2025, 2, 15);
    Date endOfLeapFebruary = Date.newInstance(2025, 2, 28);
    result = VerifyDate.checkDates(leapYearDate, leapYearDate.addDays(31)); // Using a date more than 30 days ahead
    System.assertEquals(
      endOfLeapFebruary,
      result,
      'Expected end of February 2024 to be returned for a leap year date'
    );
  }
}
