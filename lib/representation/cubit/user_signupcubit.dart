import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/api/api_consumer.dart';
import '../../core/api/end_ponits.dart';
import '../../core/errors/exceptions.dart';
import '../../data/models/user_signup_model.dart';
import 'user_state.dart';

class SignUpCubit extends Cubit<UserState> {
  SignUpCubit(this.api) : super(UserInitial());
  final ApiConsumer api;

  GlobalKey<FormState> signUpFormKey = GlobalKey();
  TextEditingController signUpName = TextEditingController();
  TextEditingController signUpLastname = TextEditingController();
  TextEditingController signUpFirstname = TextEditingController();
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpLocation = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();

  signUp() async {
    try {
      emit(SignUpLoading());
      final response = await api.post(
        EndPoint.signUp,
        isFromData: true,
        data: {
          ApiKey.name: signUpName.text,
          ApiKey.firstname: signUpFirstname.text,
          ApiKey.lastname: signUpLastname.text,
          ApiKey.email: signUpEmail.text,
          ApiKey.password: signUpPassword.text,
          ApiKey.is_active: true,
        },
      );
      final signUPModel = UserSignup.fromJson(response);
      emit(SignUpSuccess(message: signUPModel.message));
    } on ServerException catch (e) {
      print("========================");
      print(e.errModel.errorMessage);
      print("========================");
      emit(SignUpFailure(errMessage: e.errModel.errorMessage));
    }
  }
}
