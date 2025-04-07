import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/cubit/report_state.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/cubit/user_report_cubit.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/static/colors.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Green background rectangle
            Stack(
              children: [
                // Green rectangle with rounded bottom corners
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CAF50),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                
                // Weather widget
                Positioned(
                  top: 30,
                  left: 16,
                  right: 16,
                  child: Container(
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        // Right aligned header text
                        Positioned(
                          top: 10,
                          right: 15,
                          child: Text(
                            'وهران، الجزائر',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        
                        // Left aligned date text
                        Positioned(
                          top: 10,
                          left: 15,
                          child: Text(
                            'الأحد، 12 ديسمبر 2024',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        
                        // Temperature display
                        Positioned(
                          top: 40,
                          right: 15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '°24',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              Text(
                                '71.6F°',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Weather icon
                        // Positioned(
                        //   top: 35,
                        //   left: 15,
                        //   child: Image.asset(
                        //     'assets/images/Image.png', // Replace with actual path to weather icon
                        //     width: 70,
                        //     height: 70,
                        //   ),
                        // ),
                        
                        // Weather condition text
                        Positioned(
                          bottom: 10,
                          left: 30,
                          child: Text(
                            'مشمس',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        
                        // Weather details row
                        Positioned(
                          bottom: 10,
                          right: 15,
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Text(
                                '10 km/h',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.air, size: 14),
                              SizedBox(width: 15),
                              Text(
                                '83 %',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.water_drop, size: 14),
                              SizedBox(width: 15),
                              Text(
                                '2 of 10',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.wb_sunny_outlined, size: 14),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Post item
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Post header with profile pic and name
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/images/profile.jpg'), // Replace with actual path
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'وراد أشرف شرف الدين',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            Text(
                              'نيو بوست، الجزائر',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.more_horiz),
                      ],
                    ),
                  ),
                  
                  // Post image
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/grazing_cattle.jpg', // Replace with actual path
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                  // Dots indicator
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          width: index == 0 ? 8 : 6,
                          height: index == 0 ? 8 : 6,
                          decoration: BoxDecoration(
                            color: index == 0 ? Colors.blue : Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // You can add more post items here to make the list scrollable
            // Duplicate post items
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              height: 300, // Placeholder for another post
            ),
            
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              height: 300, // Placeholder for another post
            ),
          ],
        ),
      ),
    );
  }
}