import 'package:beamer/beamer.dart';
import 'package:beamer_sandbox/screens.dart';
import 'package:beamer_sandbox/utils.dart';
import 'package:flutter/material.dart';

class HomeLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => ['/'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    // home
    final stack = [
      BeamPage(
        key: ValueKey('home-route'),
        child: const HomeScreen(),
      ),
    ];

    return stack;
  }
}

class AboutPanelLocation extends BeamLocation<BeamState> {
  static String about = 'about';

  @override
  List<Pattern> get pathPatterns => [
        '/$about/*',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    // open in modal bottom sheet panel
    final stack = [
      BeamPage(
        key: const ValueKey('about-panel-route'),
        routeBuilder: RouteUtils.getPanelRouteBuilder(
          onDismiss: () =>
              context.popBeamLocation(), //context.beamToNamed('/'),
        ),
        child: const AboutPanelScreen(),
      ),
    ];
    return stack;
  }
}

class AboutNestedLocation extends BeamLocation<BeamState> {
  static String about = 'about';
  static String aboutAuthor = 'author';
  static String aboutApp = 'app';

  @override
  List<Pattern> get pathPatterns => [
        '/$about/$aboutAuthor',
        '/$about/$aboutApp',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stack = [
      // about home
      const BeamPage(
        key: ValueKey('about-route'),
        child: AboutHomeScreen(),
      ),

      // about author
      if (state.pathPatternSegments.contains(aboutAuthor))
        const BeamPage(
          key: ValueKey('about-author-route'),
          child: AboutAuthorScreen(),
        ),

      // about app
      if (state.pathPatternSegments.contains(aboutApp))
        const BeamPage(
          key: ValueKey('about-app-route'),
          child: AboutAppScreen(),
        ),
    ];
    return stack;
  }
}
