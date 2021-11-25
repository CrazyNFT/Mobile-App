import 'package:flutter/material.dart';
import 'package:mobile_app/services/api_call.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class SendCeloPage extends StatefulWidget {
  const SendCeloPage({Key? key}) : super(key: key);

  @override
  _SendCeloPageState createState() => _SendCeloPageState();
}

class _SendCeloPageState extends State<SendCeloPage> {
  String address = "";
  String value = "";
  bool _loading = false;

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
                decoration: InputDecoration(hintText: 'Value'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (amount) {
                  value = amount;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Address'),
                onChanged: (value) {
                  address = value;
                },
              ),
              TextButton(
                child: Text('Send'),
                onPressed: () {
                  if (address == "" || value == "") {
                    showAlertDialog(context);
                  } else {
                    setState(() {
                      _loading = true;
                    });
                    sendCelo(address, value).then((value) {
                      Navigator.pop(context);
                    }).catchError((error) {
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
