public with sharing class ParkLocator {
  public static List<String> country(String ct) {
    ParkService.ParksImplPort park = new ParkService.ParksImplPort();
    return park.byCountry(ct);
  }
}
