import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_test/router/router.dart';
import 'dart:math';

class MockProductsCreator {
  final db = Firestore.instance;
  var random = new Random();

  MockProductsCreator() {
    generatedProductsCollection();
  }

  addProducts(product) async {
    // DocumentReference ref =
    await db.collection('products').add(product);
  }

  generatedProductsCollection() {
    var product = {
      'image': 'https://picsum.photos/500',
      'title': 'Lorem ipsum',
      'description': 'Lorem ipsum dolor sit amet asdsa asd assdsd'
    };

    List<String> screen_ids = [
      '2u6tJhVXbfsgMnmQ5OgH',
      'Bx90qmFBExGP7F0qK3R9',
      'TxrAXZmrBWZVv9j8So5t',
    ];

    for (var i = 0; i < 10; i++) {
      product["screen_id"] = '${screen_ids[random.nextInt(2)]}';
      product["title"] = '${product["title"]}-$i';
      addProducts(product);
    }
  }
}
