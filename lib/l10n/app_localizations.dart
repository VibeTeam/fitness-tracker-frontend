import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const supportedLocales = [Locale('en'), Locale('ru')];

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'Fitness Tracker',
      'welcomeBack': 'Welcome back!',
      'signInPart1': 'Sign ',
      'signInPart2': 'in',
      'email': 'Email',
      'enterEmail': 'Please enter your email',
      'enterValidEmail': 'Please enter a valid email',
      'password': 'Password',
      'enterPassword': 'Please enter your password',
      'signingIn': 'Signing in...',
      'signIn': 'Sign in',
      'notRegistered': 'Not registered? ',
      'signUp': 'Sign up',
      'letsStart': "Let's get started!",
      'signUpPart1': 'Sign ',
      'signUpPart2': 'up',
      'name': 'Name',
      'enterName': 'Please enter your name',
      'enterPass': 'Enter password',
      'enterAPassword': 'Please enter a password',
      'passwordLength': 'Password must be at least 6 characters',
      'confirmPassword': 'Confirm password',
      'enterConfirmPassword': 'Please confirm your password',
      'passwordMismatch': 'Passwords do not match',
      'signingUp': 'Signing up...',
      'alreadyRegistered': 'Already registered? ',
      'loginSuccessful': 'Login successful!',
      'registrationSuccessful': 'Registration successful! Please sign in.',
      'failedLoadUser': 'Failed to load user data',
      'trainings': 'Trainings',
      'profile': 'Profile',
      'welcomeUser': 'Welcome back, {name}!',
      'readyWorkout': 'Ready for your next workout?',
      'yourStats': 'Your Stats',
      'workouts': 'Workouts',
      'exercises': 'Exercises',
      'quickActions': 'Quick Actions',
      'startWorkout': 'Start Workout',
      'beginTraining': 'Begin a new training session',
      'viewHistory': 'View History',
      'checkPast': 'Check your past workouts',
      'recentWorkouts': 'Recent Workouts',
      'noRecent': 'No recent workouts',
      'muscleGroups': 'Muscle groups',
      'failedLoadMuscles': 'Failed to load muscle groups',
      'failedLoadExercises': 'Failed to load exercises',
      'failedLoadSessions': 'Failed to load workout sessions',
      'today': 'Today',
      'yesterday': 'Yesterday',
      'unknownDate': 'Unknown date',
      'noWorkoutsYet': 'No workouts yet. Start your first workout!',
      'unknownWorkout': 'Unknown Workout',
      'newWorkout': 'New workout',
      'enterTitle': 'Enter title',
      'addExercise': 'Add exercise',
      'save': 'Save',
      'profileTitle': 'Profile',
      'signedOut': 'Signed out successfully',
      'failedSignOut': 'Failed to sign out',
      'noEmail': 'No email',
      'noName': 'No name',
      'totalWorkouts': 'Total workouts\n',
      'aiInsight': 'AI assistant insight',
      'aiText': "You're making great progress! Upper body strength is improving steadily. Try adding one more leg session this week for better balance. Don't forget to increase weights slightly on your main lifts.",
      'logOut': 'Log out',
      'set': 'Set {number}',
      'weight': 'Weight: ',
      'reps': 'Reps: ',
      'addSet': 'Add set',
      'pleaseFillSets': 'Please fill all set values',
      'workoutSaved': 'Workout saved successfully!',
      'failedSaveWorkout': 'Failed to save workout',
      'authError': 'Auth Error',
      'user': 'User',
    },
    'ru': {
      'appTitle': 'Трекер фитнеса',
      'welcomeBack': 'С возвращением!',
      'signInPart1': 'Войдите ',
      'signInPart2': 'в систему',
      'email': 'Эл. почта',
      'enterEmail': 'Пожалуйста, введите эл. почту',
      'enterValidEmail': 'Пожалуйста, введите корректный эл. адрес',
      'password': 'Пароль',
      'enterPassword': 'Пожалуйста, введите пароль',
      'signingIn': 'Вход...',
      'signIn': 'Войти',
      'notRegistered': 'Нет аккаунта? ',
      'signUp': 'Регистрация',
      'letsStart': 'Давайте начнем!',
      'signUpPart1': 'Зарегистрируй',
      'signUpPart2': 'ся',
      'name': 'Имя',
      'enterName': 'Пожалуйста, введите имя',
      'enterPass': 'Введите пароль',
      'enterAPassword': 'Пожалуйста, введите пароль',
      'passwordLength': 'Пароль должен содержать не менее 6 символов',
      'confirmPassword': 'Подтвердите пароль',
      'enterConfirmPassword': 'Пожалуйста, подтвердите пароль',
      'passwordMismatch': 'Пароли не совпадают',
      'signingUp': 'Регистрация...',
      'alreadyRegistered': 'Уже есть аккаунт? ',
      'loginSuccessful': 'Вы успешно вошли!',
      'registrationSuccessful': 'Регистрация прошла успешно! Пожалуйста, войдите.',
      'failedLoadUser': 'Не удалось загрузить данные пользователя',
      'trainings': 'Тренировки',
      'profile': 'Профиль',
      'welcomeUser': 'С возвращением, {name}!',
      'readyWorkout': 'Готов к следующей тренировке?',
      'yourStats': 'Ваша статистика',
      'workouts': 'Тренировки',
      'exercises': 'Упражнения',
      'quickActions': 'Быстрые действия',
      'startWorkout': 'Начать тренировку',
      'beginTraining': 'Начать новую тренировку',
      'viewHistory': 'История тренировок',
      'checkPast': 'Посмотреть предыдущие тренировки',
      'recentWorkouts': 'Последние тренировки',
      'noRecent': 'Нет последних тренировок',
      'muscleGroups': 'Мышечные группы',
      'failedLoadMuscles': 'Не удалось загрузить группы мышц',
      'failedLoadExercises': 'Не удалось загрузить упражнения',
      'failedLoadSessions': 'Не удалось загрузить тренировки',
      'today': 'Сегодня',
      'yesterday': 'Вчера',
      'unknownDate': 'Неизвестная дата',
      'noWorkoutsYet': 'Тренировок пока нет. Начните первую тренировку!',
      'unknownWorkout': 'Неизвестная тренировка',
      'newWorkout': 'Новая тренировка',
      'enterTitle': 'Введите название',
      'addExercise': 'Добавить упражнение',
      'save': 'Сохранить',
      'profileTitle': 'Профиль',
      'signedOut': 'Вы вышли из системы',
      'failedSignOut': 'Не удалось выйти',
      'noEmail': 'Нет email',
      'noName': 'Нет имени',
      'totalWorkouts': 'Всего тренировок\n',
      'aiInsight': 'Совет ИИ',
      'aiText': 'Вы хорошо прогрессируете! Сила верхней части тела постепенно улучшается. Попробуйте добавить еще одну тренировку ног на этой неделе для лучшего баланса. Не забывайте понемногу увеличивать вес в основных упражнениях.',
      'logOut': 'Выйти',
      'set': 'Подход {number}',
      'weight': 'Вес: ',
      'reps': 'Повторения: ',
      'addSet': 'Добавить подход',
      'pleaseFillSets': 'Пожалуйста, заполните все значения',
      'workoutSaved': 'Тренировка успешно сохранена!',
      'failedSaveWorkout': 'Не удалось сохранить тренировку',
      'authError': 'Ошибка авторизации',
      'user': 'Пользователь',
    },
  };

  String translate(String key, {Map<String, String>? params}) {
    String value = _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']![key] ??
        key;
    if (params != null) {
      params.forEach((k, v) {
        value = value.replaceAll('{$k}', v);
      });
    }
    return value;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
