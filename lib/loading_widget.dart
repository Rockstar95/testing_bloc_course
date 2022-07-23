import 'dart:async';

import 'package:flutter/material.dart';

//https://www.youtube.com/watch?v=Mn254cnduOY&list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&index=9
//Start From 3:39:37

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static LoadingScreen sharedInstance = LoadingScreen._sharedInstance();
  factory LoadingScreen() => sharedInstance;

  LoadingScrollController? _loadingScrollController;

  void showLoading({required BuildContext context, required String text}) {
    if(_loadingScrollController?.update(text) ?? false) {
      return;
    }
    else {
      _loadingScrollController = _showOverlay(context: context, text: text);
    }
  }

  void hideLoading() {
    _loadingScrollController?.close();
    _loadingScrollController = null;
  }

  LoadingScrollController _showOverlay({required BuildContext context, required String text}) {
    StreamController<String> streamController = StreamController<String>();
    streamController.add(text);

    final OverlayState? overlayState = Overlay.of(context);
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;

    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      StreamBuilder(
                        stream: streamController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data as String,
                              textAlign: TextAlign.center,
                            );
                          }
                          else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );

    overlayState?.insert(overlayEntry);

    return LoadingScrollController(
      close: () {
        overlayEntry.remove();
        streamController.close();
        return true;
      },
      update: (String text) {
        streamController.add(text);
        return true;
      },
    );
  }
}

class LoadingScrollController {
  final bool Function() close;
  final bool Function(String) update;

  const LoadingScrollController({
    required this.close,
    required this.update,
  });
}

Widget getShowLoadingButton(BuildContext context) {
  return TextButton(
    onPressed: () async {
      LoadingScreen().showLoading(context: context, text: "Verification In Progress");
      await Future.delayed(const Duration(seconds: 2));
      LoadingScreen().showLoading(context: context, text: "Verification Done");
      await Future.delayed(const Duration(seconds: 2));
      LoadingScreen().showLoading(context: context, text: "Logging You In");
      await Future.delayed(const Duration(seconds: 2));
      LoadingScreen().hideLoading();
    },
    child: const Text("Show loading"),
  );
}