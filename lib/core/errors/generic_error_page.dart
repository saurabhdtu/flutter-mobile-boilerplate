import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String message;

  const ErrorPage(this.message, {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      body: SafeArea(
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(message,
                      style: const TextStyle(
                          fontSize: 22.0, color: Colors.black))))));
}
