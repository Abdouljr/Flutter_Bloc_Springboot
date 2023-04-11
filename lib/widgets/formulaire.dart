import 'package:flutter/material.dart';
import 'package:flutter_springboot/bloc/message/message.action.dart';
import 'package:flutter_springboot/bloc/message/message.bloc.dart';
import 'package:flutter_springboot/enums/enum.dart';
import 'package:flutter_springboot/models/contact.model.dart';
import 'package:flutter_springboot/models/message.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class Formulaire extends StatelessWidget {
  Contact contact;
  Formulaire({super.key, required this.contact});
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.bottomLeft,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: "Message",
                ),
              ),
            ),
            IconButton(
                onPressed: (() {
                  Message message = Message(
                      id: 0,
                      contenu: controller.text,
                      contactId: contact.id,
                      date: DateTime.now(),
                      type: TypeMessage.ENVOI,
                      selected: false);
                  context.read<MessageBloc>().add(AjouterMessage(message));
                  Message messageRecu = Message(
                      id: 0,
                      contenu: "reponse de ${controller.text}",
                      contactId: contact.id,
                      date: DateTime.now(),
                      type: TypeMessage.RECU,
                      selected: false);
                  context.read<MessageBloc>().add(AjouterMessage(messageRecu));
                  controller.clear();
                }),
                icon: const Icon(Icons.send))
          ],
        ));
  }
}
