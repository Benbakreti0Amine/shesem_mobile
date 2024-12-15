import 'package:flutter/material.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/static/colors.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String? selectedCategory;
  String? selectedGravity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildDropdown(
              label: 'Choisissez la catégorie...',
              value: selectedCategory,
              items: ['Accident', 'Travaux', 'Embouteillage'],
              onChanged: (value) => setState(() => selectedCategory = value),
            ),
            const SizedBox(height: 12),
            _buildDropdown(
              label: 'Choisissez la gravité...',
              value: selectedGravity,
              items: ['Faible', 'Moyenne', 'Élevée'],
              onChanged: (value) => setState(() => selectedGravity = value),
            ),
            const SizedBox(height: 12),
            _buildTextField(
              hintText: 'Saisissez le titre...',
              maxLines: 1,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              hintText: 'Saisissez la description...',
              maxLines: 5,
            ),
            const SizedBox(height: 12),
            _buildUploadSection(),
            const SizedBox(height: 20),
            _buildSubmitButton(),
          ],
        ),
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

  Widget _buildDropdown({
    required String label,
    required List<String> items,
    String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
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
      onChanged: onChanged,
    );
  }

  Widget _buildTextField({required String hintText, required int maxLines}) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:  TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: AppColors.primary.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildUploadSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Icon(Icons.photo_camera, color: AppColors.primary.withOpacity(0.5),size: 12,),
          const SizedBox(width: 12),
          Text(
            'Déposez une image ou une vidéo ici...',
            style: TextStyle(color: AppColors.primary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Handle form submission
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
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
