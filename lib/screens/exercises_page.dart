import 'package:fitness_tracker_frontend/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../screens/exercises.dart';
import '../services/workout_service.dart';
import '../models/workout_models.dart';
import '../utils/toast_utils.dart';
import '../l10n/app_localizations.dart';


class ExercisesGroupPage extends StatefulWidget {
  const ExercisesGroupPage({super.key});

  @override
  State<ExercisesGroupPage> createState() => _ExercisesGroupPageState();
}

class _ExercisesGroupPageState extends State<ExercisesGroupPage> {
  List<MuscleGroup> _muscleGroups = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMuscleGroups();
  }

  Future<void> _loadMuscleGroups() async {
    try {
      final muscleGroups = await WorkoutService.getMuscleGroups();
      if (mounted) {
        setState(() {
          _muscleGroups = muscleGroups;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ToastUtils.showError(
            AppLocalizations.of(context).translate('failedLoadMuscles'));
      }
    }
  }

  String _getAssetForMuscleGroup(String name) {
    switch (name.toLowerCase()) {
      case 'chest':
        return 'assets/images/chest.png';
      case 'abs':
        return 'assets/images/abs.png';
      case 'back':
        return 'assets/images/back.png';
      case 'arms':
        return 'assets/images/arms.png';
      case 'legs':
        return 'assets/images/legs.png';
      case 'shoulders':
        return 'assets/images/shoulders.png';
      default:
        return 'assets/images/chest.png'; // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
     appBar: CustomAppBar(
          title: AppLocalizations.of(context).translate('exercises'),
          showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context).translate('muscleGroups'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: _loadMuscleGroups,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 1.1,
                            ),
                        itemCount: _muscleGroups.length,
                        itemBuilder: (context, index) {
                          final muscleGroup = _muscleGroups[index];
                          return _MuscleGroupCard(
                            title: muscleGroup.name,
                            asset: _getAssetForMuscleGroup(muscleGroup.name),
                            muscleGroupId: muscleGroup.id,
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MuscleGroupCard extends StatelessWidget {
  final String title;
  final String asset;
  final int muscleGroupId;

  const _MuscleGroupCard({
    required this.title,
    required this.asset,
    required this.muscleGroupId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ExercisesPage(title: title, muscleGroupId: muscleGroupId),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(asset, width: 80, height: 80),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
