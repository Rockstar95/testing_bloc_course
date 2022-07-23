import 'dart:math' as math show Random;

import 'package:async/async.dart';

extension RandomElement<T> on Iterable<T> {
  T getRandomElement({int? maxLength}) => elementAt(math.Random().nextInt(maxLength != null && maxLength <= length ? maxLength : length));
}

// List<String> abc = ["a", "b", "c"];
// List<String> bcd = [
//   "x", "y", ...abc, "z",
// ];
// print("bcd:${bcd}");  Output: ["x", "y", "a", "b", "c", "z"]
extension CompareListSameWithoutOrdering<T> on Iterable<T> {
  bool isListSame(Iterable<T> other) => length == other.length && {...this}.intersection({...other}).length == length;
}

/*

when we return a stream, it works like this:      '-----X-----X-----X-----X--...'
by applying this method, it will work like this:  'X-----X-----X-----X-----X--...'

* */
extension StartWith<T> on Stream<T> {
  Stream<T> startWith(T value) => StreamGroup.merge([
    this,
    Stream<T>.value(value),
  ]);
}
