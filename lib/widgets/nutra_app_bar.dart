import 'package:flutter/material.dart';

class NutraAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onAction;
  final IconData actionIcon;

  const NutraAppBar({
    super.key,
    this.onAction,
    this.actionIcon = Icons.help_outline_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        iconSize: 30.0,
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: Icon(actionIcon),
          iconSize: 30.0,
          onPressed: onAction,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
