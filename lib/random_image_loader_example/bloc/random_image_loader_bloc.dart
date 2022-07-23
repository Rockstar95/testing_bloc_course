import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_bloc_course/extensions.dart';
import 'package:testing_bloc_course/random_image_loader_example/bloc/random_image_loader_event.dart';
import 'package:testing_bloc_course/random_image_loader_example/bloc/random_image_loader_state.dart';

typedef RandomImageLoadeUrlrPicker = String Function(Iterable<String> allUrls);

class RandomImageLoaderBloc extends Bloc<RandomImageLoaderEvent, RandomImageLoaderState> {
  Iterable<String> urls;
  RandomImageLoadeUrlrPicker? randomImageLoadeUrlrPicker;
  Duration? waitBeforeLoadUrl;

  RandomImageLoaderBloc({
    required this.urls,
    this.randomImageLoadeUrlrPicker,
    this.waitBeforeLoadUrl,
  }) : super(const RandomImageLoaderState.empty()) {
    on<LoadNextRandomImageEvent>((event, emit) async {
      emit(const RandomImageLoaderState(isLoading: true, data: null, error: null));

      String url = (randomImageLoadeUrlrPicker ?? _pickRandomUrl)(urls);

      try {
        if (waitBeforeLoadUrl != null) {
          await Future.delayed(waitBeforeLoadUrl!);
        }

        NetworkAssetBundle networkAssetBundle = NetworkAssetBundle(Uri.parse(url));
        final Uint8List data = (await networkAssetBundle.load(url)).buffer.asUint8List();

        emit(RandomImageLoaderState(isLoading: false, data: data, error: null));
      }
      catch (e, s) {
        print("Error in Loading Image:$e");
        print(s);
        emit(RandomImageLoaderState(isLoading: false, data: null, error: e));
      }
    });
  }

  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();
}
