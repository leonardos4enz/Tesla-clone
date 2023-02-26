import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saenz/data/inbox_data.dart';
import 'package:saenz/screens/inboxMessage_screen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
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
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: Color.fromARGB(255, 255, 255, 255),
              size: 20,
            )),
        body: Column(
          children: [
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: inboxData.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.all(20),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            inboxData[index]['title'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 202, 202, 202),
                                fontSize: 18,
                                fontFamily: 'SanFranciscoPro',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Text(
                          "${inboxData[index]['date'].day} ${DateFormat('MMM').format(inboxData[index]['date'])}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                    dense: true,
                    subtitle: Container(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        inboxData[index]['description'],
                        textAlign: TextAlign.justify,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 202, 202, 202),
                            fontFamily: 'SanFranciscoPro',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => InboxMessageScreen(inboxData[index]['id'])));
                    },
                  );
                },
              ),
            )
          ],
        ));
  }
}
