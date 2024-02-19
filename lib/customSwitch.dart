import 'package:astroremote/wifi/server_command.dart';
import 'package:flutter/material.dart';

class CustomSwitchWidget extends StatefulWidget {

  @override
  _CustomSwitch createState() =>
      _CustomSwitch();
}

class _CustomSwitch extends State<CustomSwitchWidget> {
  bool isSuiviOn = false;
  bool isSuiviSTDOn = false;
  bool isRetourOn = false;

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

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: 2,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          const SizedBox(width: 100, child: Text("Suivi")),
          Switch(
            // This bool value toggles the switch.
            value: isSuiviOn,
            overlayColor: GetOverlayColor(isSuiviOn),
            trackColor: GetTrackColor(isSuiviOn),
            thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
            onChanged: (bool value) {
                  _updateSwitch(1);
                    ServerCommand.suivi(value);
                    setState(() {
                      isSuiviOn = value;
                    });
                  },
          )]),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          const SizedBox(width: 100, child: Text("Suivi STD")),
          Switch(
            // This bool value toggles the switch.
            value: isSuiviSTDOn,
            overlayColor: GetOverlayColor(isSuiviSTDOn),
            trackColor: GetTrackColor(isSuiviSTDOn),
            thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
            onChanged: (bool value) {
                  _updateSwitch(2);
                    ServerCommand.suiviStd(value);
                    setState(() {
                      isSuiviSTDOn = value;
                    });
                  },
          )]),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          const SizedBox(width: 100, child: Text("Retour")),
          Switch(
            // This bool value toggles the switch.
            value: isRetourOn,
            overlayColor: GetOverlayColor(isRetourOn),
            trackColor: GetTrackColor(isRetourOn),
            thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
            onChanged:(bool value) {
                  _updateSwitch(3);
                    ServerCommand.retour(value);
                    setState(() {
                      isRetourOn = value;
                    });
                  },
          ),
          const SizedBox(width: 5)
        ])]));
  }
}
