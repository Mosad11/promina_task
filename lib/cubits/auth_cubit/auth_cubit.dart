import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina_task/core/helper/end_points/end_points.dart';
import 'package:promina_task/core/networking/dio_helper.dart';
import 'package:promina_task/cubits/auth_cubit/auth_states.dart';
import 'package:promina_task/models/login_model/login_model.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(LoginStateInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginStateLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      "email": email,
      "password": password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.user!.name);
      emit(LoginStateSuccessState(loginModel!));
    }).catchError((error) {
      emit(LoginStateErrorState(error));
    });
  }
}
