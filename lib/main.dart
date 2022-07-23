import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math show Random;

import 'package:testing_bloc_course/loading_widget.dart';

void main() {
  runApp(const MyApp());
}

const List<String> names = ["Foo", "Bar", "Boy"];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  void pickRandomName() {
    emit(names.getRandomElement());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final NamesCubit namesCubit;

  @override
  void initState() {
    namesCubit = NamesCubit();
    super.initState();
  }

  @override
  void dispose() {
    namesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home Screen"),
        ),
        body: StreamBuilder<String?>(
          stream: namesCubit.stream,
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            print("Connection State:${snapshot.connectionState}");

            if(snapshot.connectionState == ConnectionState.done) {
              return const SizedBox();
            }
            else if(snapshot.connectionState == ConnectionState.none) {
              return getButton();
            }
            else if(snapshot.connectionState == ConnectionState.active) {
              return Column(
                children: [
                  Text(snapshot.data ?? ""),
                  getButton(),
                  SizedBox(height: 10,),
                  getShowLoadingButton(),
                ],
              );
            }
            else if(snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  Text(snapshot.data ?? ""),
                  getButton(),
                  SizedBox(height: 10,),
                  getShowLoadingButton(),
                ],
              );
            }
            else {
              return getButton();
            }
          },
        ),
      ),
    );
  }

  Widget getButton() {
    return TextButton(
      onPressed: () {
        namesCubit.pickRandomName();
      },
      child: const Text("Pick Random Value"),
    );
  }

  Widget getShowLoadingButton() {
    return TextButton(
      onPressed: () async {
        LoadingScreen().showLoading(context: context, text: "Verification In Progress");
        await Future.delayed(const Duration(seconds: 2));
        LoadingScreen().showLoading(context: context, text: "Verification Done");
        await Future.delayed(const Duration(seconds: 2));
        LoadingScreen().showLoading(context: context, text: "Logging You In");
        await Future.delayed(const Duration(seconds: 2));
        LoadingScreen().hideLoading();
      },
      child: const Text("Show loading"),
    );
  }
}

