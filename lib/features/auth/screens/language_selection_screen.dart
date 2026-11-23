import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/rescue_logo.dart';
import '../../../core/widgets/mountain_scenery_header.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/localization/app_localizations.dart';
import 'create_account_screen.dart';

class LanguageSelectionScreen extends ConsumerStatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  ConsumerState<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends ConsumerState<LanguageSelectionScreen> {
  String _selectedLang = 'en';

  @override
  void initState() {
    super.initState();
    _selectedLang = ref.read(languageProvider).languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            MountainSceneryHeader(
              height: 220,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RescueLogo(
                        size: 34,
                        showText: true,
                        isDark: true,
                        textColor: Colors.white,
                      ),
                      const Spacer(),
                      const Text(
                        'Choose Your Language',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'अपनी भाषा चुनें',
                        style: TextStyle(
                          color: Color(0xFFFCA5A5),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  children: [
                    _LanguageCard(
                      title: 'हिंदी (Hindi)',
                      subtitle: 'सड़क एवं पर्वतीय बचाव सहायता',
                      code: 'hi',
                      isSelected: _selectedLang == 'hi',
                      flagEmojiOrIcon: Icons.language,
                      onTap: () {
                        setState(() => _selectedLang = 'hi');
                        ref.read(languageProvider.notifier).setLanguage('hi');
                      },
                    ),
                    const SizedBox(height: 16),
                    _LanguageCard(
                      title: 'English (Default)',
                      subtitle: 'Road & Mountain Rescue Partner',
                      code: 'en',
                      isSelected: _selectedLang == 'en',
                      flagEmojiOrIcon: Icons.public,
                      onTap: () {
                        setState(() => _selectedLang = 'en');
                        ref.read(languageProvider.notifier).setLanguage('en');
                      },
                    ),
                    const Spacer(),
                    CustomButton(
                      text: '${context.tr('continue')} →',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CreateAccountScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String code;
  final bool isSelected;
  final IconData flagEmojiOrIcon;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.title,
    required this.subtitle,
    required this.code,
    required this.isSelected,
    required this.flagEmojiOrIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.primary.withAlpha(25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryLight : (isDark ? AppColors.darkSurface : AppColors.lightBackground),
                shape: BoxShape.circle,
              ),
              child: Icon(
                flagEmojiOrIcon,
                color: isSelected ? AppColors.primary : AppColors.mountainSlate,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                  width: 2,
                ),
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
