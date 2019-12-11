import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_test/router/router.dart';

class CardItem {
  CardItem(cardType);

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('cards').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
        if (!asyncSnapshot.hasData) return CircularProgressIndicator();

        return _buildList(context, asyncSnapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.length,
        itemBuilder: (context, index) =>
            _createCardItem(context, snapshot[index]),
      ),
    );
  }

  Widget _createCardItem(BuildContext context, DocumentSnapshot snapshot) {
    void _navigateToScreen(dynamic cardId) {
      final String id = cardId;
      Navigator.pushNamed(context, 'card-view', arguments: id);
    }

    Size size = MediaQuery.of(context).size;

    Map<String, dynamic> card = snapshot.data;

    final cardId = snapshot.documentID;
    final title = card['title'];
    final description = card['description'];
    final image = card['image'];


    return Container(
      height: 150,
      width: 200,
      child: GestureDetector(
        onTap: () => _navigateToScreen(cardId),
        child: Card(
          elevation: 5,
          semanticContainer: true,
          color: Colors.black,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: const Radius.circular(50.0),
                topLeft: const Radius.circular(4),
                bottomRight: const Radius.circular(4),
                bottomLeft: const Radius.circular(50.0)),
          ),
          margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
            child: Column(
              children: <Widget>[
                Center(
//                heightFactor: 0,
                    child: Column(
                  children: <Widget>[
                    Text(title,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center),
                    Text(description, style: TextStyle(color: Colors.white54))
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
