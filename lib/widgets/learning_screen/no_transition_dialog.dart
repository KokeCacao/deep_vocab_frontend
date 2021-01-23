import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T> showNoTransitionDialog<T>({
  @required BuildContext context,
  WidgetBuilder builder,
  bool barrierDismissible = true,
  Color barrierColor,
  bool useRootNavigator = true,
  RouteSettings routeSettings,
}) {
  assert(builder != null);
  assert(barrierDismissible != null);
  assert(useRootNavigator != null);
  assert(debugCheckHasMaterialLocalizations(context));

  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      Widget dialog = Builder(
          builder: (BuildContext context) {
            return theme != null
                ? Theme(data: theme, child: pageChild)
                : pageChild;
          }
      );
      return SafeArea(child: dialog);
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: barrierColor ?? Colors.transparent,
    transitionDuration: const Duration(),
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
  );
}
