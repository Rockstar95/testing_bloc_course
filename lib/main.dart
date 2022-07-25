import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_bloc_course/app_bloc_observer.dart';
import 'package:testing_bloc_course/names_cubit_example/ui/names_cubit_home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(() {
    runApp(const MyApp());
  },
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: RandomImageLoaderHomeScreen(),
      home: NameCubitHomeScreen(),
    );
  }
}



