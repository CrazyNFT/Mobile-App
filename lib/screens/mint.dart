import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/services/api_call.dart';

class MintPage extends StatefulWidget {
  @override
  _MintPageState createState() => _MintPageState();
}

class _MintPageState extends State<MintPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  File? imageFile;
  String title = "";
  String description = "";
  String artist = "";
  String minPrice = "";

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

  showConfirmDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        if (artist == "" ||
            title == "" ||
            description == "" ||
            minPrice == "" ||
            imageFile == null) {
          showAlertDialog(context);
        } else {
          _scaffoldKey.currentState?.showSnackBar(new SnackBar(
            duration: new Duration(seconds: 4),
            content: new Row(
              children: <Widget>[
                new CircularProgressIndicator(),
                new Text("  Loading...")
              ],
            ),
          ));

          uploadPhoto(imageFile!.path).then((imageUrl) {
            uploadJSON({
              'title': title,
              'description': description,
              'artist': artist,
              'image': imageUrl
            }).then(
              (uri) => lazyMint(uri, minPrice).whenComplete(
                () => Navigator.pop(context),
              ),
            );
          });
        }
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Publish NFT?"),
      content:
          Text("Are you sure you want to publish this NFT on the marketplace?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Publish NFT"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                imageFile == null
                    ? Container(
                        child: Text('No Image selected'),
                      )
                    : Container(
                        child: Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        ),
                      ),
                Container(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            _getFromGallery();
                          },
                          child: const Text("PICK FROM GALLERY"),
                        ),
                        Container(
                          height: 40.0,
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: 'Title'),
                          onChanged: (value) {
                            title = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: 'Description'),
                          onChanged: (value) {
                            description = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: 'Artist'),
                          onChanged: (value) {
                            artist = value;
                          },
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(hintText: 'Minimum Price'),
                          onChanged: (value) {
                            minPrice = value;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[+-]?([0-9]*[.])?[0-9]+')),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            showConfirmDialog(context);
                          },
                          child: Text('Publish'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  /// Get from gallery
  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}
