import 'package:aqua/annict/annict.dart';
import 'package:aqua/authorization.dart';
import 'package:aqua/start.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'aqua',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        '/': (_) => StartPage(),
        '/authorize': (_) => AuthorizationPage(AnnictImpl()),
        '/home': (_) => HomePage(annict: AnnictImpl()),
      },
    );
  }
}


class HomePage extends StatefulWidget {
  HomePage({Key key, this.annict}) : super(key: key);

  final Annict annict;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      ),
    );
  }

  Future<String> _accessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }
}
