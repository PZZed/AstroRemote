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

  ///Classe qui gère les appels au serveur
  ServerCommand serverCommand = ServerCommand();

  ///Est ce que l'application est connectée au serveur ?
  bool isConnected = false;

  ///Affiche un texte lorsque l'on clique sur l'icône de connexion
  Text connectedText() {
    return isConnected ? const Text("Connected") : const Text("Disconnected");
  }

  ///Composants génériques pour créer des espaces sur la page 
  SizedBox verticalSpace = const SizedBox(height: 100);

  ///Icône qui indique si l'application est connectée au serveur
  Icon  icon = const Icon(Icons.close_rounded, color: Colors.red);

  ///Modifie l'icone de connexion en fonction de l'état de la conenexion au serveur
  void setConnexionIcon() {
    if (isConnected) {
      icon = const Icon(Icons.check_circle_rounded, color: Colors.green);
    } else {
      icon = const Icon(Icons.close_rounded, color: Colors.red);
    }
  }

  _HomePage() {
    timer(iconButton);
  }

///Appelle le serveur pour vérifier qu'on est toujours connecté
  Future<void> checkHealth(IconButton iconButton) async {
    try {
      return ServerCommand.keepAlive()
          .then((value) => setState(() {
                isConnected = true;
                setConnexionIcon();
              }))
          .catchError((err) => {
                setState(() {
                  isConnected = false;
                  setConnexionIcon();
                })
              });
    } on Exception {
      setState(() {
        isConnected = false;
        setConnexionIcon();
      });
    }
  }

///Envoie une requête au serveur périodiquement
  Future<void> timer(IconButton iconButton) async {
    print(DateTime.now());
    try {
      await checkHealth(iconButton);
    } on Exception {
      setState(() {
        isConnected = false;
        setConnexionIcon();
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

  ///Création du corp de l'application
  @override
  Widget build(BuildContext context) {
    
    iconButton = IconButton(
      icon: icon,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(milliseconds: 300), () { Navigator.of(context).pop(true); });
            return AlertDialog(alignment: Alignment.topCenter, title: connectedText());
          },
        );
      }
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      ///Barre supériure de l'application
      appBar: AppBar(
          title: const Text("Tablette équatoriale - Remote"), actions: <Widget>[iconButton]),
      ///Corp de l'application
      body: Center(
        child: Column(
        children: [
          verticalSpace,
          CustomSwitchWidget(),     //boutons Switchs (Suivi/SuiviSTD/Retour)
          verticalSpace,
          const CustomSlider()      //Réglage de la vitesse
        ],
      )),
    );
  }
}




