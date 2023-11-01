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

  SizedBox verticalSpace = SizedBox(height: 50);
  SizedBox horizontalSpace = SizedBox(width: 5);

  @override
  Widget build(BuildContext context) {

    IconButton iconButton = IconButton(
            icon: getActualStatus(),
            onPressed: () {showDialog(
                      context: context,
                      builder: (context) {
                        Future.delayed(Duration(milliseconds: 300), () {
                          Navigator.of(context).pop(true);
                        });
                        return AlertDialog(
                          alignment: Alignment.topCenter,
                          title: Text("Connected" /* TODO : display a different message if not connected */),
                        );
                      });},
        );


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Astronomande"),
        actions: <Widget>[iconButton]),
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
          CustomSwitchWidget("Retour", false),
          verticalSpace,
          verticalSpace,
          CustomSlider()
        ],
      )),
    );
  }
}

/// custom, switch code




