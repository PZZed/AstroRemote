import 'dart:async';

import 'package:astroremote/customSlider.dart';
import 'package:astroremote/customSwitch.dart';
import 'package:astroremote/remote_page.dart';
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
  Icon getActualStatus() {
    if (isConnected) {
      return const Icon(Icons.check_circle_rounded, color: Colors.green);
    } else {
      return const Icon(Icons.close_rounded, color: Colors.red);
    }
  }

  SizedBox verticalSpace = const SizedBox(height: 50);
  SizedBox horizontalSpace = const SizedBox(width: 5);

  void checkHealth(IconButton iconButton) async {
    try {
      await ServerCommand.keepAlive().then((value) => setState(() {
            isConnected = true;
            followActivated = true;
            followStdActivated = true;
            returnActivated = true;
          }));
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

  @override
  Widget build(BuildContext context) {
    IconButton iconButton = IconButton(
        icon: getActualStatus(),
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
    Timer.periodic(
        const Duration(seconds: 5), (Timer t) => checkHealth(iconButton));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Text("Astronomande"), actions: <Widget>[iconButton]),
      body: Center(
          child: Column(
        children: [
          verticalSpace,
          CustomSwitchWidget(
              "Suivi", followActivated, (value) => ServerCommand.suivi(value)),
          verticalSpace,
          CustomSwitchWidget("Suivi STD", followStdActivated,
              (value) => ServerCommand.suiviStd(value)),
          verticalSpace,
          CustomSwitchWidget("Retour", returnActivated,
              (value) => ServerCommand.retour(value)),
          verticalSpace,
          verticalSpace,
          const CustomSlider()
        ],
      )),
    );
  }
}

/// custom, switch code




