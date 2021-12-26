import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({Key? key}) : super(key: key);

  @override
  _LauncherPage createState() => _LauncherPage();
}

class _LauncherPage extends State<LauncherPage> {
  String _url = "https://flutter.dev";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('打开第三方APP'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () => _launchURL(),
                child: Text('打开应用'),
              ),
              RaisedButton(
                onPressed: () => _launchURL(),
                child: Text('打开地图'),
              )
            ],
          ),
        ));
  }

  void _launchURL() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  _openMap() async {
    // Android
    const url = 'geo:5.32,4.917'; // APP开发者提供的 schema
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // iOS
      const url = 'http://maps.apple.com/?ll=53.32.4.917';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw '无法打开map';
      }
    }
  }
}
