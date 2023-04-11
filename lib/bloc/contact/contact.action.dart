abstract class ContactsEvent {}

// abstract class AjouterContactEvent<Contact> {
//   Contact contact;
//   AjouterContactEvent(this.contact);
// }

class ChargerToutContact extends ContactsEvent {}

class ChargerEtudiantContact extends ContactsEvent {}

class ChargerDeveloppeurContact extends ContactsEvent {}

// class AjouterUnContact extends AjouterContactEvent<Contact> {
//   AjouterUnContact(Contact contact) : super(contact);
// }
