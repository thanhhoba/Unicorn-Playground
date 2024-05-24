public class RandomContactFactory {
  // Method to generate random contacts
  public static List<Contact> generateRandomContacts(
    Integer numContacts,
    String commonLastName
  ) {
    List<Contact> contacts = new List<Contact>();

    for (Integer i = 0; i < numContacts; i++) {
      // Create a contact with a unique first name and the common last name
      Contact contact = new Contact(
        FirstName = 'Test ' + i,
        LastName = commonLastName
      );
      contacts.add(contact);
    }

    return contacts;
  }
}
