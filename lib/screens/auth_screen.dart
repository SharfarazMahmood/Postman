import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import 'package:postman/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm({
    String email,
    String username,
    String password,
    File userImage,
    bool isLogin,
    BuildContext ctx,
  }) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      if (!isLogin) {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        ////// .......... Image upload /////// old version
        // final StorageReference ref = FirebaseStorage.instance
        //     .ref()
        //     .child('user_images')
        //     .child(authResult.user.uid + '.jpg');
        // await ref.putFile(userImage).onComplete;
        // final url = ( await ref.getDownloadURL()).toString() ;
        // // print(url);

        ////////////Image upload
        final Reference ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(authResult.user.uid + '.jpg');
        // await ref.putFile(userImage).onComplete;
        UploadTask uploadTask = ref.putFile(userImage);
        final url = (await ref.getDownloadURL()).toString();
        // print(url);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          'username': username,
          'email': email,
          'image_url': url,
        });
      }

      // print(authResult.user);
      // print(authResult.additionalUserInfo);
    } on PlatformException catch (error) {
      // TODO
      setState(() {
        _isLoading = false;
      });
      var message = "An error occurred, please check your credentials!";
      if (error.message != null) {
        message = error.message;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Authform(
        submitFunc: _submitAuthForm,
        isLoading: _isLoading,
      ),
    );
  }
}
