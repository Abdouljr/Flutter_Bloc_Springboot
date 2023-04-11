import 'dart:math';

import 'package:flutter_springboot/enums/enum.dart';
import 'package:flutter_springboot/models/message.model.dart';

Map<int, Message> messages = {
  1: Message(
      id: 1,
      contenu: "Bonjour",
      contactId: 1,
      date: DateTime.now(),
      type: TypeMessage.ENVOI,
      selected: false),
  2: Message(
      id: 2,
      contenu: "Salut",
      contactId: 3,
      date: DateTime.now(),
      type: TypeMessage.RECU,
      selected: false),
  3: Message(
      id: 3,
      contenu: "Comment vas-tu",
      contactId: 3,
      date: DateTime.now(),
      type: TypeMessage.ENVOI,
      selected: false),
  4: Message(
      id: 4,
      contenu:
          "je veux bien je veux bien te parler d'une chose qui tu pouras oublier",
      contactId: 3,
      date: DateTime.now(),
      type: TypeMessage.RECU,
      selected: false),
  5: Message(
      id: 5,
      contenu: "Bonjour ",
      contactId: 3,
      date: DateTime.now(),
      type: TypeMessage.ENVOI,
      selected: false),
};

class MessageRepository {
  int messageId = messages.length;

  Future ajouterMessage(Message message) async {
    await Future.delayed(const Duration(seconds: 1));
    int rnd = Random().nextInt(10);
    if (rnd > 1) {
      message.id = ++messageId;
      messages[message.id] = message;
      return message;
    } else {
      return "Message non envoyé";
    }
  }

  Future messageParContact(int contactId) async {
    await Future.delayed(const Duration(seconds: 1));
    int rnd = Random().nextInt(10);
    if (rnd > 1) {
      return messages.values
          .toList()
          .where((element) => element.contactId == contactId)
          .toList();
    } else {
      return "Probleme de connexion";
    }
  }

  Future supprimerMessage(Message message) async {
    await Future.delayed(const Duration(seconds: 1));
    int rnd = Random().nextInt(10);
    if (rnd >= 1) {
      messages.remove(message.id);
    } else {
      throw "Probleme de suppression";
    }
  }
}
