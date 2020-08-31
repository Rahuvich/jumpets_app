part of 'error_handler_bloc.dart';

@immutable
abstract class ErrorHandlerEvent {}

class ErrorHandlerCatched extends ErrorHandlerEvent {
  final Bloc bloc;
  final event;
  final error;
  final bool forceSnack;
  ErrorHandlerCatched(
      {this.bloc, this.error, this.event, this.forceSnack = false});
}
