import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox_build/src/bloc/bloc.dart';
import 'package:sandbox_build/src/locations.dart';

class BuildScreen extends StatelessWidget {
  const BuildScreen({Key? key}) : super(key: key);
  static final _beamerKey = GlobalKey<BeamerState>();

  static BeamerDelegate routerDelegate = BeamerDelegate(
    routeListener: (routeInformation, _) =>
        print('inner: ${routeInformation.location}'),
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        BuildKeyboardLocation(key: _beamerKey),
      ],
    ),
    // updateParent: false,
    updateFromParent: false,
    // initializeFromParent: false,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<KeyboardBuildCubit>(
      create: (_) => KeyboardBuildCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Build:'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (context.canPopBeamLocation) {
                context.popBeamLocation();
              }
            },
          ),
        ),
        body: Beamer(
          key: _beamerKey,
          routerDelegate: routerDelegate,
        ),
      ),
    );
  }
}

class BuildKeyboardHome extends StatelessWidget {
  const BuildKeyboardHome({
    Key? key,
    required this.beamerKey,
  }) : super(key: key);
  final GlobalKey<BeamerState> beamerKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your keyboard build:'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // keyboard
                const Text(
                  'Keyboard: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                BlocSelector<KeyboardBuildCubit, KeyboardBuildState, String>(
                  selector: (state) {
                    if (state is KeyboardBuildUpdated) {
                      return state.keyboard;
                    }
                    return '';
                  },
                  builder: (context, keyboard) {
                    if (keyboard.isEmpty) {
                      return TextButton(
                        onPressed: () {
                          // open keyboard selection route
                          // beamerKey.currentState!.routerDelegate.beamToNamed(
                          context.beamToNamed(
                              '/${BuildLocation.build}/${BuildKeyboardLocation.keyboard}/${BuildKeyboardLocation.category}');
                        },
                        child: const Text('Choose Keyboard'),
                      );
                    }
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(keyboard),
                        IconButton(
                          onPressed: () {
                            context
                                .read<KeyboardBuildCubit>()
                                .update(keyboard: '');
                          },
                          icon: const Icon(Icons.clear),
                        )
                      ],
                    );
                  },
                ),

                /*// switch
                const Text('Switch: '),
                BlocSelector<KeyboardBuildCubit, KeyboardBuildState, String>(
                  selector: (state) {
                    if (state is KeyboardBuildUpdated) {
                      return state.keySwitch;
                    }
                    return '';
                  },
                  builder: (context, keySwitch) {
                    if (keySwitch.isEmpty) {
                      return TextButton(
                        onPressed: () {
                          // open switch selection route
                        },
                        child: const Text('Choose Switch'),
                      );
                    }
                    return Text(keySwitch);
                  },
                ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BuildKeyboardCategory extends StatelessWidget {
  const BuildKeyboardCategory({
    Key? key,
    required this.beamerKey,
  }) : super(key: key);
  final GlobalKey<BeamerState> beamerKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () => _onTapCategory(context, 'rowstag'),
                child: const Text('Row Stagger'),
              ),
              OutlinedButton(
                onPressed: () => _onTapCategory(context, 'ortho'),
                child: const Text('Ortholinear'),
              ),
              OutlinedButton(
                onPressed: () => _onTapCategory(context, 'colstag'),
                child: const Text('Split Columnar Stagger'),
              ),
            ],
          ),
          OutlinedButton(
            onPressed: () => _onTapCategory(context, ''),
            child: const Text('View All'),
          ),
        ],
      ),
    );
  }

  void _onTapCategory(BuildContext context, String category) {
    // beamerKey.currentState!.routerDelegate.beamToNamed(
    context.beamToNamed(
        '/${BuildLocation.build}/${BuildKeyboardLocation.keyboard}/${BuildKeyboardLocation.listing}',
        data: {
          'category': category,
        });
  }
}

class BuildKeyboardListing extends StatelessWidget {
  const BuildKeyboardListing({
    Key? key,
    required this.beamerKey,
  }) : super(key: key);
  final GlobalKey<BeamerState> beamerKey;

  @override
  Widget build(BuildContext context) {
    late List<String> results;
    final Map<String, dynamic> _data = beamerKey.currentState!.routerDelegate
            .currentBeamLocation.data as Map<String, dynamic>? ??
        {};
    final String _category = _data['category'] as String? ?? '';

    final rowstagResults = [
      'Keychron K12',
      'Ikki68',
      'Salvation 65',
    ];
    final orthoResults = ['Planck', 'Preonic', 'Boardwalk'];
    final colstagResults = ['Kyria', 'Sweep', 'Corne'];

    if (_category.isEmpty) {
      results = [
        ...rowstagResults,
        ...orthoResults,
        ...colstagResults,
      ];
    } else if (_category == 'rowstag') {
      results = rowstagResults;
    } else if (_category == 'ortho') {
      results = orthoResults;
    } else if (_category == 'colstag') {
      results = colstagResults;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results:'),
      ),
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: results.length,
          itemBuilder: (context, index) {
            final item = results[index];
            return Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(item),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<KeyboardBuildCubit>().update(keyboard: item);
                      // beamerKey.currentState!.routerDelegate
                      context.popToNamed(
                          '/${BuildLocation.build}/${BuildKeyboardLocation.keyboard}');
                    },
                    child: const Text('Select'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
