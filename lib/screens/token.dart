import 'package:flutter/material.dart';
import 'package:mobile_app/screens/token_info.dart';
import 'package:mobile_app/services/api_call.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class TokenPage extends StatefulWidget {
  const TokenPage({Key? key}) : super(key: key);

  @override
  _TokenPageState createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getOwnedURI(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final val = snapshot.data as List<dynamic>;
                  final nfts = val
                      .map((title) => title as Map<String, dynamic>)
                      .toList();
                  if (nfts.length == 0) {
                    return Center(
                      child: Text('You own no tokens'),
                    );
                  } else {
                    return GridView.count(
                        crossAxisCount: 2,
                        children: nfts.map((nft) {
                          return FutureBuilder(
                              future: getNFT(nft['uri']),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final metadata =
                                      snapshot.data as Map<String, dynamic>;
                                  return GestureDetector(
                                    child: Column(
                                      children: [
                                        Image.network(metadata['image']),
                                        Text(metadata['title'])
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => TokenInfoPage(
                                            doc: metadata,
                                            id: nft['tokenId'],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              });
                        }).toList());
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
