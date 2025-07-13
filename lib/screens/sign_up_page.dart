import 'package:fitness_tracker_frontend/screens/main_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/primary_button.dart';
import '../widgets/custom_text_field.dart';
import '../screens/sign_in_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 24,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 60),
                      const Text(
                        "Let's get started!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: 'Sign ',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: 'up',
                              style: TextStyle(
                                color: Color(0xFF2979FF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const CustomTextField(
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      const CustomTextField(
                        hintText: 'Enter password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 16),
                      const CustomTextField(
                        hintText: 'Confirm password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 28),
                      PrimaryButton(
                        text: 'Sign up',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already registered? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInPage(),
                        ),
                      );
                    }, // TODO: Навигация на SignInPage
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        color: Color(0xFF2979FF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
