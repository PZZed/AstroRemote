import 'package:astroremote/remote_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  // final info = NetworkInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil"),
      ),
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
  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: Colors.redAccent[700],
      inactiveColor: Colors.redAccent[300],
      value: 0,
      onChanged: (double value) {},
    );
  }
}
