import 'package:beamer/beamer.dart';
import 'package:beamer_sandbox/locations.dart';
import 'package:flutter/material.dart';
import 'package:sandbox_build/sandbox_build.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final BeamerDelegate routerDelegate = BeamerDelegate(
    routeListener: (r, delegate) =>
        print('${r.location}, ${delegate.currentPages}'),
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        HomeLocation(),
        AboutLocation(),
        ...SandboxBuild.getLocations(),
      ],
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: routerDelegate,
      ),
    );
  }
}
