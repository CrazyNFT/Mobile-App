import 'package:flutter/material.dart';
import 'package:mobile_app/services/api_call.dart';

class TransfersPage extends StatefulWidget {
  const TransfersPage({Key? key}) : super(key: key);

  @override
  _TransfersPageState createState() => _TransfersPageState();
}

class _TransfersPageState extends State<TransfersPage> {
  @override
  void initState() {
    super.initState();
    tokenTransfers().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
