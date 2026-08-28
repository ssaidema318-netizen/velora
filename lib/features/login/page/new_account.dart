import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/view_model_services/cubit/auth_cubit.dart';
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
    final cubit = BlocProvider.of<AuthCubit>(context);
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
                        validator: "Phone is required",
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
                        child: BlocConsumer<AuthCubit, AuthState>(
                          bloc: cubit,
                          listenWhen: ((previous, current) =>
                              current is AuthDone || current is AuthError),
                          listener: (context, state) {
                            if (state is AuthDone) {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.customBottomRoute);
                            } else if (state is AuthError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            }
                          },
                          buildWhen: (previous, current) =>
                              current is AuthLoading ||
                              current is AuthDone ||
                              current is AuthError,
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return ElevatedButton(
                                onPressed: null,

                                child: CircularProgressIndicator.adaptive(),
                              );
                            }
                            return ElevatedButton(
                              onPressed: () async {
                                if (fromkey.currentState!.validate()) {
                                  await cubit.registerWithEmailandPassword(
                                    nameController.text.trim(),
                                    emailController.text.trim(),
                                    passwordController.text,
                                    phoneController.text.trim(),

                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.surface,
                              ),
                              child: Text("Creat Account"),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.grey),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                            ),
                            child: Text(
                              'or create with',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Row(
                        children: [
                          Expanded(
                            child: BlocConsumer<AuthCubit, AuthState>(
                              bloc: cubit,
                              listenWhen: (previous, current) => current is GoogleDone || current is GoogleError,
                              listener: (context, state) {
                                if (state is GoogleDone) {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.customBottomRoute);
                            } else if (state is GoogleError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            }
                              },
                              buildWhen: (previous, current) => current is GoogleLoading,
                              builder: (context, state) {
                                if(state is GoogleLoading){
                                  return Chip(
                                    backgroundColor: AppColors.background,
                                    labelPadding: EdgeInsets.all(AppSpacing.xs),
                                    label: CircularProgressIndicator.adaptive()
                                  );
                                }
                                return InkWell(
                                  onTap: () {cubit.signInwithGoogle();},
                                  child: Chip(
                                    backgroundColor: AppColors.background,
                                    labelPadding: EdgeInsets.all(AppSpacing.xs),
                                    label: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              "https://cdn.brandfetch.io/id6O2oGzv-/w/800/h/817/theme/dark/symbol.png?c=1dxbfHSJFAPEGdCLU4o5B",
                                          height: 30,
                                          width: 30,
                                        ),
                                        const SizedBox(width: AppSpacing.m),
                                        Text(
                                          "Google",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: AppSpacing.l),
                          Expanded(
                            child: BlocConsumer<AuthCubit, AuthState>(
                              bloc: cubit,
                              listenWhen: (previous, current) =>
                                  current is FacebookAuthDone || current is FacebookAuthError,
                              listener: (context, state) {
                                if (state is FacebookAuthDone) {
                                  Navigator.of(
                                    context,
                                  ).pushNamed(AppRoutes.customBottomRoute);
                                } else if (state is FacebookAuthError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)),
                                  );
                                }
                              },
                              buildWhen: (previous, current) => current is FacebookAuthLoading,
                              builder: (context, state) {
                                if (state is FacebookAuthLoading) {
                                  return Chip(
                                    backgroundColor: AppColors.background,
                                    labelPadding: EdgeInsets.all(AppSpacing.xs),
                                    label: CircularProgressIndicator.adaptive(),
                                  );
                                }
                                return InkWell(
                                  onTap: () {
                                    cubit.signInwithFacebook();
                                  },
                                  child: Chip(
                                    backgroundColor: AppColors.background,
                                    labelPadding: EdgeInsets.all(AppSpacing.xs),
                                    label: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              "https://cdn.brandfetch.io/idpKX136kp/w/400/h/400/theme/dark/icon.jpeg?c=1dxbfHSJFAPEGdCLU4o5B",
                                          height: 30,
                                          width: 30,
                                        ),
                                        const SizedBox(width: AppSpacing.m),
                                        Text(
                                          "Facebook",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
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
