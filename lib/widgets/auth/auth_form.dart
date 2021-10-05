import 'package:flutter/material.dart';

class Authform extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String username,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) submitFunc;
  const Authform({
    Key key,
    this.submitFunc,
    this.isLoading,
  }) : super(key: key);

  @override
  State<Authform> createState() => _AuthformState();
}

class _AuthformState extends State<Authform> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFunc(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword,
        _isLogin,
        context,
      );

      // use these values to sent to auth request............
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter a email address.";
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return "Enter a valid email address.";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  // const SizedBox(height: 4),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter a username.";
                        }
                        if (value.length < 4) {
                          return "Username must be at least 4 characters long";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Username",
                      ),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  // const SizedBox(height: 4),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter a password.";
                      }
                      if (value.length < 7) {
                        return "Password must be at least 7 characters long";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Password",
                    ),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  const SizedBox(height: 12),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text(_isLogin ? "Login" : 'Signup'),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'Already have an acoount'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}