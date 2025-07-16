import 'package:fitness_tracker_frontend/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../services/workout_service.dart';
import '../models/workout_models.dart';
import '../utils/toast_utils.dart';
import '../l10n/app_localizations.dart';


void showSetDialog(BuildContext context, String exerciseName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return _SetDialog(exerciseName: exerciseName);
    },
  );
}

class _SetDialog extends StatefulWidget {
  final String exerciseName;

  const _SetDialog({required this.exerciseName});

  @override
  State<_SetDialog> createState() => _SetDialogState();
}

class _SetDialogState extends State<_SetDialog> {
  final List<Map<String, dynamic>> sets = [
    {'weight': '', 'reps': ''},
    {'weight': '', 'reps': ''},
  ];
  bool _isLoading = false;

  void _addSet() {
    if (sets.length < 6) {
      setState(() {
        sets.add({'weight': '', 'reps': ''});
      });
    }
  }

  void _updateSet(int index, String key, String value) {
    setState(() {
      sets[index][key] = value;
    });
  }

  void _removeSet(int index) {
    if (sets.length > 1) {
      setState(() {
        sets.removeAt(index);
      });
    }
  }

  Future<void> _saveWorkout() async {
    // Проверяем, что все поля заполнены
    for (int i = 0; i < sets.length; i++) {
      if (sets[i]['weight']!.trim().isEmpty ||
          sets[i]['reps']!.trim().isEmpty) {
        ToastUtils.showError(
            AppLocalizations.of(context).translate('pleaseFillSets'));
        return;
      }
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Создаем сессию тренировки
      final session = await WorkoutService.createWorkoutSession(
        workoutTypeId: 1, // Временное значение
      );

      if (session != null) {
        // Добавляем детали для каждого подхода
        for (int i = 0; i < sets.length; i++) {
          await WorkoutService.addWorkoutDetail(
            sessionId: session.id,
            detailName: '${widget.exerciseName} Set ${i + 1}',
            detailValue: '${sets[i]['weight']}kg x ${sets[i]['reps']}',
          );
        }

        if (mounted) {
          Navigator.of(context).pop();
          ToastUtils.showSuccess(
              AppLocalizations.of(context).translate('workoutSaved'));
        }
      }
    } catch (e) {
      if (mounted) {
        ToastUtils.showError(
            AppLocalizations.of(context).translate('failedSaveWorkout'));
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
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    widget.exerciseName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.primaryBlue),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(sets.length, (index) {
                  return SizedBox(
                    key: ValueKey(index),
                    width: MediaQuery.of(context).size.width / 2 - 64,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .translate('set', params: {
                                  'number': (index + 1).toString()
                                }),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  _removeSet(index);
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.grey.shade500,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               Text(
                                AppLocalizations.of(context).translate('weight'),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: TextEditingController(
                                      text: sets[index]['weight']),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                  ),
                                  onChanged: (value) =>
                                      _updateSet(index, 'weight', value),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context).translate('reps'),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: TextEditingController(
                                      text: sets[index]['reps']),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                  ),
                                  onChanged: (value) =>
                                      _updateSet(index, 'reps', value),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _addSet,
                    child: Text(
                        AppLocalizations.of(context).translate('addSet'),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryBlue,
                        ),
                    ),
                  ),
                  const SizedBox(width: 48),
                  SizedBox(
                    height: 44,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _saveWorkout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Text(
                                AppLocalizations.of(context).translate('save'),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
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
}
