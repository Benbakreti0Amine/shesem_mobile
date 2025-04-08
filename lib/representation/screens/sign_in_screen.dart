import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/static/colors.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/rootpage.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/sign_up_screen.dart';

import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocConsumer<SignInCubit, UserState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تم بنجاح")),
            );
            context.read<SignInCubit>().getUserData();
            Navigator.push( 
              context,
              MaterialPageRoute(
                builder: (context) => const RootPage(),
              ),
            );
          } else if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFEFF2F5),
            body: Stack(
              children: [
                // Top image covering the top part of screen
                Container(
                  height: size.height * 0.35,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/signup.webp"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Login Card
                DraggableScrollableSheet(
                  initialChildSize: 0.7,
                  minChildSize: 0.7,
                  maxChildSize: 1,
                  builder: (context, scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: context.read<SignInCubit>().signInFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image.asset(
                                    "assets/images/wafra.png",
                                    width: 100,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  child: Text(
                                    "مرحباً بك",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "أهلاً بك في وفرة!",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 32),
                                // Phone Number Field
                                _buildTextField(
                                  context,
                                  "رقم الهاتف",
                                  "أدخل رقم هاتفك",
                                  context.read<SignInCubit>().signInPhone,
                                ),
                                const SizedBox(height: 16),
                                // Password Field
                                _buildTextField(
                                  context,
                                  "كلمة المرور",
                                  "أدخل كلمة المرور",
                                  context.read<SignInCubit>().signInPassword,
                                  isPassword: true,
                                ),
                                const SizedBox(height: 16),
                                // Remember Me & Forgot Password Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: true,
                                          onChanged: (value) {},
                                          activeColor: AppColors.primary,
                                        ),
                                        const Text(
                                          "تذكرني",
                                          style: TextStyle(fontSize: 10.5),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "نسيت كلمة المرور؟",
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 10.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                // Sign-In Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RootPage(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: state is SignInLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text(
                                            "تسجيل الدخول",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w100,
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                // Don't Have Account? - Arabic version
                                const ArabicDontHaveAccountWidget(),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    String hint,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      textAlign: TextAlign.right, // Right alignment for Arabic
      textDirection: TextDirection.rtl, // Right to left for Arabic
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: true,
        labelStyle: TextStyle(
          color: Colors.grey[400],
          fontSize: 13,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[200],
          fontSize: 7,
        ),
        filled: true,
        fillColor: Color(0xFFF5F8FA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        suffixIcon: isPassword
            ? const Icon(Icons.visibility_off, color: Colors.grey, size: 13)
            : null,
      ),
    );
  }
}

// Arabic version of the "Don't have an account?" widget
class ArabicDontHaveAccountWidget extends StatelessWidget {
  const ArabicDontHaveAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ليس لديك حساب؟',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
          child: const Text(
            'تسجيل',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
