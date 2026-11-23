import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/localization/app_localizations.dart';
import 'login_screen.dart';
import 'otp_verification_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _nameController = TextEditingController(text: 'Amit Sharma');
  final _phoneController = TextEditingController(text: '9876543210');
  final _emailController = TextEditingController(text: 'amit.sharma@email.com');
  final _passwordController = TextEditingController(text: 'RoadBandhu@2026');

  bool _hasMinLength = true;
  bool _hasUppercase = true;
  bool _hasNumber = true;

  void _validatePassword(String value) {
    setState(() {
      _hasMinLength = value.length >= 8;
      _hasUppercase = value.contains(RegExp(r'[A-Z]'));
      _hasNumber = value.contains(RegExp(r'[0-9]'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('create_account'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: context.tr('full_name'),
              hint: 'Amit Sharma',
              controller: _nameController,
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: context.tr('phone_number'),
              hint: '+91 98765 43210',
              controller: _phoneController,
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: context.tr('email_optional'),
              hint: 'amit.sharma@email.com',
              controller: _emailController,
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: context.tr('create_password'),
              hint: '••••••••',
              controller: _passwordController,
              prefixIcon: Icons.lock_outline,
              isPassword: true,
              onChanged: _validatePassword,
            ),
            const SizedBox(height: 12),
            _PasswordRuleItem(text: context.tr('pwd_rule_8'), isValid: _hasMinLength),
            const SizedBox(height: 4),
            _PasswordRuleItem(text: context.tr('pwd_rule_upper'), isValid: _hasUppercase),
            const SizedBox(height: 4),
            _PasswordRuleItem(text: context.tr('pwd_rule_num'), isValid: _hasNumber),
            const SizedBox(height: 24),
            CustomButton(
              text: context.tr('create_account'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OTPVerificationScreen(
                      phone: _phoneController.text,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                context.tr('or_continue_with'),
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SocialLoginButton(icon: Icons.g_mobiledata, label: 'Google', onTap: () {}),
                const SizedBox(width: 14),
                _SocialLoginButton(icon: Icons.apple, label: 'Apple', onTap: () {}),
                const SizedBox(width: 14),
                _SocialLoginButton(icon: Icons.facebook, label: 'Facebook', onTap: () {}),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  context.tr('already_have_account'),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordRuleItem extends StatelessWidget {
  final String text;
  final bool isValid;

  const _PasswordRuleItem({required this.text, required this.isValid});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 15,
          color: isValid ? AppColors.success : AppColors.mountainSlate,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isValid ? AppColors.success : AppColors.mountainSlate,
            fontWeight: isValid ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialLoginButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
        child: Icon(
          icon,
          size: 24,
          color: isDark ? Colors.white : AppColors.alpineNavy,
        ),
      ),
    );
  }
}
