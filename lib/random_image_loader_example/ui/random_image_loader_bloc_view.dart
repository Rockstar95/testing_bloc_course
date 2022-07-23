import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_bloc_course/extensions.dart';
import 'package:testing_bloc_course/random_image_loader_example/bloc/random_image_loader_bloc.dart';
import 'package:testing_bloc_course/random_image_loader_example/bloc/random_image_loader_event.dart';
import 'package:testing_bloc_course/random_image_loader_example/bloc/random_image_loader_state.dart';

class RandomImageloaderBlocView<T extends RandomImageLoaderBloc> extends StatelessWidget {
  const RandomImageloaderBlocView({Key? key}) : super(key: key);

  void startUpdatingBloc(BuildContext context) {
    print("startUpdatingBloc called for $T");

    Stream.periodic(const Duration(seconds: 10), (_) => const LoadNextRandomImageEvent())
        .startWith(const LoadNextRandomImageEvent())
        .forEach((LoadNextRandomImageEvent event) {
          print("startUpdatingBloc called for $T");
          context.read<T>().add(event);
        });
  }

  @override
  Widget build(BuildContext context) {
    startUpdatingBloc(context);

    return Expanded(
      child: BlocBuilder<T, RandomImageLoaderState>(
        builder: (BuildContext context, RandomImageLoaderState state) {
          if(state.error != null) {
            return const Center(child: Text("An Error Occured. Try Again!"));
          }
          else if(state.data != null) {
            return Image.memory(state.data!, fit: BoxFit.fitHeight,);
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
