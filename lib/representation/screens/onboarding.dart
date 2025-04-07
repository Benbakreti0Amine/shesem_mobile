import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/static/colors.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/sign_up_screen.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final PageController on_board_page_controller =
      PageController(initialPage: 0);
  int current_index = 0;

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 10,
      width: isActive ? 20 : 8,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (var i = 0; i < 3; i++) {
      if (i == current_index) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove the AppBar to allow full-screen background
      body: Stack(
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                current_index = page;
              });
            },
            controller: on_board_page_controller,
            children: [
              Create_full_page(
                  image: 'assets/images/plant-one.jpg',
                  title: 'فلاحون بخبرة، وشباب بطموح، ومستثمرون برؤية.',
                  description: 'سواء كنت فلاحًا، أو خبيرًا زراعيًا، أو صاحب رأس مال، نوفر لك فضاءً ذكيًا للتلاقي، وتبادل المنفعة، وإنجاح المشاريع الفلاحية والمواشي.'
              ),
              Create_full_page(
                  image: 'assets/images/plant-two.jpg',
                  title: 'من الأرض... إلى السوق، رحلة متكاملة.',
                  description: 'أنشئ مشروع فلاحي أو حيواني، شارك خبراتك ووصفاتك المجربة، وابحث عن داعمين وشركاء يشاركونك الحلم والنجاح.'
              ),
              Create_full_page(
                  image: 'assets/images/plant-three.jpg',
                  title:'الثروة الحيوانية شريك استراتيجي في الأمن الغذائي.',
                  description: 'من تربية المواشي إلى إنتاج الحليب واللحوم... وفرنا لك منصة تجمع المربين بالمستثمرين والخبراء لإنجاح كل مشروع حيواني'
              ),
            ],
          ),
          Positioned(
              bottom: 20,
              left: 165,
              child: Row(
                children: _buildIndicator(),
              )),
          Positioned(
            bottom: 60,
            right: 0,
            left: 0,
            child: Center(
              child: Container(
                width: 60,
                height: 60,
                padding: EdgeInsets.all(10),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (current_index < 2) {
                        current_index++;
                        if (current_index < 3) {
                          on_board_page_controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      }
                      else{
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const SignUpScreen()));
                      }});
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF7CFC00), // Bright green color
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
     
        ],
      ),
    );
  }
}

class Create_full_page extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  
  const Create_full_page({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Full-screen background image
        Image.asset(
          image,
          fit: BoxFit.cover,
        ),
        // Dark overlay to make text more readable
        Container(
          color: Colors.black.withOpacity(0.3),
        ),
        // Logo 
      
           Positioned(
            bottom: 280,
          left: 20,
          right: 20,
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 100,
                ),
              ],
                       ),
           ),
        
        // Text content at the bottom
        Positioned(
          bottom: 150,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}