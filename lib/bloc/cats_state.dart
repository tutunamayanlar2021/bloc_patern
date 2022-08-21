import 'package:bloc_patern/bloc/cat.dart';
import 'package:flutter/foundation.dart';

abstract class CatsState {
  catState();
}

class CatsInitial extends CatsState {
  CatsInitial();

  @override
  catState() {
    throw UnimplementedError();
  }
}

class CatsLoading extends CatsState {
  CatsLoading();

  @override
  catState() {
    throw UnimplementedError();
  }
}

class CatsCompleted extends CatsState {
  final List<Cat> response;
  CatsCompleted(this.response);

  @override
  catState() {
    throw UnimplementedError();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CatsCompleted && listEquals(other.response, response);
  }

  @override
  int get hashCode => response.hashCode;
}

class CatsError extends CatsState {
  @override
  catState() {
    throw UnimplementedError();
  }

  final String message;
  CatsError(this.message);
}
