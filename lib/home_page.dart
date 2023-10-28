import 'package:astroremote/customSlider.dart';
import 'package:astroremote/customSwitch.dart';
import 'package:astroremote/remote_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  // final info = NetworkInfo();
  Icon getActualStatus(){
    //TODO: call checkHealth service to knows the actual astatus of the connection
    bool isConnected = true;
    if(isConnected){
      return Icon(Icons.check_circle_rounded,color: Colors.green);
    }
    return Icon(Icons.close_rounded,color: Colors.red);
  }

  SizedBox verticalSpace = SizedBox(height: 10);
  SizedBox horizontalSpace = SizedBox(width: 5);

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
          /*TextButton(
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
          ),*/
          verticalSpace,
          CustomSwitchWidget("Suivi", true),
          verticalSpace,
          CustomSwitchWidget("Suivi STD", false),
          verticalSpace,
          CustomSwitchWidget("Retour", true),
           verticalSpace,
          CustomSlider()
        ],
      )),
    );
  }
}

/// custom, switch code




