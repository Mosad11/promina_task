import 'package:promina_task/models/gellary_model/gellary_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class HomeLoadingState extends AppStates {}

class HomeSuccessState extends AppStates {
  final GellaryModel gellaryModel;

  HomeSuccessState(this.gellaryModel);
}

class HomeErrorState extends AppStates {
  final String error;
  HomeErrorState(this.error);
}

class UploadHomeLoadingState extends AppStates {}

class UploadHomeSuccessState extends AppStates {
   final GellaryModel gellaryModel;

  UploadHomeSuccessState(this.gellaryModel);
}

class UploadHomeErrorState extends AppStates {
  final String error;
  UploadHomeErrorState(this.error);
}
