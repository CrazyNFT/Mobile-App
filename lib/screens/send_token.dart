import 'package:flutter/material.dart';
import 'package:mobile_app/services/api_call.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SendTokenPage extends StatefulWidget {
  final String? id;
  const SendTokenPage({Key? key, @required this.id}) : super(key: key);

  @override
  _SendTokenPageState createState() => _SendTokenPageState();
}

class _SendTokenPageState extends State<SendTokenPage> {
  String address = "";
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Invalid Data"),
      content: Text("Enter all fields"),
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

  showErrorDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text("An Error has occurred"),
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
              Text('Send Celo'),
              TextField(
                decoration: InputDecoration(hintText: 'Address'),
                onChanged: (value) {
                  address = value;
                },
              ),
              TextButton(
                child: Text('Send'),
                onPressed: () {
                  if (address == "") {
                    showAlertDialog(context);
                  } else {
                    setState(() {
                      _loading = true;
                    });
                    tokenTransfer(address, widget.id!).then((value) {
                      Navigator.pop(context);
                    }).catchError((error) {
                      print(error);
                      setState(() {
                        _loading = false;
                      });
                      showErrorDialog(context);
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
