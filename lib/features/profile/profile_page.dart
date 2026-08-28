import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/view_model_services/cubit/auth_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: BlocConsumer<AuthCubit, AuthState>(
            bloc: cubit,
            listenWhen: (previous, current) =>
                current is AuthLogError || current is AuthLogedout,
            listener: (context, state) {
              if (state is AuthLogedout) {
                Navigator.of(context,rootNavigator: true).pushNamedAndRemoveUntil(
                  AppRoutes.logInRoute,
                  ((route) => false),
                );
              } else if(state is AuthLogError){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message))
                );
              }
            },
            buildWhen: (previous, current) => current is AuthLogingout,
            builder: (context, state) {
              if(state is AuthLogingout){
                return ElevatedButton(
                onPressed: null,
                child: CircularProgressIndicator.adaptive(),
              );
              }
              return ElevatedButton(
                onPressed: () async{
                  await cubit.logOut();
                },
                child: Text("Sign Out"),
              );
            },
          ),
        ),
      ),
    );
  }
}
