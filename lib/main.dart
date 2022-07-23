import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_bloc_course/app_bloc_observer.dart';
import 'package:testing_bloc_course/names_cubit_example/ui/names_cubit_home_screen.dart';
import 'package:testing_bloc_course/random_image_loader_example/ui/random_image_loader_home_screen.dart';

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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home Screen"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                getButton("Names Cubit Screen", () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const NameCubitHomeScreen()));
                }),
                getButton("Random Image Loader Screen", () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const RandomImageLoaderHomeScreen()));
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getButton(String text, void Function() onTap) {
    return FlatButton(
      onPressed: () {
        onTap();
      },
      color: Colors.blue,
      child: Text(text, style: const TextStyle(color: Colors.white),),
    );
  }
}



