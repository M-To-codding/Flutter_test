import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_test/router/router.dart';

class ProductsScreen extends StatelessWidget {
  static const CARD_VIEW = 'card-view';
  final String screen_id;

  const ProductsScreen({
    Key key,
    @required this.screen_id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    final String data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
//      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Card view of card'),
      ),
      body: ListView(
        children: <Widget>[
          Container(child: _getCards(context)),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 150),
        child: FloatingActionButton.extended(
            onPressed: _onButtonPress,
            elevation: 10.0,
            label: Text('Menu'),
            icon: Icon(Icons.menu)),
      ),
    );
  }

  void _onButtonPress() {
    print('Clicked');
  }

  Widget _getCards(BuildContext context) {
    final db = Firestore.instance.collection('products');
    var result = [];
//    print('Screen $id');

    db.getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents
          .where((item) => item['screen_id'] == screen_id)
          .forEach((item) {
        result.add(item);
      });
//      print('current result: ${result}');
      print('cards exists');
      return _buildCardsList(context, result);
    });
  }

  Widget _buildCardsList(BuildContext context, cardsList) {
    return GridView.count(
        crossAxisCount: 3,
        children: List.generate(cardsList.length, (index) {
          print('current card:${cardsList[index]['title']}');
          return Center(
            child: Text(
              'Text ${cardsList[index]['title']}',
              style: TextStyle(color: Colors.black),
//              style: Theme.of(context).textTheme.headline,
            ),
          );
        }));
  }
}
