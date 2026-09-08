import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/constants/app_spacing.dart';

Future<void> showOrderSuccessSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isDismissible: false, // 🔥 المستخدم لازم يضغط OK، مش يقفلها بالسحب أو باللمس بره
    enableDrag: false,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (sheetContext) => const _OrderSuccessContent(),
  );
}

class _OrderSuccessContent extends StatefulWidget {
  const _OrderSuccessContent();

  @override
  State<_OrderSuccessContent> createState() => _OrderSuccessContentState();
}

class _OrderSuccessContentState extends State<_OrderSuccessContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.l,
        right: AppSpacing.l,
        top: AppSpacing.xl,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: _scaleAnim,
            child: Container(
              width: 76,
              height: 76,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded, color: Colors.white, size: 40),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Order placed!',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            "We're getting it ready. You'll see updates in My Orders.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                // 🔥 نقفل الـ bottom sheet الأول
                Navigator.of(context).pop();
                // 🔥 ولو صفحة الـ Place Order كانت متعمولها push (زي صفحة Payment)
                // نرجع لحد ما نوصل لصفحة الـ nav bar الرئيسية
                Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.customBottomRoute);
                    
                // 🔥 وبعدين نودي تاب الـ Home
                // context.read<PersistentTabController>().jumpToTab(0);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text('OK', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}