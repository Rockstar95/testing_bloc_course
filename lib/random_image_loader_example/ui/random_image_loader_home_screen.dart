import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_bloc_course/random_image_loader_example/bloc/bottom_bloc.dart';
import 'package:testing_bloc_course/random_image_loader_example/bloc/top_bloc.dart';
import 'package:testing_bloc_course/random_image_loader_example/constants.dart';
import 'package:testing_bloc_course/random_image_loader_example/ui/random_image_loader_bloc_view.dart';

class RandomImageLoaderHomeScreen extends StatefulWidget {
  const RandomImageLoaderHomeScreen({Key? key}) : super(key: key);

  @override
  State<RandomImageLoaderHomeScreen> createState() => _RandomImageLoaderHomeScreenState();
}

class _RandomImageLoaderHomeScreenState extends State<RandomImageLoaderHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        child: Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => TopBloc(urls: random_image_urls, waitBeforeLoadUrl: const Duration(seconds: 10))),
                BlocProvider(create: (_) => BottomBloc(urls: random_image_urls, waitBeforeLoadUrl: const Duration(seconds: 10))),
              ],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: const [
                  RandomImageloaderBlocView<TopBloc>(),
                  RandomImageloaderBlocView<BottomBloc>(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
