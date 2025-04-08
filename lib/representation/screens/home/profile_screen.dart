import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // Green header with search bar and menu
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              color: Color(0xFF44AA00),
              child: Row(
                children: [
                  // Menu button
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFD4D4D4).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.menu, color: Colors.white, size: 20),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  
                  // Search bar
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFD4D4D4).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white),
                      ),
                      child: TextField(
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: '...البحث عن فرصة استثمار',
                          hintStyle: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Scrollable content
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // First post card
                  _buildPostCard(
                    rating: '3.2',
                    name: 'مختاري مريم',
                    location: 'عين تموشنت، الجزائر',
                    imagePath: 'assets/images/workers.jpg',
                    tags: ['تربة ترابية', 'مناخ معتدل', 'أكثر من 50 هكتار'],
                    title: 'فرصة استثمار في تنمية مشروع فلاحي',
                    description: 'أبحث عن مستثمر أجنبي أو محلي لتوسيع مشروعي الفلاحي القائم على زراعة النخيل والأشجار المثمرة والخضار أحتاج إلى تمويل لإجراء عملية توسعة',
                    price: '250000 د.ج',
                  ),
                  
                  // Second post card
                  _buildPostCard(
                    rating: '2.9',
                    name: 'وراد إسلام شرف الدين',
                    location: 'العاصمة، الجزائر',
                    imagePath: 'assets/images/field.jpg',
                    tags: ['تربة ترابية', 'مناخ معتدل', 'أكثر من 50 هكتار'],
                    title: 'سر محصول الطماطم الناجح',
                    description: 'سر الحصول على محصول طماطم ناجح يبدأ بالسقي المنتظم صباحاً مما يساعد على تقوية الجذور وتفادي الأمراض. بالإضافة إلى ذلك، احترمت فترات التسميد القصوى كل 15 يوم باستخدام سماد طبيعي مخضر من بقايا',
                    price: '3500 د.ج',
                  ),
                  
                  // Third post card (similar to second for demonstration)
                  _buildPostCard(
                    rating: '4.1',
                    name: 'أحمد محمد',
                    location: 'وهران، الجزائر',
                    imagePath: 'assets/images/field.jpg',
                    tags: ['تربة ترابية', 'مناخ معتدل', 'أكثر من 30 هكتار'],
                    title: 'زراعة الحمضيات بتقنيات حديثة',
                    description: 'تجربتي في زراعة الحمضيات باستخدام تقنيات الري الحديثة أدت إلى زيادة الإنتاج بنسبة 40٪. استخدمت نظام الري بالتنقيط مع برمجة أوقات الري حسب احتياجات النبات والظروف المناخية',
                    price: '4200 د.ج',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF44AA00),
              ),
              child: Text(
                'القائمة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            ListTile(
              title: Text('الصفحة الرئيسية', textAlign: TextAlign.right),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('الإعدادات', textAlign: TextAlign.right),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a post card
  Widget _buildPostCard({
    required String rating,
    required String name,
    required String location,
    required String imagePath,
    required List<String> tags,
    required String title,
    required String description,
    required String price,
  }) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Post header with rating, profile pic and name
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      rating,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Post main image with tags overlay
          Stack(
            children: [
              // Image
              Container(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Overlay at the bottom of the image with tags
              if (tags.isNotEmpty)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: tags.map((tag) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: _buildGreenTag(tag),
                      )).toList(),
                    ),
                  ),
                ),
            ],
          ),

          // Post title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
          ),

          // Post description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RichText(
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
                children: [
                  TextSpan(
                    text: description,
                  ),
                ],
              ),
            ),
          ),
          
          // "Show more" button
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Action when "Show more" is pressed
                },
                child: Text(
                  'عرض المزيد...',
                  style: TextStyle(
                    color: Color(0xFF44AA00),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.right,
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 30),
                  alignment: Alignment.centerRight,
                ),
              ),
            ),
          ),

          // Footer with price and contact button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Price
                Text(
                  price,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF44AA00),
                  ),
                ),
                // Contact button
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                    size: 18,
                  ),
                  label: Text(
                    'تواصل',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF44AA00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build green tags
  Widget _buildGreenTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFF44AA00).withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
