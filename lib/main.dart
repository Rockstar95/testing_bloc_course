import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_bloc_course/app_bloc_observer.dart';
import 'package:testing_bloc_course/photo_gallery/ui/photo_gallery_app.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    //runApp(const RandomImageLoaderHomeScreen());
    //runApp(const NameCubitHomeScreen());
    runApp(const PhotoGalleryApp());
  },
    blocObserver: AppBlocObserver(),
  );
}



