import 'package:fitness_tracker_frontend/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../services/workout_service.dart';
import '../models/workout_models.dart';
import '../utils/toast_utils.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';

class TrainingsPage extends StatefulWidget {
  const TrainingsPage({super.key});

  @override
  State<TrainingsPage> createState() => _TrainingsPageState();
}

class _TrainingsPageState extends State<TrainingsPage> {
  List<WorkoutSession> _workoutSessions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWorkoutSessions();
  }

  Future<void> _loadWorkoutSessions() async {
    try {
      final sessions = await WorkoutService.getWorkoutSessions();
      if (mounted) {
        setState(() {
          _workoutSessions = sessions;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ToastUtils.showError(
            AppLocalizations.of(context).translate('failedLoadSessions'));
      }
    }
  }

  String _formatDate(String dateTime) {
    try {
      final date = DateTime.parse(dateTime);
      final now = DateTime.now();
      final difference = now.difference(date).inDays;

      if (difference == 0) {
        return AppLocalizations.of(context).translate('today');
      } else if (difference == 1) {
        return AppLocalizations.of(context).translate('yesterday');
      } else if (difference < 7) {
        return '${date.day}/${date.month}';
      } else {
        return '${date.day}/${date.month}/${date.year}';
      }
    } catch (e) {
      return AppLocalizations.of(context).translate('unknownDate');
    }
  }

  List<Widget> _buildExerciseRows(WorkoutSession session) {
    final List<Widget> rows = [];

    if (session.details != null && session.details!.isNotEmpty) {
      // Группируем детали по упражнениям
      final Map<String, List<WorkoutDetail>> exerciseGroups = {};

      for (final detail in session.details!) {
        final exerciseName = detail.detailName.split(' Set ')[0];
        if (!exerciseGroups.containsKey(exerciseName)) {
          exerciseGroups[exerciseName] = [];
        }
        exerciseGroups[exerciseName]!.add(detail);
      }

      // Создаем строки для каждого упражнения
      exerciseGroups.forEach((exerciseName, details) {
        rows.add(_ExerciseRow(exerciseName, 'x${details.length}'));

        // Добавляем детали подходов
        for (final detail in details) {
          final setNumber = detail.detailName.split(' Set ')[1];
          rows.add(_SetRow('Set $setNumber: ${detail.detailValue}'));
        }
      });
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.grey,
        actions: [
          IconButton(
            icon: const Icon(Icons.language, color: AppColors.black),
            onPressed: () {
              final currentLocale = Localizations.localeOf(context);
              final newLocale = currentLocale.languageCode == 'en'
                  ? const Locale('ru')
                  : const Locale('en');
              MyApp.of(context).setLocale(newLocale);
            },
          ),
        ],
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('trainings'),
          style: const TextStyle(
            color: AppColors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _loadWorkoutSessions,
                child: _workoutSessions.isEmpty
                    ?  Center(
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('noWorkoutsYet'),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        itemCount: _workoutSessions.length,
                        itemBuilder: (context, index) {
                          final session = _workoutSessions[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _TrainingCard(
                              title: session.workoutType?.name ??
                                  AppLocalizations.of(context)
                                      .translate('unknownWorkout'),
                              date: _formatDate(session.datetime),
                              exercises: _buildExerciseRows(session),
                            ),
                          );
                        },
                      ),
              ),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.primaryGradient,
        ),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: AppColors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (context) => DraggableScrollableSheet(
                initialChildSize: 0.7,
                minChildSize: 0.4,
                maxChildSize: 0.95,
                expand: false,
                builder: (context, scrollController) => SingleChildScrollView(
                  controller: scrollController,
                  child: const _AddTrainingModal(),
                ),
              ),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, color: AppColors.white, size: 32),
        ),
      ),
    );
  }
}

class _TrainingCard extends StatelessWidget {
  final String title;
  final String date;
  final List<Widget> exercises;

  const _TrainingCard({
    required this.title,
    required this.date,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ...exercises,
          ],
        ),
      ),
    );
  }
}

class _ExerciseRow extends StatelessWidget {
  final String name;
  final String count;
  final Color? color;

  const _ExerciseRow(this.name, this.count, [this.color]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(name, style: const TextStyle(color: Colors.black54)),
          const SizedBox(width: 6),
          Text(
            count,
            style: TextStyle(
              color: color ?? Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SetRow extends StatelessWidget {
  final String text;
  final Color? color;

  const _SetRow(this.text, {this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, top: 1, bottom: 1),
      child: Text(
        text,
        style: TextStyle(color: color ?? Colors.grey[800], fontSize: 13),
      ),
    );
  }
}

class _AddTrainingModal extends StatelessWidget {
  const _AddTrainingModal({super.key});

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                     Center(
                      child: Text(
                        AppLocalizations.of(context).translate('newWorkout'),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: null,
                      decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context).translate('enterTitle'),
                        filled: true,
                        fillColor: AppColors.grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/exercises_group'),
                      child: Text(
                        AppLocalizations.of(context).translate('addExercise'),
                        style:
                            const TextStyle(color: Color(0xFF3981E0), fontSize: 16),
                      ),
                  ),
                  SizedBox(
                    height: 44,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                            AppLocalizations.of(context).translate('save'),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
