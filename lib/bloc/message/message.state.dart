// ignore: avoid_web_libraries_in_flutter
import 'package:flutter_springboot/bloc/message/message.action.dart';
import 'package:flutter_springboot/enums/enum.dart';
import 'package:flutter_springboot/models/message.model.dart';

class MessageState {
  List<Message> messages;
  String erreurMessage;
  Requettes requettes;
  MessagesEvent? currentEvent;
  List<Message> messageSelectionnes;

  MessageState(
      {required this.messages,
      required this.erreurMessage,
      required this.requettes,
      required this.currentEvent,
      required this.messageSelectionnes});

// C'est ce qu'on appelle contructeur nomé
  MessageState.initialState()
      : messages = [],
        erreurMessage = "",
        requettes = Requettes.VIDE,
        currentEvent = null,
        messageSelectionnes = [];
}
