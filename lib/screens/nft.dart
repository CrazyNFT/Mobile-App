import 'package:flutter/material.dart';
import 'package:mobile_app/services/api_call.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class NFTPage extends StatefulWidget {
  final Map<String, dynamic>? doc;
  final String? minPrice;
  final String? id;
  const NFTPage(
      {Key? key,
      @required this.doc,
      @required this.minPrice,
      @required this.id})
      : super(key: key);

  @override
  _NFTPageState createState() => _NFTPageState();
}

class _NFTPageState extends State<NFTPage> {
  bool _loading = false;

  showAlertDialog(BuildContext context, String error) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(error),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
                widget.minPrice!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                child: Text('Buy'),
                onPressed: () {
                  setState(() {
                    _loading = true;
                  });
                  redeem(widget.id!).then((value) {
                    Navigator.pop(context);
                  }).catchError((error) {
                    setState(() {
                      _loading = false;
                    });
                    showAlertDialog(context, error);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
