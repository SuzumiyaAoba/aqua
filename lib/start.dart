import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartPage extends StatefulWidget {

    @override
    State<StatefulWidget> createState() => _StartState();
}

class _StartState extends State<StartPage> {

    @override
    void initState() {
        super.initState();

        _isAuthorized().then((authorized) {
            if (authorized) {
                Navigator.of(context).pushReplacementNamed('/home');
            } else {
                Navigator.of(context).pushReplacementNamed('/authorize');
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
                body: Center(
        child: CircularProgressIndicator(),
        )
        );
    }

    Future<bool> _isAuthorized() async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('access_token');
        return token != null;
    }
}
