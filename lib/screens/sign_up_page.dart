import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/custom_text_field.dart';
import '../services/auth_service.dart';
import '../utils/toast_utils.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await AuthService.signUp(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (mounted) {
        ToastUtils.showSuccess(
            AppLocalizations.of(context).translate('registrationSuccessful'));
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      if (mounted) {
        ToastUtils.showAuthError(context);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.language,
                color: Theme.of(context).iconTheme.color),
            onPressed: () {
              final currentLocale = Localizations.localeOf(context);
              final newLocale = currentLocale.languageCode == 'en'
                  ? const Locale('ru')
                  : const Locale('en');
              MyApp.of(context).setLocale(newLocale);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 60),
                        Text(
                          AppLocalizations.of(context).translate('letsStart'),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: AppLocalizations.of(context)
                                  .translate('signUpPart1'),
                              style: TextStyle(
                                fontSize: 24,
                                color: Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)
                                      .translate('signUpPart2'),
                                  style: const TextStyle(
                                    color: AppColors.primaryBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 24),
                        CustomTextField(
                            controller: _nameController,
                            hintText:
                                AppLocalizations.of(context).translate('name'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                                return AppLocalizations.of(context)
                                    .translate('enterName');
                              }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                            controller: _emailController,
                            hintText:
                                AppLocalizations.of(context).translate('email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                                return AppLocalizations.of(context)
                                    .translate('enterEmail');
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value)) {
                                return AppLocalizations.of(context)
                                    .translate('enterValidEmail');
                              }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                            controller: _passwordController,
                            hintText: AppLocalizations.of(context)
                                .translate('enterPass'),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)
                                    .translate('enterAPassword');
                              }
                              if (value.length < 6) {
                                return AppLocalizations.of(context)
                                    .translate('passwordLength');
                              }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                            controller: _confirmPasswordController,
                            hintText: AppLocalizations.of(context)
                                .translate('confirmPassword'),
                          obscureText: true,
                          validator: (value) {
                             if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)
                                    .translate('enterConfirmPassword');
                              }
                              if (value != _passwordController.text) {
                                return AppLocalizations.of(context)
                                    .translate('passwordMismatch');
                              }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        PrimaryButton(
                            text: _isLoading
                                ? AppLocalizations.of(context)
                                    .translate('signingUp')
                                : AppLocalizations.of(context)
                                    .translate('signUp'),
                            onPressed: _isLoading ? null : _signUp,
                          ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)
                        .translate('alreadyRegistered'),
                    style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('signIn'),
                      style: const TextStyle(
                        color: AppColors.primaryBlue,
                        fontSize: 16,
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
