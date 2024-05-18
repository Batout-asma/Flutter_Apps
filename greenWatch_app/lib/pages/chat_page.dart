import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String? userEmail;
  final String ownerEmail;
  const ChatPage(
      {super.key, required this.userEmail, required this.ownerEmail});

  @override
  Widget build(BuildContext context) {
    var ownername = ownerEmail.split('@')[0];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green[600],
        title: Text(
          'Chat with $ownername',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
