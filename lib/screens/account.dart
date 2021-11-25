import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/screens/login.dart';
import 'package:mobile_app/services/api_call.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/services/authentication.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String address = "";

  @override
  void initState() {
    super.initState();
    getAddress().then((value) {
      setState(() {
        address = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('Account'),
          Image.network(auth.currentUser!.photoURL!),
          Text(auth.currentUser!.displayName!),
          Text(address),
          TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: address));
              },
              child: Icon(Icons.copy)),
          TextButton(
            child: Text('Sign Out'),
            onPressed: () async {
              await Authentication.signOut(context: context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
