import 'package:flutter_springboot/bloc/contact/contact.action.dart';
import 'package:flutter_springboot/enums/enum.dart';
import 'package:flutter_springboot/models/contact.model.dart';

class ContactState {
  List<Contact> contacts;
  String erreurMessage;
  Requettes requettes;
  ContactsEvent? currentEvent;
  ContactState({
    required this.contacts,
    required this.erreurMessage,
    required this.requettes,
    required this.currentEvent,
  });

  ContactState.initialState():contacts = [], erreurMessage = "", requettes = Requettes.VIDE, currentEvent = null;
}

