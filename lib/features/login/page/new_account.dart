import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/widgets/app_text_form_field.dart';

class NewAccount extends StatefulWidget {
  const NewAccount({super.key});

  @override
  State<NewAccount> createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  final fromkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.background),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(AppSpacing.md),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSpacing.l),
                Text(
                  "Create your account",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  "Join Velora for a faster, personalized checkout.",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textHint,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                Form(
                  key: fromkey,
                  child: Column(
                    children: [
                      AppTextFormField(
                        controller: nameController,
                        label: "Full Name",
                        hintText: "Enter your full name",
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        validator: "Full name is required",
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextFormField(
                        controller: emailController,
                        label: "Email",
                        hintText: "you@example.com",
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        validator: "Enter a valid email address",
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextFormField(
                        controller: phoneController,
                        label: "Phone Number",
                        hintText: "10 1234 5678",
                        textInputAction: TextInputAction.next,
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        obscureText: false,
                        validator: "Password is required",
                        prefixText: "+20",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextFormField(
                        controller: passwordController,
                        label: "Password",
                        hintText: "Enter your password",
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        validator: "Creat a password",
                        prefixIcon: Icons.password,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            if (fromkey.currentState!.validate()) {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.customBottomRoute);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.surface,
                          ),
                          child: Text("Creat Account"),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Log in",
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
