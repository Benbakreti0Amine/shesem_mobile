import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Sample user data - would normally come from an API or database
final Map<String, dynamic> userData = {
  'name': 'ياسين بن عبد الله',
  'email': 'yacine.abdallah@gmail.com',
  'phone': '0551234567',
  'location': 'الجزائر العاصمة، الجزائر',
  'bio': 'مهندس زراعي متخصص في تقنيات الري وزراعة الأراضي الجافة. خبرة واسعة في المشاريع الزراعية بمناطق الهضاب العليا والصحراء الجزائرية. أعمل على تطوير أساليب الزراعة المستدامة المناسبة للمناخ المحلي.',
  'expertise': [
    'زراعة النخيل',
    'زراعة الزيتون',
    'تقنيات الري الحديثة',
    'استصلاح الأراضي الصحراوية',
    'الزراعة العضوية'
  ],
  'education': 'دكتوراه في العلوم الزراعية - جامعة وهران للعلوم والتكنولوجيا',
  'experience': '12 سنة',
  'projects': [
    'مشروع تطوير واحات النخيل في بسكرة',
    'برنامج استصلاح الأراضي الصحراوية في ولاية أدرار',
    'مشروع الزراعة المائية في المناطق الشبه صحراوية',
    'تحسين إنتاجية بساتين الزيتون في منطقة القبائل'
  ],
};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
body: Directionality(
        textDirection: TextDirection.rtl, // Set RTL direction for Arabic
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header with image and basic info
                _buildProfileHeader(),
                
                const SizedBox(height: 24),
                
                // Bio section
                _buildSectionTitle('نبذة شخصية'),
                _buildInfoCard(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      userData['bio'],
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Expertise section
                _buildSectionTitle('مجالات الخبرة'),
                _buildInfoCard(
                  child: _buildChipsList(userData['expertise']),
                ),
                
                const SizedBox(height: 16),
                
                // Contact info section
                _buildSectionTitle('معلومات الاتصال'),
                _buildInfoCard(
                  child: Column(
                    children: [
                      _buildContactItem(Icons.email, 'البريد الإلكتروني', userData['email']),
                      const Divider(),
                      _buildContactItem(Icons.phone, 'رقم الهاتف', userData['phone']),
                      const Divider(),
                      _buildContactItem(Icons.location_on, 'الموقع', userData['location']),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Education & Experience
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('التعليم'),
                          _buildInfoCard(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                userData['education'],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('سنوات الخبرة'),
                          _buildInfoCard(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                userData['experience'],
                                style: const TextStyle(
                                  fontSize: 16, 
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Projects section
                _buildSectionTitle('المشاريع'),
                _buildInfoCard(
                  child: Column(
                    children: List.generate(
                      userData['projects'].length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 12.0,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green[700],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                userData['projects'][index],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                

                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Image
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.green[100],
              child: ClipOval(
                child: Image.network(
                  'https://t3.ftcdn.net/jpg/02/82/85/30/360_F_282853038_2x9wGYdEpXt3s39fy3CpQ1d3CqETChF5.jpg',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.green[200],
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // User Name
            Text(
              userData['name'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // User Title/Role
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green[700]!),
              ),
              child: const Text(
                'مهندس زراعي',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn('المشاريع', '12'),
                _buildDivider(),
                _buildStatColumn('المتابعين', '358'),
                _buildDivider(),
                _buildStatColumn('التقييم', '4.8'),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatColumn(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
  
  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey[300],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoCard({required Widget child}) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: child,
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.green[700],
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChipsList(List<dynamic> items) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: items.map<Widget>((item) {
          return Chip(
            label: Text(item),
            backgroundColor: Colors.green[50],
            side: BorderSide(color: Colors.green[100]!),
            labelStyle: TextStyle(color: Colors.green[700]),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          );
        }).toList(),
      ),
    );
  }
}