import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';

import 'error_text.dart';

class CommandWidgetEmpty<T extends Object> extends StatelessWidget {
  const CommandWidgetEmpty({
    super.key,
    required this.command,
    this.successBuilder,
    this.failureBuilder,
    this.runningWidget,
    this.idleWidget,
    this.cancelledWidget,
  });

  final Command<T> command;
  final Widget Function(T value)? successBuilder;
  final Widget Function(Exception error)? failureBuilder;
  final Widget? runningWidget;
  final Widget? idleWidget;
  final Widget? cancelledWidget;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: command,
      builder: (context, child) {
        return switch (command.value) {
          RunningCommand<T>() => runningWidget ?? const SizedBox.shrink(),
          SuccessCommand<T>(:final T value) =>
            successBuilder == null
                ? const SizedBox.shrink()
                : successBuilder!(value),
          FailureCommand<T>(:final Exception error) =>
            failureBuilder == null
                ? const SizedBox.shrink()
                : failureBuilder!(error),
          IdleCommand<T>() => idleWidget ?? const SizedBox.shrink(),
          CancelledCommand<T>() => cancelledWidget ?? const SizedBox.shrink(),
        };
      },
    );
  }
}

class CommandWidget<T extends Object> extends StatelessWidget {
  const CommandWidget({
    super.key,
    required this.command,
    this.successBuilder,
    this.failureBuilder,
    this.cancelledWidget,
    this.idleWidget,
    this.runningWidget,
  });

  final Command<T> command;
  final Widget Function(T value)? successBuilder;
  final Widget Function(Exception error)? failureBuilder;
  final Widget? runningWidget;
  final Widget? idleWidget;
  final Widget? cancelledWidget;

  @override
  Widget build(BuildContext context) {
    return CommandWidgetEmpty(
      command: command,
      successBuilder: successBuilder,
      failureBuilder: failureBuilder ?? (error) => ErrorText(error.toString()),
      runningWidget: runningWidget ?? const CircularProgressIndicator(),
      idleWidget: idleWidget,
      cancelledWidget: cancelledWidget,
    );
  }
}

class CommandWidgetError<T extends Object> extends StatelessWidget {
  const CommandWidgetError({super.key, required this.command});

  final Command<T> command;

  @override
  Widget build(BuildContext context) {
    return CommandWidgetEmpty(
      command: command,
      failureBuilder: (error) => ErrorText(error.toString()),
    );
  }
}
