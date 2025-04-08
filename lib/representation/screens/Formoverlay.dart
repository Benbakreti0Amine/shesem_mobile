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
  final _businessPlanController = TextEditingController();
  final _priceController = TextEditingController();

  String? _selectedSoilType;
  String? _selectedClimateType;
  String? _selectedLandArea;

  final List<String> _soilTypes = [
    'تربة طينية',
    'تربة رملية',
    'تربة صخرية',
    'تربة طمييّة',
    'تربة جيرية'
  ];

  final List<String> _climateTypes = [
    'مناخ معتدل',
    'مناخ صحراوي',
    'مناخ ساحلي',
    'مناخ جبلي',
    'مناخ استوائي'
  ];

  final List<String> _landAreas = [
    'أقل من 10 هكتار',
    '10-50 هكتار',
    '50-100 هكتار',
    '100-500 هكتار',
    'أكثر من 500 هكتار'
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission here
      print('Title: ${_titleController.text}');
      print('Description: ${_descriptionController.text}');
      print('Business Plan: ${_businessPlanController.text}');
      print('Price: ${_priceController.text}');
      print('Soil Type: $_selectedSoilType');
      print('Climate Type: $_selectedClimateType');
      print('Land Area: $_selectedLandArea');

      widget.onClose();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _businessPlanController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Title and subtitle
                Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: widget.onClose,
        ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        _getSubtitleForTitle(widget.title),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Image upload section
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Color(0xFFBEDEA7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_outlined,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'إضافة صور',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'قم بتحميل جميع صورك لجذب المستثمرين',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                // Title field
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFBEDEA7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    controller: _titleController,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      hintText: '...العنوان',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'مطلوب' : null,
                  ),
                ),
                SizedBox(height: 16),

                // Description field
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFBEDEA7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    controller: _descriptionController,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: '...قم بكتابة الشرح',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'مطلوب' : null,
                  ),
                ),
                SizedBox(height: 16),

                // Soil type dropdown
                _buildCustomDropdown(
                  hintText: 'نوع التربة',
                  items: _soilTypes,
                  selectedItem: _selectedSoilType,
                  onChanged: (value) {
                    setState(() {
                      _selectedSoilType = value;
                    });
                  },
                ),
                SizedBox(height: 16),

                // Climate type dropdown
                _buildCustomDropdown(
                  hintText: 'نوع المناخ',
                  items: _climateTypes,
                  selectedItem: _selectedClimateType,
                  onChanged: (value) {
                    setState(() {
                      _selectedClimateType = value;
                    });
                  },
                ),
                SizedBox(height: 16),

                // Land area dropdown
                _buildCustomDropdown(
                  hintText: 'مساحة الأرض',
                  items: _landAreas,
                  selectedItem: _selectedLandArea,
                  onChanged: (value) {
                    setState(() {
                      _selectedLandArea = value;
                    });
                  },
                ),
                SizedBox(height: 16),

                // Business plan field
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFBEDEA7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    controller: _businessPlanController,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: '...قم بكتابة خطة العمل',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'مطلوب' : null,
                  ),
                ),
                SizedBox(height: 16),

                // Price field
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFBEDEA7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    controller: _priceController,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '...قم بإدخال السعر المتوقع',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'د.ج',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'مطلوب' : null,
                  ),
                ),
                SizedBox(height: 24),

                // Submit button
                Container(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(
                      'نشر',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF44AA00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Méthode pour obtenir le sous-titre en fonction du titre
  String _getSubtitleForTitle(String title) {
    if (title == 'البحث عن مستثمر') {
      return 'مشروع زراعي ناجح يبحث عن مستثمر يؤمن بالنمو المستدام';
    } else if (title == 'بيع فرصة عمل') {
      return 'قم بعرض فرصة العمل الخاصة بك للمهتمين في المجال الزراعي';
    } else {
      return 'أدخل التفاصيل المطلوبة لإكمال العملية';
    }
  }

  Widget _buildCustomDropdown({
    required String hintText,
    required List<String> items,
    required String? selectedItem,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFBEDEA7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                hintText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
            onPressed: () {
              // Show dropdown menu
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          items[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: selectedItem == items[index]
                                ? Color(0xFF44AA00)
                                : Colors.black,
                            fontWeight: selectedItem == items[index]
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        onTap: () {
                          onChanged(items[index]);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
