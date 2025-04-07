import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/user_signupcubit.dart';
import '../cubit/user_state.dart';
import 'widgets/already_have_an_account_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocConsumer<SignUpCubit, UserState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          } else if (state is SignUpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errMessage),
            ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFEFF2F5),
            body: Stack(
              children: [
                Container(
                  height: size.height * 0.35,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/image.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
                          padding: const EdgeInsets.all(24.0),
                          child: Form(
                            key: context.read<SignUpCubit>().signUpFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    "سمارت رود",
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  child: Text(
                                    "مرحباً بالعضو الجديد،",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "أهلاً بك في سمارت رود!",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 32),
                                _buildTextField(
                                  context,
                                  "الاسم العائلي",
                                  "أدخل اسمك العائلي",
                                  context.read<SignUpCubit>().signUpName,
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  context,
                                  "الاسم الأول",
                                  "أدخل اسمك الأول",
                                  context.read<SignUpCubit>().signUpFirstname,
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  context,
                                  "رقم الهاتف",
                                  "أدخل رقم هاتفك",
                                  context.read<SignUpCubit>().SignupPhone,
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  context,
                                  "كلمة المرور",
                                  "أدخل كلمة المرور",
                                  context.read<SignUpCubit>().signUpPassword,
                                  isPassword: true,
                                ),
                                const SizedBox(height: 22),
                                _buildOptionalTextField(
                                  context,
                                  "الوصف",
                                  "أدخل وصفاً عن نفسك...",
                                  context.read<SignUpCubit>().description,
                                ),
                                const SizedBox(height: 22),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.read<SignUpCubit>().signUp();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(26, 64, 113, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: state is SignUpLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white)
                                        : const Text(
                                            "تسجيل",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w100,
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                const ArabicAlreadyHaveAnAccountWidget(),
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

  Widget _buildOptionalTextField(
    BuildContext context,
    String label,
    String hint,
    TextEditingController controller,
  ) {
    bool isFieldEnabled = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isFieldEnabled,
                  onChanged: (value) {
                    setState(() {
                      isFieldEnabled = value ?? false;
                    });
                  },
                  activeColor: Color.fromRGBO(26, 64, 113, 1),
                ),
                Text(
                  "هل ترغب في إضافة وصف عن نفسك؟",
                  style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            if (isFieldEnabled)
              TextField(
                controller: controller,
                textAlign: TextAlign.right, // Right alignment for Arabic
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 13,
                  ),
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 10,
                  ),
                  filled: true,
                  fillColor: Color(0xFFF5F8FA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
          ],
        );
      },
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

// New Arabic version of the AlreadyHaveAnAccountWidget
class ArabicAlreadyHaveAnAccountWidget extends StatelessWidget {
  const ArabicAlreadyHaveAnAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'لديك حساب بالفعل؟',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        TextButton(
          onPressed: () {
            // Navigate to Sign In page
          },
          child: const Text(
            'تسجيل الدخول',
            style: TextStyle(
              color: Color.fromRGBO(26, 64, 113, 1),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}