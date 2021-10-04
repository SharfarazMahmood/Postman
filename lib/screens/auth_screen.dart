import 'package:flutter/material.dart';
import 'package:postman/widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _submitAuthForm(
    String email,
    String usernname,
    String password,
    bool isLogin,
  ) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Authform(submitFunc: _submitAuthForm),
    );
  }
}
