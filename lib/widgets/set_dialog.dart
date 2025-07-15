import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

void showSetDialog(BuildContext context, String exerciseName) {
  showDialog(
    context: context,
    builder: (context) => _SetDialog(exerciseName: exerciseName),
  );
}

class _SetDialog extends StatefulWidget {
  final String exerciseName;

  const _SetDialog({required this.exerciseName});

  @override
  State<_SetDialog> createState() => _SetDialogState();
}

class _SetDialogState extends State<_SetDialog> {
  final List<Map<String, String>> sets = [
    {'weight': '', 'reps': ''},
    {'weight': '', 'reps': ''},
  ];

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
    setState(() {
      sets.removeAt(index);
    });
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
                              Text('Set ${index + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                )
                              ),
                              const Spacer(),
                              GestureDetector(
                                child: Icon(
                                  Icons.close,
                                  color: Colors.grey.shade500,
                                  size: 20,
                                ),
                                onTap: () => _removeSet(index),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Weight: '),
                              SizedBox(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none
                                  ),
                                  onChanged: (value) =>
                                      _updateSet(index, 'weight', value),
                                ),
                                height: 24,
                                width: 48,
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Reps: '),
                              SizedBox(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none
                                  ),
                                  onChanged: (value) =>
                                      _updateSet(index, 'reps', value),
                                ),
                                width: 48,
                                height: 24,
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
                    child: const Text(
                      'Add set',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryBlue
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
                        onPressed: () {
                          Navigator.of(context).pop();
                          // TODO: save data
                        },
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
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
