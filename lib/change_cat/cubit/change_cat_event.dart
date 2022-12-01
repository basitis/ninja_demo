import 'package:equatable/equatable.dart';
import 'package:ninja_demo/model/cat.dart';
import 'package:ninja_demo/model/cat_properties.dart';

abstract class ChangeCatEvent extends Equatable {}

class AddCatEvent extends ChangeCatEvent {
  AddCatEvent(this.cat);
  final Cat cat;

  @override
  List<Object?> get props => [cat];
}

class EditCatEvent extends ChangeCatEvent {
  EditCatEvent(this.cat);
  final Cat cat;
  @override
  List<Object?> get props => [cat];
}

class ValueChangeEvent extends ChangeCatEvent {
  ValueChangeEvent(this.property, this.value);

  final CatProperties property;
  final String value;

  @override
  List<Object?> get props => [property, value];
}

class AddCatPhotoEvent extends ChangeCatEvent {
  @override
  List<Object?> get props => [];
}

class SubmitFormEvent extends ChangeCatEvent {
  @override
  List<Object?> get props => [DateTime.now().millisecondsSinceEpoch];
}

class ErrorCatEvent extends ChangeCatEvent {
  ErrorCatEvent(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
