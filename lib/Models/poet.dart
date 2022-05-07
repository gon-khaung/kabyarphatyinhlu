import 'package:equatable/equatable.dart';

class Poet extends Equatable {
  int id;
  String name;
  String cover;
  String description;

  Poet({
    required this.id,
    required this.name,
    required this.cover,
    required this.description,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
