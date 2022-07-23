import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../loading_widget.dart';
import '../bloc/names_cubit.dart';

class NameCubitHomeScreen extends StatefulWidget {
  const NameCubitHomeScreen({Key? key}) : super(key: key);

  @override
  State<NameCubitHomeScreen> createState() => _NameCubitHomeScreenState();
}

class _NameCubitHomeScreenState extends State<NameCubitHomeScreen> {
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
                  getShowLoadingButton(context ),
                ],
              );
            }
            else if(snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  Text(snapshot.data ?? ""),
                  getButton(),
                  SizedBox(height: 10,),
                  getShowLoadingButton(context),
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

}