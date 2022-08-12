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
  final String? message;
  const ErrorState({this.message});
}
