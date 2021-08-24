import 'package:f_logs/f_logs.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier?> extends StatefulWidget {
  final T? model;
  final Widget Function(BuildContext context, T model, Widget? child)? builder;
  final Widget? child;
  final void Function(T t)?
      onInitState; // used to fire data fetching from the server

  ProviderWidget({this.model, this.builder, this.child, this.onInitState});

  @override
  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier?>
    extends State<ProviderWidget<T?>> {
  @override
  void initState() {
    super.initState();
    if (widget.onInitState != null) {
      widget.onInitState!(widget.model);
      FLog.debug(text: "[Provider Widget] _ProviderWidgetState onInitState");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T?>(
      create: (context) => widget.model,
      child: Consumer<T>(
        builder: widget.builder!,
        child: widget.child,
      ),
    );
  }
}
