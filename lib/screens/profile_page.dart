import 'dart:async';
import 'package:fitness_tracker_frontend/services/workout_service.dart';
import 'package:fitness_tracker_frontend/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../services/ai_suggestion_service.dart';
import '../services/auth_service.dart';
import '../models/auth_models.dart';
import '../utils/toast_utils.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;
  bool _isLoading = true;
  int _workoutSessions = 0;
  bool _isSessionsLoading = true;
  String _aiSuggestion = 'Loading AI insights...';
  bool _isSuggestionLoading = true;
  bool _suggestionError = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await _loadUserData();
    await Future.wait([
      _loadWorkoutSessions(),
      _loadAiSuggestion(),
    ]);
  }

  Future<void> _loadAiSuggestion() async {
    try {
      setState(() {
        _isSuggestionLoading = true;
        _suggestionError = false;
      });

      final suggestion = await SuggestionService.getSuggestion()
          .timeout(const Duration(seconds: 15));

      if (mounted) {
        setState(() {
          _aiSuggestion = suggestion;
          _isSuggestionLoading = false;
        });
      }
    } on TimeoutException {
      if (mounted) {
        setState(() {
          _aiSuggestion = 'Request timed out. Please try again.';
          _isSuggestionLoading = false;
          _suggestionError = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _aiSuggestion = 'Failed to load AI insights. Please try later.';
          _isSuggestionLoading = false;
          _suggestionError = true;
        });
      }
      debugPrint('AI suggestion error: $e');
    }
  }

  Future<void> _loadUserData() async {
    try {
      final user = await AuthService.getUserData();
      if (mounted) {
        setState(() {
          _user = user;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ToastUtils.showError(
            AppLocalizations.of(context).translate('failedLoadUser'));
      }
    }
  }

  Future<void> _loadWorkoutSessions() async {
    try {
      final sessions = await WorkoutService.getWorkoutSessions();
      if (mounted) {
        setState(() {
          _workoutSessions = sessions.length;
          _isSessionsLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSessionsLoading = false;
        });
        ToastUtils.showError(
            AppLocalizations.of(context).translate('failedLoadSessions'));
      }
    }
  }

  Future<void> _signOut() async {
    try {
      await AuthService.signOut();
      if (mounted) {
        ToastUtils.showInfo(
            AppLocalizations.of(context).translate('signedOut'));
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      if (mounted) {
        ToastUtils.showError(
            AppLocalizations.of(context).translate('failedSignOut'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: false,
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
          IconButton(
            icon: Icon(
              MyApp.of(context).themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              final isDark = MyApp.of(context).themeMode == ThemeMode.dark;
              MyApp.of(context).setThemeMode(
                  isDark ? ThemeMode.light : ThemeMode.dark);
            },
          ),
        ],
        title:  Text(
          AppLocalizations.of(context).translate('profileTitle'),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: _isLoading ?
        const Center(child: CircularProgressIndicator()) :
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Center(
                child: Image.asset(
                  'assets/images/person.png',
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                _user?.email ?? AppLocalizations.of(context).translate('noEmail'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _user?.name ?? AppLocalizations.of(context).translate('noName'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context).translate('totalWorkouts'),
                  style: const TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: _isSessionsLoading
                          ? '...'
                          : _workoutSessions.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('aiInsight'),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        AppLocalizations.of(context).translate('aiText'),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  if (_suggestionError)
                    IconButton(
                      icon: const Icon(Icons.refresh, size: 20),
                      onPressed: _loadAiSuggestion,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _isSuggestionLoading ?
                const CircularProgressIndicator(
                  color: AppColors.primaryBlue,
                ) :
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _aiSuggestion.replaceAll('**', ''),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: _signOut,
                child: Text(
                  AppLocalizations.of(context).translate('logOut'),
                  style: const TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
