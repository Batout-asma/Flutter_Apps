import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_watch_app/components/chat_bubble.dart';
import 'package:green_watch_app/components/my_textfield.dart';
import 'package:green_watch_app/services/chat.dart';

class ChatPage extends StatefulWidget {
  final String? userEmail;
  final String ownerEmail;
  const ChatPage(
      {super.key, required this.userEmail, required this.ownerEmail});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final String currentUserEmail =
      FirebaseAuth.instance.currentUser!.email.toString();
  final ScrollController scrollController = ScrollController();

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(widget.ownerEmail, messageController.text);
      messageController.clear();
      scrollToBottom();
    }
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var ownername = widget.ownerEmail.split('@')[0];
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
      body: Column(
        children: [
          // messages
          Expanded(
            child: messagesList(),
          ),

          // user input
          messageInput(),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  // message list
  Widget messagesList() {
    return StreamBuilder(
        stream: chatService.getMessages(widget.ownerEmail, currentUserEmail),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading..');
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollToBottom();
          });
          return ListView(
            controller: scrollController,
            children: snapshot.data!.docs
                .map((document) => messageItem(document))
                .toList(),
          );
        });
  }

  // message item
  Widget messageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // user messages to the right and other t the left
    var alignment = (data['senderEmail'] == currentUserEmail)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    var name = data['senderEmail'].split('@')[0];

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: (data['senderEmail'] == currentUserEmail)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderEmail'] == currentUserEmail)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Text(name),
            const SizedBox(
              height: 5,
            ),
            ChatBubble(message: data['message']),
          ],
        ),
      ),
    );
  }

  // message input
  Widget messageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: messageController,
              hintText: 'Enter message',
              obscureText: false,
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.arrow_upward_rounded,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
