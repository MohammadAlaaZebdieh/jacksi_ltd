import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
abstract class Failure extends Equatable {
  String? msg;
  Failure([this.msg]) {
    if (msg != null && msg!.isNotEmpty) {
    } else {
      msg = "something_went_wrong";
    }
  }
  @override
  List<Object?> get props => [msg];
}

// ignore: must_be_immutable
class CacheFailure extends Failure {
  CacheFailure([msg]) : super(msg);
}
