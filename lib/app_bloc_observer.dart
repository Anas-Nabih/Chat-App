import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver{


  @override
  void onTransition(Bloc bloc, Transition transition) {

    if(kDebugMode) {
      print("Transition: $transition");
    }


  }


  @override
  void onChange(BlocBase bloc, Change change) {

    if (kDebugMode) {
      print("Transition: $change");
    }
  }


}