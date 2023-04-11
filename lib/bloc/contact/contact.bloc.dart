// ignore_for_file: constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:flutter_springboot/bloc/contact/contact.action.dart';
import 'package:flutter_springboot/bloc/contact/contact.state.dart';
import 'package:flutter_springboot/enums/enum.dart';
import 'package:flutter_springboot/repositories/contact.repositorie.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactState> {
  ContactRepository contactRepository;
  ContactsBloc(
      {required ContactState initialState, required this.contactRepository})
      : super(initialState) {
    on<ContactsEvent>((event, emit) async {
      if (event is ChargerToutContact) {
        emit(ContactState(
            contacts: state.contacts,
            requettes: Requettes.ENCOURS,
            erreurMessage: "",
            currentEvent: event));
        final data = await contactRepository.toutContacts();

        try {
          emit(ContactState(
              contacts: data,
              requettes: Requettes.CHARGER,
              erreurMessage: "",
              currentEvent: event));
        } catch (e) {
          emit(ContactState(
              contacts: state.contacts,
              requettes: Requettes.ERREUR,
              erreurMessage: data,
              currentEvent: event));
        }
      } else if (event is ChargerEtudiantContact) {
        emit(ContactState(
            contacts: state.contacts,
            requettes: Requettes.ENCOURS,
            erreurMessage: "",
            currentEvent: event));
        final data = await contactRepository.contactParType("Etudiant");

        try {
          emit(ContactState(
              contacts: data,
              requettes: Requettes.CHARGER,
              erreurMessage: "",
              currentEvent: event));
        } catch (e) {
          emit(ContactState(
              contacts: state.contacts,
              requettes: Requettes.ERREUR,
              erreurMessage: data,
              currentEvent: event));
        }
      } else if (event is ChargerDeveloppeurContact) {
        emit(ContactState(
            contacts: state.contacts,
            requettes: Requettes.ENCOURS,
            erreurMessage: "",
            currentEvent: event));
        final data = await contactRepository.contactParType("Developpeur");

        try {
          emit(ContactState(
              contacts: data,
              requettes: Requettes.CHARGER,
              erreurMessage: "",
              currentEvent: event));
        } catch (e) {
          emit(ContactState(
              contacts: state.contacts,
              requettes: Requettes.ERREUR,
              erreurMessage: data,
              currentEvent: event));
        }
      }
    });
  }
}
