import 'dart:io';

import 'package:astroremote/home_page.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MaterialApp(home: HomePage()));
  requestPermission();
}

Future<void> requestPermission() async {
  if (Platform.isAndroid) {
    print("Checking for android permissions");
    var status = await Permission.location.status;
    print(status);
    if (status.isDenied || status.isPermanentlyDenied || status.isRestricted) {
      if (await Permission.location.request().isGranted) {
        final info = (NetworkInfo());
        print(await (info.getWifiIP()));
        print(await (info.getWifiBSSID()));
        print(await (info.getWifiGatewayIP()));
        print(await (info.getWifiName()));

        print("Location granted");
      } else {
        print("Location denied");
      }
    } else {
      print("Location already granted");
    }
  }
}
