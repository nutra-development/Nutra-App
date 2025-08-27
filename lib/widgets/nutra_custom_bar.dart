import 'package:flutter/material.dart';

class NutraCustomBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leadingIcon;
  final Widget actionIcon;

  const NutraCustomBar({
    super.key,
    required this.leadingIcon,
    required this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: leadingIcon,
      actions: [actionIcon],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
