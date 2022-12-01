import 'package:equatable/equatable.dart';

abstract class ChangeCatState extends Equatable {
  const ChangeCatState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class LoadingState extends ChangeCatState {
  const LoadingState();

  @override
  String toString() => 'LoadingState';
}

/// Initialized
class SuccessState extends ChangeCatState {
  const SuccessState();

  @override
  String toString() => 'SuccessState';

  @override
  List<Object> get props => [];
}

class ErrorState extends ChangeCatState {
  const ErrorState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorState';

  @override
  List<Object> get props => [errorMessage];
}

class CatPhotoSuccessState extends ChangeCatState {
  const CatPhotoSuccessState(this.path);

  final String path;
}
