import 'dart:ui';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/static/colors.dart';


class FormOverlay extends StatefulWidget {
  final String title;
  final VoidCallback onClose;

  const FormOverlay({
    Key? key,
    required this.title,
    required this.onClose,
  }) : super(key: key);

  @override
  State<FormOverlay> createState() => _FormOverlayState();
}

class _FormOverlayState extends State<FormOverlay> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  String? _selectedCategory;
  String? _selectedLocation;

  final List<String> _categories = [
    'زراعي',
    'صناعي',
    'تجاري',
    'عقاري',
    'خدمات'
  ];

  final List<String> _locations = [
    'الرياض',
    'جدة',
    'الدمام',
    'مكة',
    'المدينة المنورة',
    'تبوك',
    'نجران',
    'حائل',
    'القصيم'
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission here
      print('Title: ${_titleController.text}');
      print('Description: ${_descriptionController.text}');
      print('Amount: ${_amountController.text}');
      print('Category: $_selectedCategory');
      print('Location: $_selectedLocation');

      widget.onClose();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.transparent,
    body: Stack(
      children: [
        // Blurry background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Container(
            color: Colors.black.withOpacity(0.3), // optional dim
          ),
        ),

        // Form content
        Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.symmetric(vertical: 40),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: widget.onClose,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'العنوان'),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'مطلوب' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(labelText: 'الوصف'),
                      maxLines: 3,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'مطلوب' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _amountController,
                      decoration: const InputDecoration(labelText: 'المبلغ'),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'مطلوب' : null,
                    ),
                    const SizedBox(height: 12),
                    ConditionDropdownWidget(
                      conditions: _categories,
                      selectedCondition: _selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      conditionText: 'اختر الفئة',
                    ),
                    const SizedBox(height: 12),
                    ConditionDropdownWidget(
                      conditions: _locations,
                      selectedCondition: _selectedLocation,
                      onChanged: (value) {
                        setState(() {
                          _selectedLocation = value;
                        });
                      },
                      conditionText: 'اختر الموقع',
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('إرسال'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


}


class ConditionDropdownWidget extends StatelessWidget {
  final List<String> conditions;
  final String? selectedCondition;
  final ValueChanged<String?> onChanged;
  final String conditionText;
  final bool search;

  const ConditionDropdownWidget({
    Key? key,
    required this.conditions,
    required this.selectedCondition,
    required this.onChanged,
    required this.conditionText,
    this.search = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return search
        ? CustomDropdown<String>(
            decoration: CustomDropdownDecoration(
              closedFillColor: AppColors.secondary,
              expandedFillColor: AppColors.secondary,
              closedSuffixIcon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white70,
                size: 20,
              ),
              expandedSuffixIcon: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white70,
                size: 20,
              ),
              closedBorderRadius: BorderRadius.circular(8),
              expandedBorderRadius: BorderRadius.circular(8),
              closedBorder: Border.all(color: Colors.white.withOpacity(0.1)),
              expandedBorder: Border.all(color: Colors.white.withOpacity(0.1)),
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 12,
              ),
              headerStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              listItemStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              listItemDecoration: const ListItemDecoration(
                selectedColor: Color(0xFF373760),
              ),
            ),
            hintText: conditionText,
            items: conditions,
            initialItem: selectedCondition,
            closedHeaderPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            expandedHeaderPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            itemsListPadding: EdgeInsets.zero,
            listItemPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            onChanged: onChanged,
          )
        : CustomDropdown<String>(
            decoration: CustomDropdownDecoration(
              closedFillColor: AppColors.secondary,
              expandedFillColor: AppColors.secondary,
              closedSuffixIcon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white70,
                size: 20,
              ),
              expandedSuffixIcon: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white70,
                size: 20,
              ),
              closedBorderRadius: BorderRadius.circular(8),
              expandedBorderRadius: BorderRadius.circular(8),
              closedBorder: Border.all(color: Colors.white.withOpacity(0.1)),
              expandedBorder: Border.all(color: Colors.white.withOpacity(0.1)),
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 12,
              ),
              headerStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              listItemStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              listItemDecoration: const ListItemDecoration(
                selectedColor: Color(0xFF373760),
              ),
            ),
            hintText: conditionText,
            items: conditions,
            initialItem: selectedCondition,
            closedHeaderPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            expandedHeaderPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            itemsListPadding: EdgeInsets.zero,
            listItemPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            onChanged: onChanged,
          );
  }
}
