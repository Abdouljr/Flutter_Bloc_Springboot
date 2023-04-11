import 'package:flutter_springboot/models/contact.model.dart';
import 'package:flutter_springboot/models/message.model.dart';

abstract class MessagesEvent<T> {
  T payload;
  MessagesEvent(this.payload);
}

class MessageParContact extends MessagesEvent<Contact> {
  MessageParContact(Contact payload) : super(payload);
}

class AjouterMessage extends MessagesEvent<Message> {
  AjouterMessage(Message payload) : super(payload);
}
class SelectioneMessage extends MessagesEvent<Message> {
  SelectioneMessage(Message payload) : super(payload);
}
class SupprimerMessage extends MessagesEvent {
  SupprimerMessage() : super(null);
}