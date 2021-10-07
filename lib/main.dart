import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:postman/screens/auth_screen.dart';
import 'package:postman/screens/chat_screen.dart';
import 'package:postman/screens/splash_screen.dart';
import 'package:postman/services/local_notification_service.dart';

//////////receive message when app is in the background and terminated.
Future<void> backgroundNtfHandler(RemoteMessage message) async {
  print(message.notification.title);
  print(message.notification.body);
  print(message.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(backgroundNtfHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.instance.subscribeToTopic('chat');

    LocalNotificationService.initialize(context);

    //// to use onMessage properly
    /// gives you the message on which user taps
    /// and it opened the app from terminated state..
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMsg = message.data['route'];
        print(routeFromMsg);
      }
    });

    //// only works on app in the foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification.title);
        print(message.notification.body);
        print(message.data.toString());
      }

      LocalNotificationService.display(message);
    });

    ///// app in the background but open(running in background)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMsg = message.data['route'];
      print(routeFromMsg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Postman',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        backgroundColor: Colors.cyan,
        accentColor: Colors.tealAccent,
        accentColorBrightness: Brightness.light,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.cyan,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return SplacshScreen();
          }
          if (userSnapshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
