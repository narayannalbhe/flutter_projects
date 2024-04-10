import 'package:flutter/material.dart';

class PIPState extends InheritedWidget {
  final ValueNotifier<bool> isFloatingNotifier;

  PIPState({
    required this.isFloatingNotifier,
    required Widget child,
  }) : super(child: child);

  static PIPState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PIPState>();
  }

  @override
  bool updateShouldNotify(PIPState oldWidget) {
    return isFloatingNotifier != oldWidget.isFloatingNotifier;
  }
}

class PIPView extends StatefulWidget {
  const PIPView({Key? key, required this.builder}) : super(key: key);

  final Widget Function(BuildContext context, bool isFloating) builder;

  @override
  _PIPViewState createState() => _PIPViewState();
}

class _PIPViewState extends State<PIPView> {
  @override
  Widget build(BuildContext context) {
    final isFloatingNotifier = PIPState.of(context)?.isFloatingNotifier;
    final isFloating = isFloatingNotifier?.value ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text('PIP View'),
      ),
      body: widget.builder(context, isFloating),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isFloatingNotifier = ValueNotifier<bool>(false);

    return PIPState(
      isFloatingNotifier: isFloatingNotifier,
      child: PIPView(
        builder: (context, isFloating) {
          return Scaffold(
            resizeToAvoidBottomInset: !isFloating,
            body: SafeArea(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Center(
                      child: Text('This is the PIP Window'),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        isFloatingNotifier.value = !isFloatingNotifier.value;
                      },
                      child: Text('Toggle Floating'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

