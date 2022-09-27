abstract class BaseState {
  const BaseState();
}

class InitialState extends BaseState {
  const InitialState();
}

class LoadingState extends BaseState {
  const LoadingState();
}

class SuccessState extends BaseState {
  const SuccessState();
}

class ErrorState extends BaseState {
  const ErrorState({this.message});
  final String? message;
}
