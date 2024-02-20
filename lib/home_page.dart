import 'dart:async';
import 'package:astroremote/customSlider.dart';
import 'package:astroremote/customSwitch.dart';
import 'package:astroremote/wifi/server_command.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  ServerCommand serverCommand = ServerCommand();
  bool isConnected = false;

  bool followActivated = true;
  bool followStdActivated = true;
  bool returnActivated = true;
  // final info = NetworkInfo();
  var icon = const Icon(Icons.close_rounded, color: Colors.red);
  void getActualStatus() {
    if (isConnected) {
      icon = const Icon(Icons.check_circle_rounded, color: Colors.green);
    } else {
      icon = const Icon(Icons.close_rounded, color: Colors.red);
    }
  }

  _HomePage() {
    timer(iconButton);
  }
  SizedBox verticalSpace = const SizedBox(height: 100);
  SizedBox horizontalSpace = const SizedBox(width: 5);

  Future<void> checkHealth(IconButton iconButton) async {
    try {
      return ServerCommand.keepAlive()
          .then((value) => setState(() {
                isConnected = true;
                followActivated = false;
                followStdActivated = false;
                returnActivated = false;
                getActualStatus();
              }))
          .catchError((err) => {
                setState(() {
                  followActivated = false;
                  followStdActivated = false;
                  returnActivated = false;
                  isConnected = false;
                  getActualStatus();
                })
              });
    } on Exception {
      setState(() {
        followActivated = false;
        followStdActivated = false;
        returnActivated = false;
        isConnected = false;
      });
    }
  }

  Text connectedText() {
    return isConnected ? const Text("Connected") : const Text("Disconnected");
  }

  Future<void> timer(IconButton iconButton) async {
    print(DateTime.now());
    try {
      await checkHealth(iconButton);
    } on Exception {
      setState(() {
        followActivated = false;
        followStdActivated = false;
        returnActivated = false;
        isConnected = false;
        getActualStatus();
      });
    }
    await Future.delayed(const Duration(seconds: 5), () async {
      timer(iconButton);
    });
    return;
  }

  IconButton iconButton = const IconButton(
    icon: Icon(Icons.close_rounded, color: Colors.red),
    onPressed: null,
  );
  @override
  Widget build(BuildContext context) {
    iconButton = IconButton(
        icon: icon,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              Future.delayed(const Duration(milliseconds: 300), () {
                Navigator.of(context).pop(true);
              });
              return AlertDialog(
                  alignment: Alignment.topCenter, title: connectedText());
            },
          );
        });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Text("Astronomande"), actions: <Widget>[iconButton]),
      body: Center(
          child: Column(
        children: [
          verticalSpace,
          CustomSwitchWidget(),
          verticalSpace,
          const CustomSlider()
        ],
      )),
    );
  }
}

/// custom, switch code




