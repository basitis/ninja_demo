import 'package:equatable/equatable.dart';
import 'package:ninja_demo/model/cat.dart';

abstract class CatEvent extends Equatable {}

class RegisterServicesEvent extends CatEvent {
  @override
  List<Object?> get props => [];
}

class LoadCatsEvent extends CatEvent {
  LoadCatsEvent();

  @override
  List<Object?> get props => [DateTime.now().millisecondsSinceEpoch];
}

class DeleteCatEvent extends CatEvent {
  DeleteCatEvent(this.cat);

  final Cat cat;
  @override
  List<Object?> get props => [cat];
}
