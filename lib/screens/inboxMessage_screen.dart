import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saenz/data/inbox_data.dart';
import 'package:saenz/screens/explore_screen.dart';

class InboxMessageScreen extends StatefulWidget {
  final int id;
  const InboxMessageScreen(this.id, {super.key});

  @override
  State<InboxMessageScreen> createState() => _InboxMessageScreenState();
}

class _InboxMessageScreenState extends State<InboxMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Bandeja de entrada",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 255, 255, 255),
            size: 20,
          )),
      body: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${inboxData[widget.id]['date'].day} ${DateFormat('MMM').format(inboxData[widget.id]['date'])} ${inboxData[widget.id]['date'].year}, ${inboxData[widget.id]['date'].hour}:${inboxData[widget.id]['date'].minute}",
                style: const TextStyle(
                    color: Color.fromARGB(255, 150, 150, 150), fontSize: 13, fontWeight: FontWeight.bold),
              ),
              espacio(10),
              Text(
                inboxData[widget.id]['title'],
                style: const TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
              ),
              espacio(20),
              Text(
                inboxData[widget.id]['description'].split('. ').join('.\n\n'),
                style: const TextStyle(
                    color: Color.fromARGB(255, 228, 228, 228), fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
