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
                    context.beamToNamed('/${AboutLocation.about}');
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

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.beamBack();
          },
        ),
      ),
      body: const Center(
        child: Text('Just another page'),
      ),
    );
  }
}
