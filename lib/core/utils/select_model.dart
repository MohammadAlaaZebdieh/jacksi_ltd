import 'package:equatable/equatable.dart';

class SelectModel extends Equatable {
  final String id;
  final String value;

  const SelectModel({required this.id, required this.value});


  @override
  List<Object?> get props => [id, value];
}
