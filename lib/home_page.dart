import 'dart:math';

import 'package:astroremote/remote_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  // final info = NetworkInfo();
  Icon getActualStatus(){
    //call checkHealth service
    bool isConnected = true;
    if(isConnected){
      return Icon(Icons.check_circle_rounded,color: Colors.green);
    }
    return Icon(Icons.close_rounded,color: Colors.red);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Astronomande"),
        actions: <Widget>[
          IconButton(
            icon: getActualStatus(),
            onPressed: () {},
        ) ]),
      body: Center(
          child: Column(
        children: [
          TextButton(
              onPressed: () async {
                try {
                  //  final wifiIP = await info.getWifiGatewayIP();
                  //  print(wifiIP.toString());
                } catch (e) {
                  print(e);
                }
              },
              child: Text("Liste des ips")),
          TextButton(
            child: const Text("Se connecter"),
            onPressed: () {
              // Naviguer vers la page 2
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RemotePage()));
            },
          ),
          CustomSwitchWidget(),
          CustomSwitchWidget(),
          CustomSwitchWidget(),
          CustomSlider()
        ],
      )),
    );
  }
}

/// custom, switch code
class CustomSwitchWidget extends StatefulWidget {
  @override
  _FirstCustomSwitxhWidget createState() => _FirstCustomSwitxhWidget();
}

class _FirstCustomSwitxhWidget extends State<CustomSwitchWidget> {
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

    return Switch(
      // This bool value toggles the switch.
      value: light,
      overlayColor: overlayColor,
      trackColor: trackColor,
      thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
      },
    );
  }
}

/// custom slider code
class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  _CustomSlider createState() => _CustomSlider();
}

class _CustomSlider extends State<CustomSlider> {
  double current_value = 500;
  double maxValue = 1023;
  final inputTextController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Slider slider = Slider(
          activeColor: Colors.redAccent[700],
          inactiveColor: Color.fromARGB(136, 156, 152, 152),
          value: current_value,
          max: maxValue,
          onChanged: (double value) {setState(() { current_value = value; });},
    );

    TextFormField textInput = TextFormField( 
            onChanged:(value){ setState(() {if(0 <= double.parse(value) && double.parse(value) <= maxValue){current_value = double.parse(value); }});},
            controller: inputTextController, 
            decoration: InputDecoration( border: OutlineInputBorder(), hintText: current_value.round().toString()) );

    return Column( 
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(
          width: 100,
          child: textInput), ElevatedButton(onPressed: () { return null; }, child: Text("Adapt speed"),)],)
        ,
        slider
      ]);
      
  }
}


