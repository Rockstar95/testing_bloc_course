import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    print("onCreate called for :${bloc.runtimeType}");
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    print("onEvent called for :${bloc.runtimeType} with Event :${event.runtimeType}");
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print("onChange called for :${bloc.runtimeType} with change :$change");
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print("onError called for :${bloc.runtimeType} with Error :$error");
    print(stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print("onTransition called for :$bloc, with transition Event :${transition.event.runtimeType}, "
        "Current Stte: ${transition.currentState} and next State:${transition.nextState}");
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    print("onClose called for :${bloc.runtimeType}");
    super.onClose(bloc);
  }
}