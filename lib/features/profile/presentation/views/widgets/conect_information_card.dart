import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/features/profile/domain/entities/userprofile_entity.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../../../../../l10n/app_localizations.dart';

class ContactInformationCard extends StatefulWidget {
  final UserProfile profile;
  final int animationDelay;

  const ContactInformationCard({
    super.key,
    required this.profile,
    this.animationDelay = 0,
  });

  @override
  State<ContactInformationCard> createState() => _ContactInformationCardState();
}

class _ContactInformationCardState extends State<ContactInformationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slide =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
        );

    Future.delayed(Duration(milliseconds: widget.animationDelay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppThemeConsts.padding16md,
          ),
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
            boxShadow: [
              BoxShadow(
                color:
                    isDarkMode ? AppColors.shadowDark : AppColors.shadowLight,
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Section header ──
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppThemeConsts.padding16md,
                  AppThemeConsts.padding16md,
                  AppThemeConsts.padding16md,
                  0,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppColors.primaryDark.withAlpha(60)
                            : AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(
                          AppThemeConsts.radius8sm,
                        ),
                      ),
                      child: const Icon(
                        Iconsax.profile_circle_copy,
                        color: AppColors.primary,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      locale.contactInformation,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ── Divider ──
              Divider(
                height: 1,
                thickness: 1,
                color: isDarkMode
                    ? AppColors.borderDark
                    : AppColors.borderLight,
                indent: AppThemeConsts.padding16md,
                endIndent: AppThemeConsts.padding16md,
              ),
              const SizedBox(height: 8),

              // ── Email row ──
              _AnimatedContactRow(
                icon: Iconsax.sms_copy,
                label: locale.email,
                value: widget.profile.email,
                delay: widget.animationDelay + 100,
                onCopy: () => _copyToClipboard(context, widget.profile.email),
              ),

              Divider(
                height: 1,
                thickness: 1,
                color: isDarkMode
                    ? AppColors.borderDark.withAlpha(80)
                    : AppColors.borderLight,
                indent: 60,
                endIndent: AppThemeConsts.padding16md,
              ),

              // ── Phone row ──
              _AnimatedContactRow(
                icon: Iconsax.call_copy,
                label: locale.phone,
                value: widget.profile.phone,
                delay: widget.animationDelay + 200,
                onCopy: () => _copyToClipboard(context, widget.profile.phone),
              ),

              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Copied to clipboard'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeConsts.radius8sm),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class _AnimatedContactRow extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final int delay;
  final VoidCallback onCopy;

  const _AnimatedContactRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.delay,
    required this.onCopy,
  });

  @override
  State<_AnimatedContactRow> createState() => _AnimatedContactRowState();
}

class _AnimatedContactRowState extends State<_AnimatedContactRow>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
    _slide = Tween<Offset>(
      begin: const Offset(-0.2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: InkWell(
          onTap: widget.onCopy,
          borderRadius: BorderRadius.circular(AppThemeConsts.radius8sm),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppThemeConsts.padding16md,
              vertical: 14,
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppColors.primaryDark.withAlpha(50)
                        : AppColors.lightGreen,
                    borderRadius: BorderRadius.circular(
                      AppThemeConsts.radius8sm,
                    ),
                  ),
                  child: Icon(widget.icon, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDarkMode
                              ? AppColors.textSecondaryDark
                              : AppColors.mediumGray,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.value,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.copy_rounded,
                  size: 16,
                  color: isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.mediumGray,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}