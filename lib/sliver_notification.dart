import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_functions_desktop/firebase_functions_desktop.dart';

late FirebaseFunctions functions;

class Notificat extends StatefulWidget {
  const Notificat({Key? key}) : super(key: key);

  @override
  State<Notificat> createState() => _NotificatState();
}

class _NotificatState extends State<Notificat> {
  // @override
  // void initState() {
  //   super.initState();
  //   initFirebase();
  // }

  // Future initFirebase() async {
  //   await Firebase.initializeApp();
  // }
  // final functions = FirebaseFunctions.instance;
  bool secureText = true;
  Future<void> Notification() async {
    // await FirebaseMessaging.instance.subscribeToTopic("AllPushNotifications2");
    // await Firebase.initializeApp();

    final results = await FirebaseFunctions.instance
        .httpsCallable('waterradio')
        .call(<String, dynamic>{
      'title': _minLength.text,
      'body': _minLengthMessage.text,
    });
  }

  TextEditingController _minLength = TextEditingController();
  TextEditingController _minLengthMessage = TextEditingController();
  TextEditingController passwordText = TextEditingController();

  String? lengthError;
  String? messageError;
  String? passwordError;
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  //
                  width: double.maxFinite,
                  padding: EdgeInsets.all(8),
                  child: Center(
                      child: Text(
                    'Push Notifications',
                    style: TextStyle(fontSize: 20),
                  ))),
            ),
            backgroundColor: Colors.blue[600],
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'lib/icons/waterNew.jpg',
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                      child: Text(
                    'Push Notifications are used to notify users of any programe, The user gets the notification immediately if online or gets the notification immediately it gets online if offline. Use discreetly!',
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _minLength,
                    maxLength: 25,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Notification Title',
                      labelText: 'Title',
                      errorText: lengthError,
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _minLengthMessage,
                    maxLength: 150,
                    maxLines: 5,
                    decoration: InputDecoration(
                      errorText: messageError,
                      border: OutlineInputBorder(),
                      hintText: 'Notification Body',
                      labelText: 'Message',
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: passwordText,
                    obscureText: secureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            secureText = !secureText;
                          });
                        },
                        icon: Icon(
                            secureText ? Icons.remove_red_eye : Icons.security),
                      ),
                      errorText: passwordError,
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'password',
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 33),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.green,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_minLength.text.length < 4) {
                          lengthError = "Enter at least 4 char";
                          print(lengthError);
                        } else {
                          lengthError = null;
                          print(_minLength.text);
                        }
                        if (_minLengthMessage.text.length < 5) {
                          messageError = "Enter at least 5 char";

                          print(lengthError);
                        } else {
                          messageError = null;

                          print(_minLengthMessage.text);
                        }
                        if (passwordText.text != 'admin@waterradio') {
                          passwordError = "Wrong Password";
                        } else {
                          passwordError = null;

                          print(_minLengthMessage.text);
                        }
                        if (_minLength.text.length > 4 &&
                            _minLengthMessage.text.length > 5 &&
                            passwordText.text == 'admin@waterradio') {
                          print('Notification');
                          Notification();
                        }
                      });
                    },
                    child: Text('Send Push', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
