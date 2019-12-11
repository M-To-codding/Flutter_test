import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_test/router/router.dart';

import 'db/mock_products_creator.dart';

void main() {
//  MockProductsCreator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      initialRoute: 'home',
      onGenerateRoute: generateRoutes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String pageDescription =
      'Lorem ipsum dolor sit amet, dolor sit amet Lorem '
      'ipsum dolor sit am ipsum dolor sit amet, dolor sit amet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: true,
        child: ListView(children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.network(
                  'https://cdn.dribbble.com/users/65767/screenshots/4935267/peter_deltondo_unfold_crowdrise_gofundme_pricing_illustrations.gif'),
              Container(
                color: Colors.blue,
                padding: EdgeInsets.all(20.0),
                child: Text(pageDescription,
                    style: TextStyle(color: Colors.white)),
              ),
              _buildCardsListHorizontal(context)
            ],
          ),
        ]),
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

  void _navigateToScreen(dynamic cardId) {
    final String id = cardId;
    Navigator.pushNamed(context, 'card-view', arguments: id);
  }

  Widget _buildCardsListHorizontal(BuildContext context) {
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

  Widget _buildList2(BuildContext context, List<DocumentSnapshot> snapshots) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        for (var snapshot in snapshots) _createCardItem(context, snapshot)
      ],
    );
  }

  Widget _buildList3(BuildContext context, List<DocumentSnapshot> snapshots) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: snapshots
          .map((snapshot) => _createCardItem(context, snapshot))
          .toList(),
    );
  }

  Widget _createCardItem(BuildContext context, DocumentSnapshot snapshot) {
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
