import 'package:http/http.dart' as http;

class ServerCommand {
  static const serverUrl = 'http://192.168.1.11:3000/astroremote/';

  static const keepAliveUrl = '${serverUrl}keep_alive';
  static const connectUrl = '${serverUrl}connect';

  static const retourOnUrl = '${serverUrl}bp_retour/on';
  static const retourOffUrl = '${serverUrl}bp_retour/off';

  static const suiviOnUrl = '${serverUrl}bp_suivi/on';
  static const suiviOffUrl = '${serverUrl}bp_retour/off';

  static const suiviStdOnUrl = '${serverUrl}bp_suivi_std/on';
  static const suiviStdOffUrl = '${serverUrl}bp_suivi_std/off';

  static const speedUrl = '${serverUrl}set_speed';

  static getHeaders() {
    return <String, String>{'Content-Type': 'application/json; charset=UTF-8'};
  }

  // Keep alive : should response pong
  // 5 second de timeout
  static Future<http.Response> keepAlive() {
    return http.get(Uri.parse(keepAliveUrl), headers: getHeaders());
  }

  static Future<http.Response> connect() {
    return http.post(Uri.parse(connectUrl), headers: getHeaders(), body: {});
  }

  static Future<http.Response> retour(bool on) {
    String url = on ? retourOnUrl : retourOffUrl;
    print(on ? "retour on" : "retour off");
    if(on) {
      suiviStd(false);
      suivi(false);
      }
    return http.get(Uri.parse(url), headers: getHeaders());
  }

  static Future<http.Response> suiviStd(bool on) {
    String url = on ? suiviStdOnUrl : suiviStdOffUrl;
    print(on ? "std on" : "std off");
    if(on) {
      suivi(false);
      retour(false);
      }
    return http.get(Uri.parse(url), headers: getHeaders());
  }

  static Future<http.Response> suivi(bool on) {
    String url = on ? suiviOnUrl : suiviOffUrl;
    print(on ? "suivi on" : "suivi off");
    if(on) {
      suiviStd(false);
      retour(false);
      }
    return http.get(Uri.parse(url), headers: getHeaders());
  }
}
