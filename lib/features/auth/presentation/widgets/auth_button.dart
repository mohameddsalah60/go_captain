import 'package:flutter/material.dart';
import 'package:go_captin/core/widgets/custom_button.dart';

import '../../../../core/utils/app_colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, this.isEnabled = false, this.onPressed});

  final bool isEnabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'كمّل',
      onPressed: isEnabled ? onPressed : null,
      colors: isEnabled
          ? [AppColors.mainBlue, AppColors.mainBlue.withValues(alpha: 0.50)]
          : [
              AppColors.greyCheckBox,
              AppColors.greyCheckBox.withValues(alpha: 0.65),
            ],
    );
  }
}
