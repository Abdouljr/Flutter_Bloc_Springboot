import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_springboot/bloc/contact/contact.bloc.dart';
import 'package:flutter_springboot/bloc/contact/contact.state.dart';
import 'package:flutter_springboot/bloc/message/message.bloc.dart';
import 'package:flutter_springboot/bloc/message/message.state.dart';
import 'package:flutter_springboot/pages/contact/contact.page.dart';
import 'package:flutter_springboot/repositories/contact.repositorie.dart';
import 'package:flutter_springboot/repositories/message.repositie.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
void main() {
  // ICI ON ENREGISTE LES BLOCS ET LE REPOSITORY POUR POUVOIR LES INJECTER PLUS TARD
  getIt.registerLazySingleton(() => ContactRepository());
  getIt.registerLazySingleton(() => MessageRepository());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ContactsBloc(
            initialState: ContactState.initialState(),
            // ICI JE VIENS DE L'INJECTER
            contactRepository: getIt<ContactRepository>(),
          ),
        ),
        BlocProvider(
            create: (context) => MessageBloc(
                initialState: MessageState.initialState(),
                messageRepository: getIt<MessageRepository>()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: const ContactPage(),
      ),
    );
  }
}
