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
                    context.beamToNamed(AboutLocation.about);
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
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        AboutLocation(),
      ],
    ),
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
              _beamerKey.currentState?.routerDelegate
                  .beamToNamed(AboutLocation.aboutAuthor);
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
              _beamerKey.currentState?.routerDelegate
                  .beamToNamed(AboutLocation.aboutApp);
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            _Sidebar(
              beamer: _beamerKey,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                child: Beamer(
                  routerDelegate: _routerDelegate,
                  key: _beamerKey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Sidebar extends StatefulWidget {
  const _Sidebar({
    Key? key,
    required this.beamer,
  }) : super(key: key);
  final GlobalKey<BeamerState> beamer;

  @override
  State<_Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<_Sidebar> {
  void _setStateListener() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => widget
        .beamer.currentState?.routerDelegate
        .addListener(_setStateListener));
  }

  @override
  void dispose() {
    widget.beamer.currentState?.routerDelegate
        .removeListener(_setStateListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final path = (context.currentBeamLocation.state as BeamState).uri.path;
    late final Widget child;

    if (path == AboutLocation.aboutAuthor) {
      child = const Text('Learn about the author');
    } else if (path == AboutLocation.aboutApp) {
      child = const Text('Learn about the app');
    } else {
      child = const Text('Select an option');
    }
    return Container(
      decoration: const BoxDecoration(
        color: Colors.grey,
      ),
      child: Center(
        child: child,
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
