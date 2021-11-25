import 'package:flutter/material.dart';
import 'package:mobile_app/screens/send_token.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class TokenInfoPage extends StatefulWidget {
  final Map<String, dynamic>? doc;
  final String? id;
  const TokenInfoPage({Key? key, @required this.doc, @required this.id})
      : super(key: key);

  @override
  _TokenInfoPageState createState() => _TokenInfoPageState();
}

class _TokenInfoPageState extends State<TokenInfoPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: SafeArea(
          child: Column(
            children: [
              Image.network(widget.doc!['image']),
              Container(
                child: Text(
                  widget.doc!['title'],
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                widget.doc!['description'],
              ),
              Text(
                widget.doc!['artist'],
              ),
              Text(
                widget.id!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                child: Text('Send'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SendTokenPage(
                        id: widget.id!,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
