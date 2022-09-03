import 'dart:io';
import 'dart:typed_data';

import 'package:backgroung_remover_app/controller/states.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  File? pickedImage;
  Uint8List? newImage;
  final ImagePicker _picker = ImagePicker();
  Future<void> pickImageFromDevice({bool isCamera = false}) async {
    emit(PickImageLoadingState());
    final pickedFile = await _picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      emit(PickImageSuccessState());
    } else {
      print('error occur when pick image');
      emit(PickImageErrorState());
    }
  }

  Future<void> uploadImage() async {
    emit(NewImageLoadingState());
    String fileName = pickedImage!.path.split("/").last;
    FormData data = FormData.fromMap({
      'source_image_file':
          await MultipartFile.fromFile(pickedImage!.path, filename: fileName)
    });
    Dio dio = Dio();
    var response = await dio
        .post("https://api.slazzer.com/v2.0/remove_image_background",
            data: data,
            options: Options(
              headers: {'API_KEY': '919bfb7e228b48e8b34a189db848a439'},
              responseType: ResponseType.bytes,
            ))
        .then((value) {
      newImage = value.data;
      emit(NewImageSuccessState());
    }).catchError((error) {
      print('the error is $error');
      emit(NewImageErrorState(error.toString()));
    });
  }

  Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chose the source of image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  pickImageFromDevice(isCamera: true).then((value) {
                    Navigator.of(context).pop();
                  });
                },
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
              ),
              ListTile(
                onTap: () {
                  pickImageFromDevice().then((value) {
                    Navigator.of(context).pop();
                  });
                },
                leading: const Icon(Icons.photo),
                title: const Text('Gallery'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

/// pickedImage.path.split("/").last
