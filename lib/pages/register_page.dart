import 'package:chatapp/constants.dart';
import 'package:chatapp/main.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper_functions/helper_functions.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  static String id = "registerPage";
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
                    'Register',
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
                text: 'Resgister',
                onTap: () async {
                  // Show a loading indicator during the async operation
                  final dialogContext = context; // Save the current context

                  if (formKey.currentState!.validate()) {
                    try {
                      showLoadingIcon(dialogContext);
                      // Create the user account with email and password
                      await userRegister();
                      Navigator.of(dialogContext, rootNavigator: true).pop();
                      // Show success message if no exceptions occur
                      showsnackbar(context, 'Email Created Successfully');

                      Navigator.pushNamed(context, ChatPage.id,arguments: email);

                    } on FirebaseAuthException catch (e) {
                      // Dismiss loading indicator
                      //Navigator.of(dialogContext, rootNavigator: true).pop();

                      // Handle Firebase-specific exceptions
                      String errorMessage;

                      // Customize error messages based on error codes
                      switch (e.code) {
                        case 'email-already-in-use':
                          errorMessage = 'The email address is already in use.';
                          break;
                        case 'invalid-email':
                          errorMessage = 'The email address is not valid.';
                          break;
                        case 'weak-password':
                          errorMessage = 'The password is too weak.';
                          break;
                        default:
                          errorMessage =
                              'An unexpected error occurred: ${e.message}';
                      }
                      // Show error message as a SnackBar
                      showsnackbar(context, errorMessage);
                      print(e);
                    } catch (e) {
                      // Handle non-Firebase exceptions
                      showsnackbar(context, 'An unexpected error occurred: $e');
                      print(e);
                    }

                    // Dismiss loading indicator
                    Navigator.of(dialogContext, rootNavigator: true).pop();
                  }
                  else {

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
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Login',
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

  Future<void> userRegister() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }

}
