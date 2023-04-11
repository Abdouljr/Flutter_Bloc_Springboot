import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_springboot/bloc/message/message.action.dart';
import 'package:flutter_springboot/bloc/message/message.state.dart';
import 'package:flutter_springboot/enums/enum.dart';
import 'package:flutter_springboot/models/message.model.dart';
import 'package:flutter_springboot/repositories/message.repositie.dart';

class MessageBloc extends Bloc<MessagesEvent, MessageState> {
  MessageRepository messageRepository;
  MessageBloc(
      {required MessageState initialState, required this.messageRepository})
      : super(initialState) {
    on<MessagesEvent>((event, emit) async {
      // RECUPER TOUT LES MESSAGES PAR CONTACT
      if (event is MessageParContact) {
        emit(MessageState(
            messages: state.messages,
            requettes: Requettes.ENCOURS,
            erreurMessage: "",
            messageSelectionnes: state.messageSelectionnes,
            currentEvent: event));
        final data =
            await messageRepository.messageParContact(event.payload.id);
        try {
          emit(MessageState(
              messages: data,
              requettes: Requettes.CHARGER,
              erreurMessage: "",
              messageSelectionnes: state.messageSelectionnes,
              currentEvent: event));
        } catch (e) {
          emit(MessageState(
              messages: state.messages,
              requettes: Requettes.ERREUR,
              erreurMessage: data,
              messageSelectionnes: state.messageSelectionnes,
              currentEvent: event));
        }

        // AJOUTER UN MESSAGE
      } else if (event is AjouterMessage) {
        final message = await messageRepository.ajouterMessage(event.payload);
        try {
          List<Message> messages = [...state.messages];
          (message as Message).date = DateTime.now();
          messages.add(message);
          emit(MessageState(
              messages: messages,
              requettes: Requettes.CHARGER,
              erreurMessage: "",
              currentEvent: event,
              messageSelectionnes: state.messageSelectionnes));
        } catch (e) {
          emit(MessageState(
              messages: state.messages,
              requettes: Requettes.ERREUR,
              erreurMessage: message,
              currentEvent: event,
              messageSelectionnes: state.messageSelectionnes));
        }
      } else if (event is SelectioneMessage) {
        List<Message> messages = [...state.messages];
        List<Message> messagesSelected = [];
        for (Message m in messages) {
          if (m.id == event.payload.id) {
            m.selected = !m.selected;
          }
          if (m.selected == true) {
            messagesSelected.add(m);
          } else {
            messagesSelected.removeWhere((message) => message.id == m.id);
          }
          emit(MessageState(
              messages: messages,
              requettes: Requettes.CHARGER,
              erreurMessage: "",
              messageSelectionnes: messagesSelected,
              currentEvent: event));
        }
      } else if (event is SupprimerMessage) {
        List<Message> messages = [...state.messageSelectionnes];

        try {
          for (Message m in messages) {
            await messageRepository.supprimerMessage(m);
            state.messages.removeWhere((message) => message.id == m.id);
          }
          emit(MessageState(
              messages: state.messages,
              requettes: Requettes.CHARGER,
              erreurMessage: "",
              messageSelectionnes: state.messageSelectionnes,
              currentEvent: event));
          state.messageSelectionnes.clear();
        } catch (e) {
          // emit(MessageState(
          //     messages: state.messages,
          //     requettes: Requettes.ERREUR,
          //     erreurMessage: e.toString(),
          //     messageSelectionnes: state.messageSelectionnes,
          //     currentEvent: event));
        }
      }
    });
  }
}
