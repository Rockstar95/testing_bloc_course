import 'dart:typed_data';

import "package:flutter/foundation.dart" show immutable;

@immutable
class RandomImageLoaderState {
  final bool isLoading;
  final Uint8List? data;
  final Object? error;

  const RandomImageLoaderState({
    required this.isLoading,
    required this.data,
    required this.error,
  });

  const RandomImageLoaderState.empty()
      : isLoading = false,
        data = null,
        error = null;

  @override
  String toString() {
    return {
      "isLoading" : isLoading,
      "hasData" : data != null ,
      "error" : error,
    }.toString() ;
  }
}
