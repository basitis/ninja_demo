import 'package:equatable/equatable.dart';
import 'package:ninja_demo/model/cat.dart';

abstract class CatState extends Equatable {}

class CatsInitial extends CatState {
  @override
  List<Object> get props => [];
}

class CatsLoadedState extends CatState {
  CatsLoadedState(
    this.tasks,
  );
  final List<Cat> tasks;

  @override
  List<Object?> get props => [
        tasks,
      ];
}

class CatsEmptyState extends CatState {
  CatsEmptyState();

  @override
  List<Object?> get props => [];
}

class DeleteSuccessState extends CatState {
  DeleteSuccessState(this.cat);

  final Cat cat;

  @override
  List<Object?> get props => [cat];
}
