import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_springboot/bloc/message/message.action.dart';
import 'package:flutter_springboot/bloc/message/message.bloc.dart';
import 'package:flutter_springboot/bloc/message/message.state.dart';
import 'package:flutter_springboot/enums/enum.dart';
import 'package:flutter_springboot/models/contact.model.dart';
import 'package:flutter_springboot/widgets/contact.erreurBouton.dart';
import 'package:flutter_springboot/widgets/formulaire.dart';

// ignore: must_be_immutable
class MessagePage extends StatelessWidget {
  Contact contact;
  MessagePage({super.key, required this.contact});
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    context.read<MessageBloc>().add(MessageParContact(contact));

    return Scaffold(
        appBar: AppBar(
            elevation: 1,
            centerTitle: true,
            title: const Text("Messages"),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<MessageBloc>().add(SupprimerMessage());
                },
                icon: BlocBuilder<MessageBloc, MessageState>(
                    builder: (context, state) =>
                        state.messageSelectionnes.isNotEmpty
                            ? const Icon(Icons.restore_from_trash_rounded)
                            : Container()),
              )
            ]),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                  child: Text(contact.profil),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  contact.nom,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
            // Permet de scrooler la page à jusqu'en bas de l'écran
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (controller.hasClients) {
                controller.jumpTo(
                  controller.position.maxScrollExtent,
                );
              }
            });
            if (state.requettes == Requettes.ENCOURS) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.requettes == Requettes.ERREUR) {
              return ErreurBouton(
                  erreurMessage: state.erreurMessage,
                  onAction: () {
                    context.read<MessageBloc>().add(state.currentEvent!);
                  });
            } else if (state.requettes == Requettes.CHARGER) {
              return Expanded(
                  child: ListView.builder(
                controller: controller,
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    selected: state.messages[index].selected,
                    selectedTileColor: Colors.grey.withOpacity(0.2),
                    selectedColor: Colors.black,
                    onLongPress: () {
                      context.read<MessageBloc>().add(
                            SelectioneMessage(state.messages[index]),
                          );
                    },
                    title: Row(
                      mainAxisAlignment:
                          state.messages[index].type == TypeMessage.ENVOI
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: state.messages[index].type == TypeMessage.ENVOI
                              ? 0
                              : 40,
                        ),
                        Flexible(
                          child: Container(
                              padding: const EdgeInsets.all(13),
                              color:
                                  state.messages[index].type == TypeMessage.RECU
                                      ? const Color.fromARGB(255, 231, 186, 119)
                                          .withOpacity(0.8)
                                      : const Color.fromARGB(255, 145, 227, 147)
                                          .withOpacity(0.8),
                              child: Text(state.messages[index].contenu)),
                        ),
                        SizedBox(
                          width: state.messages[index].type == TypeMessage.ENVOI
                              ? 40
                              : 0,
                        ),
                      ],
                    ),
                  );
                },
              ));
            } else {
              return Container();
            }
          }),
          Formulaire(contact: contact)
        ]));
  }
}
