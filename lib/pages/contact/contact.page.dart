import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_springboot/bloc/contact/contact.action.dart';
import 'package:flutter_springboot/bloc/contact/contact.bloc.dart';
import 'package:flutter_springboot/bloc/contact/contact.state.dart';
import 'package:flutter_springboot/enums/enum.dart';
import 'package:flutter_springboot/pages/message/message.page.dart';
import 'package:flutter_springboot/widgets/contact.erreurBouton.dart';
import 'package:flutter_springboot/widgets/contacts.bouton.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    TextEditingController nomController = TextEditingController();
    TextEditingController profilController = TextEditingController();
    TextEditingController scoreController = TextEditingController();
    TextEditingController typeController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Page Contact"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ContactBouton(
                  label: "Tous contacts", contactsEvent: ChargerToutContact()),
              ContactBouton(
                  label: "Etudiants", contactsEvent: ChargerEtudiantContact()),
              ContactBouton(
                  label: "Developpeurs",
                  contactsEvent: ChargerDeveloppeurContact()),
            ],
          ),
          BlocBuilder<ContactsBloc, ContactState>(builder: (context, state) {
            if (state.requettes == Requettes.ENCOURS) {
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            } else if (state.requettes == Requettes.ERREUR) {
              return ErreurBouton(
                  erreurMessage: state.erreurMessage,
                  onAction: () {
                    context.read<ContactsBloc>().add(state.currentEvent!);
                  });
            } else if (state.requettes == Requettes.CHARGER) {
              return Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                          height: 2,
                          color: Colors.deepOrange,
                        ),
                    itemCount: state.contacts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MessagePage(
                                      contact: state.contacts[index],
                                    ))),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.deepOrange,
                                  child: Text(
                                    state.contacts[index].profil,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  state.contacts[index].nom,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.deepOrange,
                              child: Text("${state.contacts[index].score}"),
                            )
                          ],
                        ),
                      );
                    }),
              );
            } else {
              return Container();
            }
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // faire un popup de formulaire avec un bouton valider
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Ajouter un contact"),
                  content: Column(mainAxisSize: MainAxisSize.min, children: [
                    TextFormField(
                        controller: nomController,
                        decoration: const InputDecoration(
                          labelText: "Nom",
                        )),
                    TextFormField(
                        controller: scoreController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Score",
                        )),
                    TextFormField(
                        controller: profilController,
                        decoration: const InputDecoration(
                          labelText: "Profil",
                        )),
                    TextFormField(
                        controller: typeController,
                        decoration: const InputDecoration(
                          labelText: "type",
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          onPressed: (() {}), child: const Text("Enregistrer")),
                    )
                  ]),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
