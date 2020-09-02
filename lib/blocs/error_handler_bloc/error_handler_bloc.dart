import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'error_handler_event.dart';
part 'error_handler_state.dart';

class ErrorHandlerBloc extends Bloc<ErrorHandlerEvent, ErrorHandlerState> {
  ErrorHandlerBloc() : super(ErrorHandlerEmpty());

  @override
  Stream<ErrorHandlerState> mapEventToState(
    ErrorHandlerEvent event,
  ) async* {
    if (event is ErrorHandlerCatched) {
      if (event.forceSnack) {
        yield ErrorThrownSnackbar(
            event.error, () => event.bloc.add(event.event));
      } else {
        yield ErrorThrownDialog(event.error, () => event.bloc.add(event.event));
      }
      yield ErrorHandlerEmpty();
    }
  }
}
