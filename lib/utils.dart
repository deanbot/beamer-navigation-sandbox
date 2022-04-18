import 'package:beamer/beamer.dart';
import 'package:beamer_sandbox/modal_bottom_route.dart';
import 'package:flutter/material.dart';

typedef RouteBuilder = Route Function(
    BuildContext context, RouteSettings settings, Widget child);

bool _isMobile(BuildContext context) => MediaQuery.of(context).size.width < 500;

class RouteUtils {
  /// Get route builder for modal bottom sheet route
  static RouteBuilder getPanelRouteBuilder({
    bool isDismissible = true,
    Function()? onDismiss,
  }) =>
      (BuildContext context, RouteSettings settings, Widget child) {
        return ModalBottomSheetRoute(
          isScrollControlled: true,
          // add transparent margin area which can be tapped to dismiss route
          builder: (context) => GestureDetector(
            onTap: isDismissible
                // call beam back or customer dismiss
                ? onDismiss ?? context.beamBack
                : null,
            child: Container(
              color: Colors.transparent,
              padding: _isMobile(context)
                  ? null
                  : const EdgeInsets.symmetric(horizontal: 40),
              // capture click so parent gesture detector not used
              child: GestureDetector(
                onTap: () {},
                // rounded panel border
                child: _Panel(
                  child: child,
                ),
              ),
            ),
          ),
          capturedThemes: InheritedTheme.capture(
            from: context,
            to: Navigator.of(context).context,
          ),
          backgroundColor: Colors.transparent,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          enableDrag: isDismissible,
          isDismissible: isDismissible,
          settings: settings,
        );
      };
}

class _Panel extends StatelessWidget {
  const _Panel({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height,
        safeAreaHeight = height - kToolbarHeight;

    // avoid collapsing panel contents when keyboard is shown via SingleChildScrollView & SizedBox
    return SingleChildScrollView(
      child: SizedBox(
        height: _isMobile(context) ? height : safeAreaHeight,
        child: child,
      ),
    );
  }
}
