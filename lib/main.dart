import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velora/constants/app_router.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/features/cart/cubit/cart_cubit.dart';
import 'package:velora/features/cart/payment_page/cubit/payment_cubit.dart';
import 'package:velora/features/cart/payment_page/page/new_payment_card/page/cubit/add_new_card_cubit.dart';
import 'package:velora/features/favorite/cubit/favorite_cubit.dart';
import 'package:velora/firebase_options.dart';
import 'package:velora/services/auth_services.dart';
import 'package:velora/services/home_services.dart';
import 'package:velora/theme/app_theme.dart';
import 'package:velora/view_model_services/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // The "web" (client_type 3) OAuth client from google-services.json.
  // With google_sign_in v7+, Android throws
  // GoogleSignInException(clientConfigurationError,
  // "serverClientId must be provided on Android") unless this is
  // passed explicitly — the plugin no longer infers it automatically
  // from google-services.json the way older versions did.
  await GoogleSignIn.instance.initialize(
    serverClientId:
        '378440085296-qlnjvmiatk592q59t4o2avnvcfp95v5n.apps.googleusercontent.com',
  );
  
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartCubit()..watchCart()),
        BlocProvider(create: (_) => AddNewCardCubit()..watchPaymentMethods()),
        BlocProvider(create: (_)=>PaymentCubit()..watchPaymentData()),
        BlocProvider(
          create: (_) {
            final cubit = AuthCubit();
            cubit.checkAuth();
            return cubit;
          },
        ),
        BlocProvider(
          create: (_) => FavoriteCubit(
            homeServices: HomeServicesImpl(),
            authServices: AuthServicesImpl(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          current is AuthDone || current is AuthInitial,
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          // Keep the whole app flexible under the user's OS text-size
          // setting: scale with it, but clamp so an extreme setting
          // (e.g. "largest" accessibility text) can't blow up layouts
          // that assume roughly phone-sized text.
          builder: (context, child) {
            final mediaQuery = MediaQuery.of(context);
            final clampedScaler = mediaQuery.textScaler.clamp(
              minScaleFactor: 0.85,
              maxScaleFactor: 1.3,
            );
            return MediaQuery(
              data: mediaQuery.copyWith(textScaler: clampedScaler),
              child: child!,
            );
          },
          initialRoute: state is AuthDone
              ? AppRoutes.customBottomRoute
              : AppRoutes.logInRoute,
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
