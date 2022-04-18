import 'package:beamer/beamer.dart';
import 'package:beamer_sandbox/locations.dart';
import 'package:flutter/material.dart';
import 'package:sandbox_build/sandbox_build.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    context.beamToNamed('/${AboutPanelLocation.about}');
                  },
                  child: const Text('About'),
                ),
                TextButton(
                  onPressed: () {
                    context.beamToNamed('/${SandboxBuild.buildLocation}');
                  },
                  child: const Text('Build'),
                ),
              ],
            ),
            const Divider(),
            const Text('Select \'Build\' to begin'),
          ],
        ),
      ),
    );
  }
}

/// About router and wrapper
class AboutPanelScreen extends StatelessWidget {
  const AboutPanelScreen({Key? key}) : super(key: key);

  static final BeamerDelegate _routerDelegate = BeamerDelegate(
    routeListener: (routeInformation, _) =>
        print('about: ${routeInformation.location}'),
    // transitionDelegate: const NoAnimationTransitionDelegate(),
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        AboutNestedLocation(),
      ],
    ),
    // updateFromParent: false,
  );
  static final _beamerKey = GlobalKey<BeamerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        actions: [
          TextButton(
            onPressed: () {
              _beamerKey.currentState?.routerDelegate.beamToNamed(
                  '/${AboutNestedLocation.about}/${AboutNestedLocation.aboutAuthor}');
              // context.beamToNamed('/${AboutNestedLocation.about}/${AboutNestedLocation.aboutAuthor}');
            },
            child: const Text(
              'Author',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _beamerKey.currentState?.routerDelegate.beamToNamed(
                  '/${AboutNestedLocation.about}/${AboutNestedLocation.aboutApp}');
              // context.beamToNamed('/${AboutNestedLocation.about}/${AboutNestedLocation.aboutApp}');
            },
            child: const Text(
              'App',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Beamer(
        routerDelegate: _routerDelegate,
        key: _beamerKey,
      ),
    );
  }
}

class AboutHomeScreen extends StatelessWidget {
  const AboutHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class AboutAuthorScreen extends StatelessWidget {
  const AboutAuthorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Text(
            'About Author.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('Hi, I\'m Dean.')
        ],
      ),
    );
  }
}

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Text(
            'About the App.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('Just another page.')
        ],
      ),
    );
  }
}
