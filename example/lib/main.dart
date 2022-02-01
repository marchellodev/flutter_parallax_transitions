import 'package:flutter/material.dart';

import 'package:flutter_parallax_transitions/flutter_parallax_transitions.dart';
import './page/home_page.dart';
import './page/other_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Page Transition Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomePage.tag,
        onGenerateRoute: (RouteSettings routeSettings) {
          return PageRouteBuilder<dynamic>(
              settings: routeSettings,
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                switch (routeSettings.name) {
                  case HomePage.tag:
                    return const HomePage();
                  case OtherPage.tag:
                    return const OtherPage();
                  default:
                    return const SizedBox();
                }
              },
              transitionDuration: const Duration(milliseconds: 600),
              transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child,
              ) {
                return getEffect(PageTransitionType.slidePageLeft)(
                    Curves.linear, animation, secondaryAnimation, child);
              });
        });
  }
}
