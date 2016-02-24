import "dart:io";
import 'dart:convert';
// import "package:carbon/carbon.dart";
import "../Dart/lib/Carbon/lib/carbon.dart";
import 'jade.views.dart' deferred as jadeViews;
main() async {
  Map config = JSON.decode(new File('config.json').readAsStringSync());
  Carbon server = new Carbon();
  await jadeViews.loadLibrary();
  server
  ..views(jadeViews.JADE_TEMPLATES)
  // Route / to 'index' jade page.
  ..addSimpleRoute()
  // Route /what to 'pew' jade page.
  ..addSimpleRoute(path:'/what', render:'pew')
  // End of server chain.
  ..listen(InternetAddress.ANY_IP_V4, (config['chain'].toString().isNotEmpty)?443:80,chain:config['chain'],key:config['key']);
  // Redirect http to https, if we're actually using the chain!
  if(config['chain'].toString().isNotEmpty) server.forceHttps();
}
