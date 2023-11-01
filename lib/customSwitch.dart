import 'package:flutter/material.dart';

class CustomSwitchWidget extends StatefulWidget {
  
  String name;
  bool isActive;

  CustomSwitchWidget(this.name, this.isActive); //constructor

  @override
  _CustomSwitch createState() => _CustomSwitch(name, isActive, isActive);
}

class _CustomSwitch extends State<CustomSwitchWidget> {

  String name;
  bool isActive;
  bool light;

  _CustomSwitch(this.name, this.isActive, this.light); //constructor



 
  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<Color?> trackColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        // Track color when the switch is selected.
        if (isActive) {
          return light ? Colors.redAccent[700] : Colors.grey[800];
        }
        // Otherwise return null to set default track color
        // for remaining states such as when the switch is
        // hovered, focused, or disabled.
        return const Color.fromARGB(255, 30, 30, 30);
      },
    );
    final MaterialStateProperty<Color?> overlayColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        // Material color when switch is selected.
        if (isActive) {
          return Colors.redAccent[700];
        }
        // Otherwise return null to set default material color
        // for remaining states such as when the switch is
        // hovered, or focused.
        return Colors.black;
      },
    );
    return Transform.scale( scale: 2, child: Row(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        SizedBox(width: 100, child: Text(name)),
        Switch(
          // This bool value toggles the switch.
          value: light,
          overlayColor: overlayColor,
          trackColor: trackColor,
          thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
          onChanged: !isActive ? null : (bool value) {setState(() {light = value; /*TODO : call switch service*/});},
    ),
    SizedBox(width: 5)]));
    
  }
}
