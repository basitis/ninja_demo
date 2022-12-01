import 'package:bloc/bloc.dart';

import 'package:ninja_demo/cat/cubit/cat_event.dart';
import 'package:ninja_demo/cat/cubit/cat_state.dart';
import 'package:ninja_demo/services/cat_service.dart';
import 'package:ninja_demo/services/image_helper.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  CatBloc(this._todoService, this._imageHelper) : super(CatsInitial()) {
    on<RegisterServicesEvent>(
      (event, emit) async {
        await _todoService.init();
        await _imageHelper.init();
        add(LoadCatsEvent());
      },
    );
    on<LoadCatsEvent>((event, emit) {
      final todos = _todoService.getTasks();
      if (todos.isEmpty) {
        emit(
          CatsEmptyState(),
        );
      } else {
        emit(
          CatsLoadedState(
            todos,
          ),
        );
      }
    });

    on<DeleteCatEvent>((event, emit) async {
      if (event.cat.index != null && event.cat.index!.isNotEmpty) {
        await _todoService.removeTask(event.cat.index!);
        emit(DeleteSuccessState(event.cat));
        add(LoadCatsEvent());
      }
    });
  }
  final CatService _todoService;
  final ImageHelper _imageHelper;
}
