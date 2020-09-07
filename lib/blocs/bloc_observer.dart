import 'package:bloc/bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print('bloc: $bloc, event: {$event}');
    super.onEvent(bloc, event);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stacktrace) {
    print('bloc: $cubit, error: $error, stacktrace: $stacktrace');
    super.onError(cubit, error, stacktrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('bloc: $bloc, transition: $transition');
    super.onTransition(bloc, transition);
  }
}
