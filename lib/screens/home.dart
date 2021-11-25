import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/screens/send_celo.dart';
import 'package:mobile_app/services/api_call.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'mint.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MintPage(),
            ),
          );
        },
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getBalance(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            'Balance',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(snapshot.data.toString()),
                          FutureBuilder(
                              future: getAddress(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: [
                                      Text(snapshot.data.toString()),
                                      TextButton(
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(
                                                text:
                                                    snapshot.data.toString()));
                                          },
                                          child: Icon(Icons.copy))
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                child: const Text('Send'),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SendCeloPage(),
                                    ),
                                  );
                                },
                              ),
                              TextButton(
                                child: const Text('Receive'),
                                onPressed: () {
                                  getAddress().then((address) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          _buildPopupDialog(context, address),
                                    );
                                  });
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context, String address) {
  return AlertDialog(
    title: const Text('QR Code'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(address),
        SizedBox(
          height: 200,
          width: 200,
          child: QrImage(
            data: address,
            version: QrVersions.auto,
            size: 200.0,
          ),
        ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          'Close',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    ],
  );
}
