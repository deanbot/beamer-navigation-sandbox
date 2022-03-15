library sandbox_build;

import 'package:beamer/beamer.dart';
import 'package:sandbox_build/src/locations.dart';

export 'src/models.dart';
export 'src/bloc/bloc.dart';

class SandboxBuild {
  static String buildLocation = BuildLocation.build;

  static List<BeamLocation> getLocations() {
    return [
      BuildLocation(),
    ];
  }
}
