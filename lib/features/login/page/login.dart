import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/view_model_services/cubit/auth_cubit.dart';
import 'package:velora/widgets/app_text_form_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final fromkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.md),
                Image.asset("assets/images/logo.png", height: 90, width: 80),
                const SizedBox(height: AppSpacing.md),
                Text(
                  "Welcome back",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  "Log in to cotinue shopping with Velora",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: AppColors.textHint),
                ),
                const SizedBox(height: AppSpacing.md),
                Form(
                  key: fromkey,
                  child: Column(
                    children: [
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
                        controller: passwordController,
                        label: "Password",
                        hintText: "Enter your password",
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        validator: "Password is required",
                        prefixIcon: Icons.password,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forget Password",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: AppColors.primary),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: BlocConsumer<AuthCubit, AuthState>(
                          bloc: cubit,
                          listenWhen: (previous, current) =>
                              current is AuthDone || current is AuthError,
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
                              onPressed: () {
                                if (fromkey.currentState!.validate()) {
                                  cubit.logInWithEmailAndPassword(
                                    emailController.text,
                                    passwordController.text,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.surface,
                              ),
                              child: Text("Log In"),
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
                              'or continue with',
                              style: TextStyle(color: Colors.grey, fontSize: 14),
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
                                    label:CircularProgressIndicator.adaptive());
                                }
                                return InkWell(
                                  onTap: () {
                                    cubit.signInwithGoogle();
                                  },
                                  child: Chip(
                                    backgroundColor: AppColors.background,
                                    labelPadding: EdgeInsets.all(AppSpacing.xs),
                                    label: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                              .copyWith(fontWeight: FontWeight.w500),
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
                      const SizedBox(height: AppSpacing.l),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.createAccountRoute);
                            },
                            child: Text(
                              "Create one",
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
