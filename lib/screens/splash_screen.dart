import 'package:fitness_tracker_frontend/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // Небольшая задержка для показа splash screen
    await Future<void>.delayed(const Duration(seconds: 2));

    if (!mounted) {
      return;
    }

    final isAuthenticated = await AuthService.isAuthenticated();
    if (!mounted) {
      return;
    }

    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Здесь можно добавить логотип приложения
            Icon(Icons.fitness_center, size: 100, color: Colors.blue),
            SizedBox(height: 24),
            Text(
              AppLocalizations.of(context).translate('appTitle'),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            SizedBox(height: 48),
            CircularProgressIndicator(
              color: AppColors.primaryBlue,
            ),
          ],
        ),
      ),
    );
  }
}
