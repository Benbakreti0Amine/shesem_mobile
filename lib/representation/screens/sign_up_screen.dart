
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/user_cubit.dart';
import '../cubit/user_signupcubit.dart';
import '../cubit/user_state.dart';
import 'widgets/already_have_an_account_widget.dart';
import 'widgets/custom_form_button.dart';
import 'widgets/custom_input_field.dart';
import 'widgets/page_heading.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: const Color(0xffEEF1F3),
            body: SingleChildScrollView(
              child: Form(
                key: context.read<SignUpCubit>().signUpFormKey,
                child: Column(
                  children: [
                    const PageHeading(title: 'Sign-up'),
                    const SizedBox(height: 16),
                    //! Name
                    CustomInputField(
                      labelText: 'Username',
                      hintText: 'Your Username',
                      isDense: true,
                      controller: context.read<SignUpCubit>().signUpName,
                    ),
                    const SizedBox(height: 16),
                    //!Email
                    CustomInputField(
                      labelText: 'Email',
                      hintText: 'Your email',
                      isDense: true,
                      controller: context.read<SignUpCubit>().signUpEmail,
                    ),
                    const SizedBox(height: 16),
                    //! Phone Number
                    CustomInputField(
                      labelText: 'First name',
                      hintText: 'Your first name',
                      isDense: true,
                      controller: context.read<SignUpCubit>().signUpFirstname,
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      labelText: 'Last name',
                      hintText: 'Your last name',
                      isDense: true,
                      controller: context.read<SignUpCubit>().signUpLastname,
                    ),
                    const SizedBox(height: 16),
                    //! Password
                    CustomInputField(
                      labelText: 'Password',
                      hintText: 'Your password',
                      isDense: true,
                      obscureText: true,
                      suffixIcon: true,
                      controller: context.read<SignUpCubit>().signUpPassword,
                    ),
                    //! Confirm Password
                    
                    const SizedBox(height: 22),
                    //!Sign Up Button
                    state is SignUpLoading
                        ? const CircularProgressIndicator()
                        : CustomFormButton(
                            innerText: 'Signup',
                            onPressed: () {
                              context.read<SignUpCubit>().signUp();
                            },
                          ),
                    const SizedBox(height: 18),
                    //! Already have an account widget
                    const AlreadyHaveAnAccountWidget(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}