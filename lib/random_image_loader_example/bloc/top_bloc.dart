import 'package:flutter/foundation.dart' show immutable;
import 'package:testing_bloc_course/random_image_loader_example/bloc/random_image_loader_bloc.dart';

@immutable
class TopBloc extends RandomImageLoaderBloc {
  TopBloc({
    required Iterable<String> urls,
    RandomImageLoadeUrlrPicker? randomImageLoadeUrlrPicker,
    Duration? waitBeforeLoadUrl,
  }) : super(urls: urls, randomImageLoadeUrlrPicker: randomImageLoadeUrlrPicker, waitBeforeLoadUrl: waitBeforeLoadUrl);
}