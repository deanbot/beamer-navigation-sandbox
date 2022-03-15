import 'package:beamer/beamer.dart';
import 'package:beamer_sandbox/screens.dart';
import 'package:flutter/material.dart';

class HomeLocation extends BeamLocation<BeamState> {
  static String home = '*';

  @override
  List<Pattern> get pathPatterns => [
    '/',
  ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    // home
    final stack = [
      BeamPage(
        key: ValueKey('home-route-${state.uri}'),
        // key: ValueKey('home-route'),
        child: const HomeScreen()
      ),
    ];

    return stack;
  }
}

class AboutLocation extends BeamLocation<BeamState> {
  static String about = 'about';

  @override
  List<Pattern> get pathPatterns => [
    '/$about',
  ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    // home
    final stack = [
      const BeamPage(
        key: ValueKey('about-route'),
        child: AboutScreen(),
      )
    ];
    return stack;
  }
}