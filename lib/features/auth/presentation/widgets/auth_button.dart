import 'package:flutter/material.dart';
import 'package:go_captin/core/widgets/custom_button.dart';

import '../../../../core/utils/app_colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    this.isEnabled = false,
    this.isLoading = false,
    this.onPressed,
  });

  final bool isEnabled;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: isLoading ? 'جارٍ التحقق...' : 'كمّل',
      isLoading: isLoading,
      onPressed: isEnabled && !isLoading ? onPressed : null,
      colors: isEnabled && !isLoading
          ? [AppColors.mainBlue, AppColors.mainBlue.withValues(alpha: 0.50)]
          : [
              AppColors.greyCheckBox,
              AppColors.greyCheckBox.withValues(alpha: 0.65),
            ],
    );
  }
}
