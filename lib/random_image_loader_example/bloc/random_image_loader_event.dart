import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class RandomImageLoaderEvent {
  const RandomImageLoaderEvent();
}

@immutable
class LoadNextRandomImageEvent extends RandomImageLoaderEvent {
  const LoadNextRandomImageEvent();
}
