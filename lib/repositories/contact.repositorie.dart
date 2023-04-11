import 'dart:math';

import 'package:flutter_springboot/models/contact.model.dart';

Map<int, Contact> contacts = {
  1: Contact(
    id: 1,
    nom: "Abdoulaziz",
    profil: "AM",
    type: "Etudiant",
    score: 10,
  ),
  2: Contact(
    id: 2,
    nom: "Sadou",
    profil: "SA",
    type: "Developpeur",
    score: 51,
  ),
  3: Contact(
    id: 3,
    nom: "Mohamed",
    profil: "MO",
    type: "Developpeur",
    score: 81,
  ),
  4: Contact(
    id: 4,
    nom: "Boubacar",
    profil: "BO",
    type: "Etudiant",
    score: 92,
  ),
  5: Contact(
    id: 5,
    nom: "Abass",
    profil: "AB",
    type: "Etudiant",
    score: 81,
  ),
  6: Contact(
    id: 6,
    nom: "Abdoulmajid",
    profil: "AB",
    type: "Etudiant",
    score: 99,
  )
};

class ContactRepository {
  int dernierId = contacts.length;
  // Retourne tous les contacts
  Future toutContacts() async {
    await Future.delayed(const Duration(seconds: 1));
    int rnd = Random().nextInt(10);
    if (rnd > 1) {
      return contacts.values.toList();
    } else {
      return "Erreur de connexion";
    }
  }

  // Retourne tous les contacts
  Future ajouterContact(Contact contact) async {
    await Future.delayed(const Duration(seconds: 1));
    int rnd = Random().nextInt(10);
    if (rnd > 1) {
      contact.id = ++dernierId;
      contacts[contact.id] = contact;
      return contact;
    } else {
      return "Numéro incorrect";
    }
  }

  // Retourne toujours un contact par type
  Future contactParType(String type) async {
    await Future.delayed(const Duration(seconds: 1));
    int rnd = Random().nextInt(10);
    if (rnd > 1) {
      return contacts.values
          .toList()
          .where((element) => element.type == type)
          .toList();
    } else {
      return "Erreur de connexion";
    }
  }
}
