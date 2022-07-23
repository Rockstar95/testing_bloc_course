import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_bloc_course/extensions.dart';

const List<String> names = ["Foo", "Bar", "Boy"];

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  void pickRandomName() {
    emit(names.getRandomElement());
  }
}