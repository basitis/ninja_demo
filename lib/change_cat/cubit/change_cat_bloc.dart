import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ninja_demo/change_cat/cubit/change_cat_event.dart';
import 'package:ninja_demo/change_cat/cubit/change_cat_state.dart';
import 'package:ninja_demo/model/cat.dart';
import 'package:ninja_demo/model/cat_properties.dart';
import 'package:ninja_demo/services/cat_service.dart';

class ChangeCatBloc extends Bloc<ChangeCatEvent, ChangeCatState> {
  ChangeCatBloc(this.todoService) : super(const LoadingState()) {
    on<SubmitFormEvent>(
      (event, emit) => add(
        AddCatEvent(
          Cat(
            name: name,
            breed: breed,
            description: description,
            image: image,
            index: DateTime.now().millisecondsSinceEpoch.toString(),
          ),
        ),
      ),
    );
    on<AddCatEvent>((event, emit) async {
      try {
        await todoService.addTask(event.cat);
        emit.call(const SuccessState());
      } catch (e) {
        debugPrint('Error is $e');
        emit.call(const ErrorState(''));
      }
    });

    on<EditCatEvent>((event, emit) async {
      await todoService.updateTask(event.cat);
      emit.call(const SuccessState());
    });

    on<AddCatPhotoEvent>((event, emit) async {
      try {
        final image = await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          this.image = image.path;
          emit.call(CatPhotoSuccessState(image.path));
        }
      } catch (e) {
        debugPrint('Unable to add photo');
      }
    });

    on<ValueChangeEvent>(
      (event, emit) {
        switch (event.property) {
          case CatProperties.name:
            name = event.value;
            break;
          case CatProperties.image:
            image = event.value;
            break;
          case CatProperties.breed:
            breed = event.value;
            break;
          case CatProperties.description:
            description = event.value;
            break;
        }
      },
    );

    on<ErrorCatEvent>(
      (event, emit) {
        emit(ErrorState(event.message));
      },
    );
  }
  final ImagePicker _picker = ImagePicker();
  String? name, breed, image, description;
  final CatService todoService;
}
