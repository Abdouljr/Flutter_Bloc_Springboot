import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ErreurBouton extends StatelessWidget {
  String erreurMessage;
  Function onAction;
  ErreurBouton(
      {super.key, required this.erreurMessage, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
        ),
        Text(erreurMessage),
        ElevatedButton(
            onPressed: (() => onAction()),
            child: const Text(
              "Recharger",
              style: TextStyle(fontSize: 16),
            )),
      ],
    );
    ;
  }
}
