import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_springboot/bloc/contact/contact.action.dart';
import 'package:flutter_springboot/bloc/contact/contact.bloc.dart';
import 'package:flutter_springboot/bloc/contact/contact.state.dart';

// ignore: must_be_immutable
class ContactBouton extends StatelessWidget {
  String label;
  ContactsEvent contactsEvent;
  ContactBouton({super.key, required this.label, required this.contactsEvent});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  state.currentEvent.runtimeType == contactsEvent.runtimeType
                      ? Colors.deepOrange
                      : Colors.grey.shade500,
            ),
            onPressed: (() {
              context.read<ContactsBloc>().add(contactsEvent);
            }),
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            )),
      ),
    );
  }
}
