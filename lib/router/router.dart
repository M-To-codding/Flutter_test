//import 'package:named_routing/router.dart' as router;
import 'package:flutter/material.dart';
import 'package:flutter_app_test/main.dart';
import 'package:flutter_app_test/ui/card/products_screen.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  final dynamic args = settings.arguments;

  print('router args $args');

  switch (settings.name) {
    case ProductsScreen.CARD_VIEW:
      return MaterialPageRoute(
        builder: (context) {
          return ProductsScreen(
            screen_id: args,
          );
        },
      );
    default:
      return MaterialPageRoute(builder: (_) => MyHomePage());
  }
}
