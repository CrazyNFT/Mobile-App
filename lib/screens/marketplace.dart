import 'package:flutter/material.dart';
import 'package:mobile_app/screens/nft.dart';
import 'package:mobile_app/services/api_call.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({Key? key}) : super(key: key);

  @override
  _MarketplacePageState createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  @override
  void initState() {
    super.initState();
    getNFT('https://ipfs.infura.io/ipfs/QmQy2Tk116oT5zt7gjgKcJEnfrRQ31wRP4WJn5RQxRMykw')
        .then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getNFTs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final val = snapshot.data as List<dynamic>;
          final nfts =
              val.map((title) => title as Map<String, dynamic>).toList();
          return GridView.count(
              crossAxisCount: 2,
              children: nfts.map((nft) {
                return FutureBuilder(
                    future: getNFT(nft['uri']),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final metadata = snapshot.data as Map<String, dynamic>;
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
                        return CircularProgressIndicator();
                      }
                    });
              }).toList());
          return Container();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
