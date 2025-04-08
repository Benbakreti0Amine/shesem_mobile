import 'package:flutter/material.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/ChatScreen.dart';

class AlertsPage extends StatefulWidget {
  @override
  AlertsState createState() => AlertsState();
}

class AlertsState extends State<AlertsPage> {
  // Liste des conversations
  final List<Map<String, dynamic>> conversations = [
    {
      'name': 'مختاري مريم',
      'message': 'نتسقفهم كل صباح والتربة تبقى رطبة...',
      'image': 'assets/images/profileM.png',
      'time': '10:30',
    },
    {
      'name': 'وراد إسلام شرف الدين',
      'message': 'السقي الزائد يسبب تعفن الجذور. جرب تسقي...',
      'image': 'assets/images/profile.png',
      'time': '09:15',
    },
    {
      'name': 'وراد عبد الباري',
      'message': 'عليكم السلام',
      'image': 'assets/images/profile.png',
      'time': '08:45',
    },
    {
      'name': 'بن بكريتي محمد الامين',
      'message': 'الأوراق قاعدة تصفر، عندكم فكرة على السبب؟',
      'image': 'assets/images/profile.png',
      'time': '08:20',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF43A700),
        title: Text(
          'المحادثات',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.separated(
        itemCount: conversations.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey[300],
          height: 1,
          indent: 16,
          endIndent: 16,
        ),
        itemBuilder: (context, index) {
          final conversation = conversations[index];
          return InkWell(
            onTap: () {
              // Navigation vers l'écran de chat individuel
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    name: conversation['name'],
                    profileImage: conversation['image'],
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                textDirection: TextDirection.rtl, // Direction RTL pour l'arabe
                children: [
                  // Image de profil
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(conversation['image']),
                  ),
                  SizedBox(width: 16),
                  // Nom et message
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          conversation['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: 4),
                        Text(
                          conversation['message'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    
    );
  }
}
