import 'package:result_dart/result_dart.dart';

abstract class Service {
  AsyncResult<T> safeExecute<T extends Object>(
    AsyncResult<T> Function() work,
  ) async {
    try {
      final result = await work();
      return result;
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
