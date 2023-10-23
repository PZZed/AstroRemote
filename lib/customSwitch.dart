import 'package:flutter/material.dart';

class CustomSwitchWidget extends StatefulWidget {
  
  String name;

  CustomSwitchWidget(this.name); //constructor

  @override
  _CustomSwitch createState() => _CustomSwitch(name);
}

class _CustomSwitch extends State<CustomSwitchWidget> {
  String name;
  _CustomSwitch(this.name); //constructor

  bool light = true;

 
  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<Color?> trackColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        // Track color when the switch is selected.
        if (states.contains(MaterialState.selected)) {
          return Colors.redAccent[700];
        }
        // Otherwise return null to set default track color
        // for remaining states such as when the switch is
        // hovered, focused, or disabled.
        return null;
      },
    );
    final MaterialStateProperty<Color?> overlayColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        // Material color when switch is selected.
        if (states.contains(MaterialState.selected)) {
          return Colors.redAccent[700];
        }
        // Material color when switch is disabled.
        if (states.contains(MaterialState.disabled)) {
          return Colors.black;
        }
        // Otherwise return null to set default material color
        // for remaining states such as when the switch is
        // hovered, or focused.
        return null;
      },
    );
    return Column(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        Text(name), 
        Switch(
          // This bool value toggles the switch.
          value: light,
          overlayColor: overlayColor,
          trackColor: trackColor,
          thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
          onChanged: (bool value) {setState(() {light = value; /*TODO : call switch service*/});
      },
    ),
    SizedBox(width: 5)]);
    
  }
}
