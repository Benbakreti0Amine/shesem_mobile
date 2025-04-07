import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        // Remove appBar property completely
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  // color: Color(0xFF44AA00),
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
        body: Column(
          children: [
            // Barre de recherche et menu avec fond vert uni
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF44AA00), // Vert uni pour toute la section
                ),
                child: Row(
                  children: [
                    // Search bar
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, bottom: 8.0, top: 8),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFFD4D4D4).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color:
                                    Colors.white), // Juste une bordure blanche
                          ),
                          child: TextField(
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: '...البحث عن خطة عمل',
                              hintStyle: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.white),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),

                    // Menu button
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFD4D4D4)
                              .withOpacity(0.3), // Même vert, pas de contraste
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.menu, color: Colors.white, size: 20),
                          onPressed: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Scrollable content below the search bar
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Stack(
                    clipBehavior: Clip.none, 
                    children: [
                      // Rectangle vert
                      Container(
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Color(0xFF44AA00),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                      ),

                      // Image au-dessus du rectangle
                      Positioned(
                        top: -10, 
                        left: 0,
                        right: 0,
                        child: Transform.scale(
                          scale: 1.2,
                          child: SizedBox(
                            height: 190,  // Augmenté pour donner plus d'espace à l'image
                            child: Image.asset(
                              'assets/images/sunny_cloud.png',
                              fit: BoxFit.cover,  // Modifié pour mieux remplir l'espace
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),

                  // Post item - Styled exactly like the image
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
                                backgroundImage: AssetImage(
                                    'assets/images/profileM.png'),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'مختاري مريم',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  Text(
                                    'عين تموشنت، الجزائر',
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
                                    '4.5',
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

                        // Post main image with dots and tags overlay
                        Stack(
                          children: [
                            // Horizontal scrollable images
                            Container(
                              height: 200,
                              child: PageView.builder(
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Image.asset(
                                    'assets/images/post.jpg',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  );
                                },
                              ),
                            ),
                            
                            // Overlay at the bottom of the image with dots and tags
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  
                                    
                                    // Green tags on the right
                                    Row(
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        _buildGreenTag('تربة ترابية'),
                                        SizedBox(width: 6),
                                        _buildGreenTag('مناخ معتدل'),
                                        SizedBox(width: 6),
                                        _buildGreenTag('أكثر من 50 هكتار'),
                                      ],
                                    ),
                                      // Dots indicator on the left
                                    Row(
                                      children: List.generate(
                                        4,
                                        (index) => Container(
                                          margin: EdgeInsets.symmetric(horizontal: 2),
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: index == 0
                                                ? Colors.white
                                                : Colors.white.withOpacity(0.5),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.grey.withOpacity(0.5),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Post title
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            'سر محصول الطماطم الناجح',
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
                          child: Text(
                            'سر الحصول على محصول طماطم ناجح يبدأ بالسقي المنتظم صباحاً مما يساعد على تقوية الجذور وتفادي الأمراض. بالإضافة إلى ذلك، احترمت فترات التسميد القصوى كل 15 يوم باستخدام سماد طبيعي مخضر من بقايا عرض المزيد...',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
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
                                '3500 د.ج',
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
                                  size: 11,
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
                  ),

                  // Duplicate post for scrolling
                  _buildPostItem(context),
                  _buildPostItem(context),
                ],
              ),
            ),
          ],
        ),
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

  // Helper method to build a complete post item
  Widget _buildPostItem(BuildContext context) {
    return Container(
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
                  backgroundImage: AssetImage('assets/images/profileM.png'),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'وراد إسلام شرف الدين',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      'عين تموشنت، الجزائر',
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
                      '4.5',
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

          // Post main image with dots and tags overlay
          Stack(
            children: [
              // Horizontal scrollable images
              Container(
                height: 200,
                child: PageView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      'assets/images/post.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                ),
              ),
              
              // Overlay at the bottom of the image with dots and tags
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Dots indicator on the left
                      Row(
                        children: List.generate(
                          4,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: index == 0
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      // Green tags on the right
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          _buildGreenTag('تربة ترابية'),
                          SizedBox(width: 6),
                          _buildGreenTag('مناخ معتدل'),
                          SizedBox(width: 6),
                          _buildGreenTag('أكثر من 50 هكتار'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Post title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'سر محصول الطماطم الناجح',
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
            child: Text(
              'سر الحصول على محصول طماطم ناجح يبدأ بالسقي المنتظم صباحاً مما يساعد على تقوية الجذور وتفادي الأمراض. بالإضافة إلى ذلك، احترمت فترات التسميد القصوى كل 15 يوم باستخدام سماد طبيعي مخضر من بقايا عرض المزيد...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
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
                  '3500 د.ج',
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
                    size: 11,
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
}
