import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'cat.g.dart';

@HiveType(typeId: 1)
class Cat extends Equatable {
  Cat({this.name, this.image, this.breed, this.description, this.index});

  @HiveField(0)
  String? name;
  @HiveField(1)
  String? image;
  @HiveField(2)
  String? breed;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? index;

  @override
  List<Object?> get props => [name, image, breed, description, index];
}
