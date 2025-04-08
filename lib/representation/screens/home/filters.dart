import 'dart:ui';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/static/colors.dart';

class FiltersPopup extends StatefulWidget {
  final VoidCallback onClose;
  final Function(Map<String, dynamic>) onApplyFilters;

  const FiltersPopup({
    Key? key,
    required this.onClose,
    required this.onApplyFilters,
  }) : super(key: key);

  @override
  State<FiltersPopup> createState() => _FiltersPopupState();
}

class _FiltersPopupState extends State<FiltersPopup> {
  String? _selectedSoilType;
  String? _selectedClimateType;
  String? _selectedLandArea;

  final List<String> _soilTypes = [
    'طيني',
    'رملي',
    'طمي',
    'صخري',
    'جيري',
    'طفالي'
  ];

  final List<String> _climateTypes = [
    'صحراوي',
    'معتدل',
    'شبه استوائي',
    'استوائي',
    'قاري',
    'بارد'
  ];

  final List<String> _landAreas = [
    'أقل من 100 متر مربع',
    '100-500 متر مربع',
    '500-1000 متر مربع',
    '1000-5000 متر مربع',
    '5000-10000 متر مربع',
    'أكثر من 10000 متر مربع'
  ];

  void _applyFilters() {
    final filters = {
      'soilType': _selectedSoilType,
      'climateType': _selectedClimateType,
      'landArea': _selectedLandArea,
    };
    
    widget.onApplyFilters(filters);
    widget.onClose();
  }

  void _resetFilters() {
    setState(() {
      _selectedSoilType = null;
      _selectedClimateType = null;
      _selectedLandArea = null;
    });
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

          // Filters content
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "تصفية المنشورات",
                          style: TextStyle(
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
                    const SizedBox(height: 20),
                    
                    // Soil Type Filter
                    const Text(
                      "نوع التربة",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ConditionDropdownWidget(
                      conditions: _soilTypes,
                      selectedCondition: _selectedSoilType,
                      onChanged: (value) {
                        setState(() {
                          _selectedSoilType = value;
                        });
                      },
                      conditionText: 'اختر نوع التربة',
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Climate Type Filter
                    const Text(
                      "نوع المناخ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ConditionDropdownWidget(
                      conditions: _climateTypes,
                      selectedCondition: _selectedClimateType,
                      onChanged: (value) {
                        setState(() {
                          _selectedClimateType = value;
                        });
                      },
                      conditionText: 'اختر نوع المناخ',
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Land Area Filter
                    const Text(
                      "مساحة الأرض",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ConditionDropdownWidget(
                      conditions: _landAreas,
                      selectedCondition: _selectedLandArea,
                      onChanged: (value) {
                        setState(() {
                          _selectedLandArea = value;
                        });
                      },
                      conditionText: 'اختر مساحة الأرض',
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _resetFilters,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text('إعادة ضبط'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _applyFilters,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text('تطبيق الفلاتر'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusing the existing ConditionDropdownWidget from your code
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