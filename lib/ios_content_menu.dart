import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('iOS Context Menu'),
      ),
      child: SafeArea(
        child: CupertinoContextMenu(
          previewBuilder: (_, __, child) => Rounded(child: child),
          actions: [
            CupertinoContextMenuAction(
              child: const SaveRow(),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoContextMenuAction(
              child: const ShareRow(),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          child: Image.network(
            'https://bit.ly/3x7J5Qt',
          ),
        ),
      ),
    );
  }
}

class Rounded extends StatelessWidget {
  final Widget child;
  const Rounded({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.black.withAlpha(40),
            spreadRadius: 2,
          ),
        ],
      ),
      child: child,
    );
  }
}

class ShareRow extends StatelessWidget {
  const ShareRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.save),
        SizedBox(width: 20.0),
        Text('Share'),
      ],
    );
  }
}

class SaveRow extends StatelessWidget {
  const SaveRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.save),
        SizedBox(width: 20.0),
        Text('Save'),
      ],
    );
  }
}