import 'package:fitness_tracker_frontend/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,

      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Theme.of(context).iconTheme.color),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
