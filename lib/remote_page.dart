import 'package:flutter/material.dart';

class RemotePage extends StatefulWidget {
  @override
  RemoteState createState() => RemoteState();
}

class RemoteState extends State<RemotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 2"),
      ),
      body: Center(
          child: Column(
        children: [
          const Text("This is Page 2"),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("MDR"),
          )
        ],
      )),
    );
  }
}
