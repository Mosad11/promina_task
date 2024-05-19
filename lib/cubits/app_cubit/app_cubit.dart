import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promina_task/core/helper/end_points/end_points.dart';
import 'package:promina_task/core/networking/cache_helper.dart';
import 'package:promina_task/core/networking/dio_helper.dart';
import 'package:promina_task/cubits/app_cubit/app_states.dart';
import 'package:promina_task/models/gellary_model/gellary_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  GellaryModel? gellaryModel;

  void gellaryData() {
    emit(HomeLoadingState());
    final token = CacheHelper.getData(key: "token");
    DioHelper.getData(url: GET_Gellary, token: token).then((value) {
      gellaryModel = GellaryModel.fromJson(value.data);
      emit(HomeSuccessState(gellaryModel!));
    }).catchError((error) {
      emit(HomeErrorState(error.toString()));
    });
  }

  Future<void> uploadFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    File file = File(image!.path);
    FormData formData = FormData();
    formData = FormData.fromMap({
      'img': await MultipartFile.fromFile(file.path, filename: 'image.jpg')
    });

    emit(UploadHomeLoadingState());
    final token = CacheHelper.getData(key: "token");

    DioHelper.putData(url: UPLOAD, token: token, data: formData).then((value) {
      emit(UploadHomeSuccessState(gellaryModel!));
    }).catchError((error) {
      emit(UploadHomeErrorState(error.toString()));
    });
  }

  Future<void> cameraFile() async {
    final ImagePicker cameraPicker = ImagePicker();
    final XFile? image =
        await cameraPicker.pickImage(source: ImageSource.camera);
    File file = File(image!.path);
    FormData formData = FormData();
    formData = FormData.fromMap({
      'img': await MultipartFile.fromFile(file.path, filename: 'image.jpg')
    });

    emit(UploadHomeLoadingState());
    final token = CacheHelper.getData(key: "token");

    DioHelper.putData(url: UPLOAD, token: token, data: formData).then((value) {
      emit(UploadHomeSuccessState(gellaryModel!));
    }).catchError((error) {
      emit(UploadHomeErrorState(error.toString()));
    });
  }
}
