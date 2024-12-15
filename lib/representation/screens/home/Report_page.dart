// // import 'dart:io';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:happy_tech_mastering_api_with_flutter/core/static/colors.dart';

// class Report extends StatefulWidget {
//   const Report({Key? key}) : super(key: key);

//   @override
//   State<Report> createState() => _ReportState();
// }

// class _ReportState extends State<Report> {
//   String? selectedCategory;
//   String? selectedGravity;
//   File? selectedFile;
//   final ImagePicker _picker = ImagePicker();
//   final _formKey = GlobalKey<FormState>();
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();

//   Future<void> _pickFile() async {
//     final XFile? pickedFile = await _picker.pickMedia();
//     if (pickedFile != null) {
//       setState(() {
//         selectedFile = File(pickedFile.path);
//       });
//     }
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       // TODO: Implement API call to submit the form data
//       print('Form submitted');
//       print('Category: $selectedCategory');
//       print('Gravity: $selectedGravity');
//       print('Title: ${_titleController.text}');
//       print('Description: ${_descriptionController.text}');
//       print('File: ${selectedFile?.path}');
      
//       // Show a success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Signalement envoyé avec succès!')),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(),
//               const SizedBox(height: 20),
//               _buildDropdown(
//                 label: 'Choisissez la catégorie...',
//                 value: selectedCategory,
//                 items: ['Accident', 'Travaux', 'Embouteillage'],
//                 onChanged: (value) => setState(() => selectedCategory = value),
//                 validator: (value) => value == null ? 'Veuillez choisir une catégorie' : null,
//               ),
//               const SizedBox(height: 12),
//               _buildDropdown(
//                 label: 'Choisissez la gravité...',
//                 value: selectedGravity,
//                 items: ['Faible', 'Moyenne', 'Élevée'],
//                 onChanged: (value) => setState(() => selectedGravity = value),
//                 validator: (value) => value == null ? 'Veuillez choisir la gravité' : null,
//               ),
//               const SizedBox(height: 12),
//               _buildTextField(
//                 hintText: 'Saisissez le titre...',
//                 maxLines: 1,
//                 controller: _titleController,
//                 validator: (value) => value!.isEmpty ? 'Veuillez saisir un titre' : null,
//               ),
//               const SizedBox(height: 12),
//               _buildTextField(
//                 hintText: 'Saisissez la description...',
//                 maxLines: 5,
//                 controller: _descriptionController,
//                 validator: (value) => value!.isEmpty ? 'Veuillez saisir une description' : null,
//               ),
//               const SizedBox(height: 12),
//               _buildUploadSection(),
//               const SizedBox(height: 20),
//               _buildSubmitButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return const Text(
//       'Prêt à soumettre votre signalement ?\nRemplissez les informations ci-dessous !',
//       style: TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.w500,
//       ),
//     );
//   }

//   Widget _buildDropdown({
//     required String label,
//     required List<String> items,
//     String? value,
//     required ValueChanged<String?> onChanged,
//     String? Function(String?)? validator,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       hint: Text(label, style: const TextStyle(color: Colors.grey)),
//       icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
//       isExpanded: true,
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: AppColors.primary,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(25),
//           borderSide: BorderSide.none,
//         ),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       ),
//       dropdownColor: AppColors.primary,
//       style: const TextStyle(color: Colors.white),
//       items: items.map((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//       onChanged: onChanged,
//       validator: validator,
//     );
//   }

//   Widget _buildTextField({
//     required String hintText,
//     required int maxLines,
//     required TextEditingController controller,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: TextStyle(color: Colors.grey[400]),
//         filled: true,
//         fillColor: AppColors.primary.withOpacity(0.1),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(25),
//           borderSide: BorderSide.none,
//         ),
//         contentPadding: const EdgeInsets.all(16),
//       ),
//       validator: validator,
//     );
//   }

//   Widget _buildUploadSection() {
//     return GestureDetector(
//       onTap: _pickFile,
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 16),
//         decoration: BoxDecoration(
//           color: AppColors.primary.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(25),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               selectedFile != null ? Icons.check_circle : Icons.photo_camera,
//               color: AppColors.primary.withOpacity(0.5),
//               size: 24,
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 selectedFile != null
//                     ? 'Fichier sélectionné: ${selectedFile!.path.split('/').last}'
//                     : 'Déposez une image ou une vidéo ici...',
//                 style: TextStyle(color: AppColors.primary, fontSize: 14),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSubmitButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: _submitForm,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primary,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(25),
//           ),
//         ),
//         child: const Text(
//           'Envoyer',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/cubit/report_state.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/cubit/user_report_cubit.dart';
import 'package:image_picker/image_picker.dart';

import 'package:happy_tech_mastering_api_with_flutter/core/static/colors.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<ReportCubit, ReportState>(
        listener: (context, state) {
          if (state is ReportSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          } else if (state is ReportFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errMessage),
            ));
          } else if (state is ReportImagePicked) {
            // Optionally handle image picked state
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Image sélectionnée'),
            ));
          } else if (state is ReportVideoPicked) {
            // Optionally handle video picked state
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Vidéo sélectionnée'),
            ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: context.read<ReportCubit>().reportFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 20),
                    
                    // Category Dropdown
                    _buildDropdown(
                      context,
                      label: 'Choisissez la catégorie...',
                      controller: context.read<ReportCubit>().reportCategory,
                      items: ['Accident de la route', 'Travaux en cours', 'Violation de feu rouge',''],
                    ),
                    const SizedBox(height: 12),

                    // Severity Dropdown
                    _buildDropdown(
                      context,
                      label: 'Choisissez la gravité...',
                      controller: context.read<ReportCubit>().reportSeverity,
                      items: ['Faible', 'Moyenne', 'Élevée'],
                    ),
                    const SizedBox(height: 12),

                    // Title TextField
                    _buildTextField(
                      context,
                      hintText: 'Saisissez le titre...',
                      maxLines: 1,
                      controller: context.read<ReportCubit>().reportTitle,
                    ),
                    const SizedBox(height: 12),

                    // Description TextField
                    _buildTextField(
                      context,
                      hintText: 'Saisissez la description...',
                      maxLines: 5,
                      controller: context.read<ReportCubit>().reportDescription,
                    ),
                    const SizedBox(height: 12),

                    // Location Fields
                    _buildTextField(
                      context,
                      hintText: 'Latitude',
                      maxLines: 1,
                      controller: context.read<ReportCubit>().latitude,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      context,
                      hintText: 'Longitude',
                      maxLines: 1,
                      controller: context.read<ReportCubit>().longitude,
                    ),
                    const SizedBox(height: 12),

                    // Phone TextField
                    _buildTextField(
                      context,
                      hintText: 'Numéro de téléphone',
                      maxLines: 1,
                      controller: context.read<ReportCubit>().reportPhone,
                    ),
                    const SizedBox(height: 12),

                    // Image Upload
                    _buildUploadSection(
                      context,
                      title: 'Déposez une image',
                      onTap: () => context.read<ReportCubit>().pickImage(),
                      icon: Icons.photo_camera,
                      fileName: context.read<ReportCubit>().reportImage?.path,
                    ),
                    const SizedBox(height: 12),

                    // Video Upload
                    _buildUploadSection(
                      context,
                      title: 'Déposez une vidéo',
                      onTap: () => context.read<ReportCubit>().pickVideo(),
                      icon: Icons.video_camera_back,
                      fileName: context.read<ReportCubit>().reportVideo?.path,
                    ),
                    const SizedBox(height: 20),

                    // Submit Button
                    _buildSubmitButton(context, state),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Prêt à soumettre votre signalement ?\nRemplissez les informations ci-dessous !',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildDropdown(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required List<String> items,
  }) {
    return DropdownButtonFormField<String>(
      value: controller.text.isNotEmpty ? controller.text : null,
      hint: Text(label, style: const TextStyle(color: Colors.grey)),
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      dropdownColor: AppColors.primary,
      style: const TextStyle(color: Colors.white),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          controller.text = value;
        }
      },
      validator: (value) => controller.text.isEmpty ? 'Veuillez choisir une option' : null,
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String hintText,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: AppColors.primary.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
      validator: (value) => value!.isEmpty ? 'Ce champ est obligatoire' : null,
    );
  }

  Widget _buildUploadSection(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
    required IconData icon,
    String? fileName,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Icon(
              fileName != null ? Icons.check_circle : icon,
              color: AppColors.primary.withOpacity(0.5),
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                fileName != null
                    ? 'Fichier sélectionné: ${fileName.split('/').last}'
                    : title,
                style: TextStyle(color: AppColors.primary, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, ReportState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state is! ReportLoading 
          ? () => context.read<ReportCubit>().createReport() 
          : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: state is ReportLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text(
              'Envoyer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
      ),
    );
  }
}