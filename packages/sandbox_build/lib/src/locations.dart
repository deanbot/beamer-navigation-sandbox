import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:sandbox_build/src/screens.dart';

class BuildLocation extends BeamLocation<BeamState> {
  static const String build = 'build';

  @override
  List<Pattern> get pathPatterns => [
        '/$build/*',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stack = [
      const BeamPage(
        key: ValueKey('build-route'),
        child: BuildScreen(),
      )
    ];

    return stack;
  }
}

class BuildKeyboardLocation extends BeamLocation<BeamState> {
  BuildKeyboardLocation() : super();

  static const String keyboard = 'keyboard';
  static const String category = 'category';
  static const String listing = 'listing';

  @override
  List<Pattern> get pathPatterns => [
        '/${BuildLocation.build}/$keyboard',
        '/${BuildLocation.build}/$keyboard/$category',
        '/${BuildLocation.build}/$keyboard/$listing',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stack = [
      const BeamPage(
        key: ValueKey('build-keyboard-home-route'),
        child: BuildKeyboardHome(),
      )
    ];

    if (state.pathPatternSegments.contains(category)) {
      stack.add(const BeamPage(
        key: ValueKey('build-keyboard-category-route'),
        child: BuildKeyboardCategory(),
      ));
    }

    if (state.pathPatternSegments.contains(listing)) {
      stack.add(const BeamPage(
        key: ValueKey('build-keyboard-listing-route'),
        child: BuildKeyboardListing(),
      ));
    }

    return stack;
  }
}
