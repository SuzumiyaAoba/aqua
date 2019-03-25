import 'dart:async';

import 'package:aqua/annict/annict.dart';
import 'package:aqua/annict/models.dart';
import 'package:aqua/client.dart';
import 'package:aqua/ui/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationPage extends StatefulWidget {
  Annict annict;

  AuthorizationPage(this.annict);

  @override
  State<StatefulWidget> createState() {
    return _AuthorizationState();
  }
}

class _AuthorizationState extends State<AuthorizationPage> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  StreamSubscription<String> _onUrlChanged;

  bool _loading = false;
  String _authorizationUrl;
  String _currentUrl;

  @override
  void initState() {
    super.initState();

    _authorizationUrl = widget.annict.getAuthorizeUrl(clientId, callback);
    _currentUrl = _authorizationUrl;

    flutterWebviewPlugin.close();

    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      var uri = Uri.parse(url);
      if (uri.scheme == "aqua" &&
          uri.authority == "callback" &&
          uri.queryParameters.containsKey("code")) {
        var code = uri.queryParameters["code"];
        if (mounted) {
          setState(() {
            _loading = true;
            _authorize(code);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("認証"),
        ),
        body: _loading
            ? LoadingDialog()
            : WebviewScaffold(
                url: _currentUrl,
                withZoom: false,
                withLocalStorage: false,
              ),
    );
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    flutterWebviewPlugin.dispose();

    super.dispose();
  }

  _saveAccessToken(AccessToken accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', accessToken.accessToken);
  }

  _authorize(String code) async {
    final token = await widget.annict
        .authorize(clientId, clientSecret, callback, code)
        .catchError((e) {
      setState(() {
        _loading = false;
        _currentUrl = _authorizationUrl;
      });
    });
    _saveAccessToken(token);
    Fluttertoast.showToast(msg: "認証に成功しました");
    Navigator.of(context).pushReplacementNamed("/home");
  }
}
