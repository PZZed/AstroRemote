import 'package:astroremote/wifi/server_command.dart';
import 'package:flutter/material.dart';

class CustomSwitchWidget extends StatefulWidget {

  @override
  _CustomSwitch createState() =>
      _CustomSwitch();
}

class _CustomSwitch extends State<CustomSwitchWidget> {
  /// indique pour chaque switch si il est activé
  bool isSuiviOn = false;
  bool isSuiviSTDOn = false;
  bool isRetourOn = false;

  /// en fonction du switch activé, désactive les autres 
  void _updateSwitch(int switchNumber) {
    setState(() {
      switch (switchNumber) {
        case 1:
          isSuiviOn = true;
          isSuiviSTDOn = false;
          isRetourOn = false;
          break;
        case 2:
          isSuiviOn = false;
          isSuiviSTDOn = true;
          isRetourOn = false;
          break;
        case 3:
          isSuiviOn = false;
          isSuiviSTDOn = false;
          isRetourOn = true;
          break;
      }
    });
  }

  /// Couleurs du switch 

  MaterialStateProperty<Color?> GetTrackColor(bool isOn)
  {
    return MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) 
    { return isOn ? Colors.redAccent[700] : Colors.grey[800]; },
    );
  }

   MaterialStateProperty<Color?> GetOverlayColor(bool isActive)
   {
    return MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states)
     {return isActive ?  Colors.redAccent[700] : Colors.black;});
   }


/// Création des switch 

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: 2,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          const SizedBox(width: 100, child: Text("Suivi")),
          Switch(
            value: isSuiviOn,                      // on/off
            overlayColor: GetOverlayColor(isSuiviOn),
            trackColor: GetTrackColor(isSuiviOn),
            thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
            onChanged: (bool value) {
                  _updateSwitch(1);               // met a jour les autres switchs
                    ServerCommand.suivi(value);   //Appel serveur
                    setState(() {
                      isSuiviOn = value;
                    });
                  },
          )]),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          const SizedBox(width: 100, child: Text("Suivi STD")),
          Switch(
            value: isSuiviSTDOn,                      // on/off
            overlayColor: GetOverlayColor(isSuiviSTDOn),
            trackColor: GetTrackColor(isSuiviSTDOn),
            thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
            onChanged: (bool value) {
                  _updateSwitch(2);                   // met a jour les autres switchs
                    ServerCommand.suiviStd(value);    //Appel serveur
                    setState(() {
                      isSuiviSTDOn = value;
                    });
                  },
          )]),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          const SizedBox(width: 100, child: Text("Retour")),
          Switch(
            value: isRetourOn,                      // on/off
            overlayColor: GetOverlayColor(isRetourOn),
            trackColor: GetTrackColor(isRetourOn),
            thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
            onChanged:(bool value) {
                  _updateSwitch(3);                 // met a jour les autres switchs
                    ServerCommand.retour(value);    //Appel serveur
                    setState(() {
                      isRetourOn = value;
                    });
                  },
          ),
          const SizedBox(width: 5)
        ])]));
  }
}
