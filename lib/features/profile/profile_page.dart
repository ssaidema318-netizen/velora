import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/features/profile/cubit/profile_cubit.dart';
import 'package:velora/models/user_data.dart';
import 'package:velora/view_model_services/cubit/auth_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.loading ||
              state.status == ProfileStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == ProfileStatus.error) {
            return Center(
              child: Text(state.errorMessage ?? 'Something went wrong'),
            );
          }

          final userData = state.userData!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _GradientHeader(userData: userData),
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: const _StatsCard(),
                ),
                if (state.isProfileIncomplete)
                  const Padding(
                    padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                    child: _TipCard(),
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _SectionLabel('ACCOUNT'),
                      _ColorRow(
                        icon: Icons.inventory_2_outlined,
                        label: 'My Orders',
                        bg: const Color(0xFFE9EEFF),
                        fg: const Color(0xFF0055FF),
                        onTap: () {
                          context.read<PersistentTabController>().jumpToTab(2);
                        },
                      ),
                      _ColorRow(
                        icon: Icons.location_on_outlined,
                        label: 'Delivery Addresses',
                        bg: const Color(0xFFFFE9F1),
                        fg: const Color(0xFFFF6B9D),
                        onTap: () {
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pushNamed(AppRoutes.paymentPageRoute);
                        },
                      ),
                      _ColorRow(
                        icon: Icons.credit_card_outlined,
                        label: 'Payment Methods',
                        bg: const Color(0xFFE6FBF7),
                        fg: const Color(0xFF00C2A8),
                        onTap: () {
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pushNamed(AppRoutes.paymentPageRoute);
                        },
                      ),
                      const SizedBox(height: 16),
                      const _SectionLabel('PREFERENCES'),
                      const _ToggleRow(
                        icon: Icons.notifications_outlined,
                        label: 'Notifications',
                        bg: Color(0xFFFFF4E0),
                        fg: Color(0xFFFF9F43),
                      ),
                      const _ToggleRow(
                        icon: Icons.dark_mode_outlined,
                        label: 'Dark Mode',
                        bg: Color(0xFFEFE9FF),
                        fg: Color(0xFF8E6CFF),
                        initialValue: false,
                      ),
                      _ColorRow(
                        icon: Icons.help_outline,
                        label: 'Help & Support',
                        bg: const Color(0xFFFFE9E9),
                        fg: const Color(0xFFFF6B6B),
                        onTap: () {},
                      ),
                      _ColorRow(
                        icon: Icons.logout,
                        label: 'Log Out',
                        bg: const Color(0xFFFFE8E8),
                        fg: const Color(0xFFE5484D),
                        labelColor: const Color(0xFFE5484D),
                        showChevron: false,
                        onTap: () async {
                          await context.read<AuthCubit>().logOut();
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pushNamed(AppRoutes.logInRoute);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _GradientHeader extends StatefulWidget {
  final UserData userData;
  const _GradientHeader({required this.userData});

  @override
  State<_GradientHeader> createState() => _GradientHeaderState();
}

class _GradientHeaderState extends State<_GradientHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initials = widget.userData.name.isNotEmpty
        ? widget.userData.name
              .trim()
              .split(' ')
              .map((w) => w[0])
              .take(2)
              .join()
              .toUpperCase()
        : '?';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 50, 18, 46),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0055FF), Color(0xFF5B7CFF), Color(0xFF8E6CFF)],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Good evening, ${widget.userData.name.split(' ').first}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: (_controller.value - 0.5) * 0.4,
                        child: child,
                      );
                    },
                    child: const Text('👋', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(
                        alpha: 0.35 * (1 - _controller.value),
                      ),
                      blurRadius: 12 * _controller.value,
                      spreadRadius: 6 * _controller.value,
                    ),
                  ],
                ),
                child: child,
              );
            },
            child: GestureDetector(
              onTap: () async {
                final picker = ImagePicker();
                final pickedFile = await picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 40,
                  maxWidth: 300,
                );

                if (pickedFile != null && context.mounted) {
                  context.read<ProfileCubit>().updateProfilePicture(
                    File(pickedFile.path),
                  );
                }
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: widget.userData.photoUrl != null
                          ? Image.network(
                              widget.userData.photoUrl!,
                              fit: BoxFit.cover,
                              width: 86,
                              height: 86,
                              errorBuilder: (_, _, _) =>
                                  _InitialsAvatar(userData: widget.userData),
                            )
                          : _InitialsAvatar(userData: widget.userData),
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0055FF),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.userData.name.isNotEmpty
                ? widget.userData.name
                : 'Your name',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            widget.userData.email,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Row(
        children: [
          Expanded(
            child: _StatItem(
              value: '18',
              label: 'Orders',
              color: Color(0xFF0055FF),
            ),
          ),
          _Divider(),
          Expanded(
            child: _StatItem(
              value: '12',
              label: 'Favorites',
              color: Color(0xFFFF6B9D),
            ),
          ),
          _Divider(),
          Expanded(
            child: _StatItem(
              value: '2.4k',
              label: 'Points',
              color: Color(0xFF00C2A8),
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) =>
      Container(width: 0.5, height: 30, color: Colors.black12);
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const _StatItem({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.black54),
        ),
      ],
    );
  }
}

class _TipCard extends StatefulWidget {
  const _TipCard();

  @override
  State<_TipCard> createState() => _TipCardState();
}

class _TipCardState extends State<_TipCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF4E0), Color(0xFFFFE9D6)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('💬', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Complete your profile",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7A4A00),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Add your phone number so we can reach you about your orders.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9A6B1F),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9F43),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Complete-profile form is coming soon 🙂',
                          ),
                        ),
                      );
                      // TODO: Navigator.push to the edit-profile form once it exists
                    },
                    child: const Text(
                      'Complete',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.black38,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _ColorRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;
  final Color? labelColor;
  final bool showChevron;

  const _ColorRow({
    required this.icon,
    required this.label,
    required this.bg,
    required this.fg,
    required this.onTap,
    this.labelColor,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(11),
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 18, color: fg),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: labelColor ?? Colors.black87,
                ),
              ),
            ),
            if (showChevron)
              const Icon(Icons.chevron_right, size: 16, color: Colors.black26),
          ],
        ),
      ),
    );
  }
}

class _ToggleRow extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color bg;
  final Color fg;
  final bool initialValue;

  const _ToggleRow({
    required this.icon,
    required this.label,
    required this.bg,
    required this.fg,
    this.initialValue = true,
  });

  @override
  State<_ToggleRow> createState() => _ToggleRowState();
}

class _ToggleRowState extends State<_ToggleRow> {
  late bool value = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: widget.bg,
              borderRadius: BorderRadius.circular(11),
            ),
            alignment: Alignment.center,
            child: Icon(widget.icon, size: 18, color: widget.fg),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Switch(
            value: value,
            activeTrackColor: const Color(0xFF0055FF),
            onChanged: (v) => setState(() => value = v),
          ),
        ],
      ),
    );
  }
}

class _InitialsAvatar extends StatelessWidget {
  final UserData userData;
  const _InitialsAvatar({required this.userData});

  @override
  Widget build(BuildContext context) {
    final initials = userData.name.isNotEmpty
        ? userData.name
              .trim()
              .split(' ')
              .map((w) => w[0])
              .take(2)
              .join()
              .toUpperCase()
        : '?';
    return Center(
      child: Text(
        initials,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0055FF),
        ),
      ),
    );
  }
}
