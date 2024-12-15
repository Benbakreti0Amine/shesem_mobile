import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/data/models/get_report_model.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/cubit/report_state.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/api/api_consumer.dart';
import '../../core/api/end_ponits.dart';
import '../../core/errors/exceptions.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit(this.api) : super(ReportInitial());
  final ApiConsumer api;

  GlobalKey<FormState> reportFormKey = GlobalKey();
  TextEditingController reportTitle = TextEditingController();
  TextEditingController reportDescription = TextEditingController();
  TextEditingController reportSeverity = TextEditingController();
  TextEditingController reportCategory = TextEditingController();
  TextEditingController longitude = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController reportPhone = TextEditingController();
  XFile? reportImage;
  XFile? reportVideo;

  // Method to create a new report
    createReport() async {
      try {
        emit(ReportLoading());
        final response = await api.post(
          EndPoint.reports, // Endpoint for creating a report
          isFromData: true,
          data: {
            ApiKey.title: reportTitle.text,
            ApiKey.description: reportDescription.text,
            ApiKey.severity: reportSeverity.text,
            ApiKey.category: reportCategory.text,
            ApiKey.latitude: latitude.text,  
            ApiKey.longitude: longitude.text,
            ApiKey.user: reportPhone.text,
            // Include image and video if available
            ApiKey.image: reportImage != null ? reportImage!.path : null,
            ApiKey.video: reportVideo != null ? reportVideo!.path : null,
          },
        );

      final reportModel = ReportModel.fromJson(response); 
      emit(ReportSuccess(message: reportModel.description));
    } on ServerException catch (e) {
      print("========================");
      print(e.errModel.errorMessage);
      print("========================");
      emit(ReportFailure(errMessage: e.errModel.errorMessage));
    }
  }

  // Method to pick image
  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      reportImage = pickedFile;
      emit(ReportImagePicked());  // Create a new state for image picked
    }
  }

  // Method to pick video
  Future<void> pickVideo() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      reportVideo = pickedFile;
      emit(ReportVideoPicked());  // Create a new state for video picked
    }
  }
}
