import 'package:flutter/material.dart';
import 'package:mobile_app/screens/nft.dart';
import 'package:mobile_app/services/api_call.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({Key? key}) : super(key: key);

  @override
  _MarketplacePageState createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
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
          FutureBuilder(
            future: getWithdrawBalance(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text('Available to Withdraw: ' + snapshot.data!.toString()),
                    snapshot.data!.toString() == "0"
                        ? const TextButton(
                            child: Text('Withdraw'),
                            onPressed: null,
                          )
                        : TextButton(
                            child: Text('Withdraw'),
                            onPressed: () {
                              setState(() {
                                _loading = true;
                              });
                              withdraw().then((value) {
                                setState(() {
                                  _loading = false;
                                });
                              });
                            },
                          )
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Expanded(
            child: FutureBuilder(
              future: getNFTs(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final val = snapshot.data as List<dynamic>;
                  final nfts = val
                      .map((title) => title as Map<String, dynamic>)
                      .toList();
                  if (nfts.length == 0) {
                    return Center(
                      child: Text('No NFTs published on the marketplace'),
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
                                          builder: (context) => NFTPage(
                                            doc: metadata,
                                            minPrice: nft['minPrice'],
                                            id: nft['id'],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
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
