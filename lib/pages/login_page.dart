import 'package:chatapp/constants.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper_functions/helper_functions.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static String id = "LoginPage";
  String? email;
  String? password;
  GlobalKey<FormState> formKey =GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              // Spacer(
              //   flex: 1,
              // ),
              const SizedBox(
                height: 100,
              ),
              Image.asset(
                'assets/images/scholar.png',
                height: 100,
              ),
              const Center(
                child: Text(
                  'Scholar Chat',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'pacifico',
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              const Row(
                children: [
                  Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hintText: 'Email',
                onchange: (data) {
                  email = data;
                  print(data);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                obscureText: true,
                hintText: 'Password',
                onchange: (data) {
                  password = data;
                  print(data);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                text: 'Login',
                  onTap: () async {
                    final dialogContext = context;
                    if (formKey.currentState!.validate()) {
                      try {
                        showLoadingIcon(dialogContext);

                        // Ensure email and password are trimmed
                        email = email?.trim();
                        password = password?.trim();
                        print('Email: $email, Password: $password'); // Debugging

                        // Attempt login
                        await userLogin();
                        Navigator.of(dialogContext, rootNavigator: true).pop();
                        // Show success message
                        showsnackbar(context, 'Login Successfully');
                        Navigator.pushNamed(context, ChatPage.id,arguments: email);
                      } on FirebaseAuthException catch (e) {
                        String errorMessage;
                        switch (e.code) {
                          case 'user-not-found':
                            errorMessage = 'No user found for that email.';
                            break;
                          case 'wrong-password':
                            errorMessage = 'Wrong password provided.';
                            break;
                          case 'invalid-credential':
                            errorMessage = 'Invalid credentials supplied.';
                            break;
                          default:
                            errorMessage = 'An unexpected error occurred: ${e.message}';
                        }
                        Navigator.of(dialogContext, rootNavigator: true).pop();
                        showsnackbar(context, errorMessage);
                        print('Error code: ${e.code}');
                        print('Error message: ${e.message}');
                      }
                    }
                  },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'already have an account?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //Navigator.pop(context);
                      Navigator.pushNamed(context, RegisterPage.id);
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Color(0xffC7EDE6),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> userLogin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }

}


