import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:velora/features/cart/cart_page.dart';
import 'package:velora/features/favorite/cubit/favorite_cubit.dart';
import 'package:velora/features/favorite/favorite_page.dart';
import 'package:velora/features/home/cubit/cubit/home_cubit.dart';
import 'package:velora/features/home/home_page.dart';
import 'package:velora/features/profile/cubit/profile_cubit.dart';
import 'package:velora/features/profile/profile_page.dart';
import 'package:velora/features/search/search_page.dart';
import 'package:velora/services/auth_services.dart';
import 'package:velora/services/firestore_services.dart';
import 'package:velora/services/profile_services.dart';

class CustomBageNavbar extends StatefulWidget {
  const CustomBageNavbar({super.key});

  @override
  State<CustomBageNavbar> createState() => _CustomBageNavbarState();
}

class _CustomBageNavbarState extends State<CustomBageNavbar> {
  // 🔥 1. عرفنا الـ Cubit كمتغير هنا عشان نثبته في الذاكرة وميتمسحش مع الـ Rebuild
  late final HomeCubit _homeCubit;
  late final PersistentTabController _navController;
  late final ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().loadFavorites();
     _profileCubit = ProfileCubit(               // 🔥 جديد
      profileServices: ProfileServicesImpl(
        firestoreServices: FirestoreServices.instance,
      ),
      authServices: AuthServicesImpl(),
    )..loadProfile();

    // 🔥 2. عملنا له Create وطلبنا الداتا مرة واحدة بس عند أول فتح للـ Navbar
    _homeCubit = HomeCubit()..getHomeData();

    // 🔥 3. الكنترولر بتاع التابات — ده اللي هنستخدمه للتنقل من صفحات تانية
    _navController = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    // 🔥 4. قفلنا الـ Cubit والكنترولر بشكل آمن لو اليوزر خرج من التطبيق أو الـ Navbar
    _homeCubit.close();
    _navController.dispose();
    _profileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 5. ListenableProvider مش RepositoryProvider، لأن PersistentTabController
    // بيتغيّر (ChangeNotifier) والـ RepositoryProvider مصمم للحاجات الثابتة بس
    return ListenableProvider<PersistentTabController>.value(
      value: _navController,
      child:  MultiBlocProvider(                    // 🔥 بدّلنا هنا
      providers: [
        BlocProvider.value(value: _homeCubit),
        BlocProvider.value(value: _profileCubit), // 🔥 وضفنا السطر ده
      ],
        child: PersistentTabView(
          controller: _navController,
          tabs: [
            PersistentTabConfig(
              screen: const HomePage(),
              item: ItemConfig(
                icon: const Icon(Icons.home_outlined),
                title: "Home",
                activeForegroundColor: Colors.blue,
                inactiveForegroundColor: Colors.black54,
              ),
            ),
            PersistentTabConfig(
              screen: const SearchPage(),
              item: ItemConfig(
                icon: const Icon(Icons.search_rounded),
                title: "Search",
                activeForegroundColor: Colors.blue,
                inactiveForegroundColor: Colors.black54,
              ),
            ),
            PersistentTabConfig(
              screen: const CartPage(),
              item: ItemConfig(
                icon: const Icon(Icons.shopping_cart_outlined),
                title: "Cart",
                activeForegroundColor: Colors.blue,
                inactiveForegroundColor: Colors.black54,
              ),
            ),
            PersistentTabConfig(
              screen: const FavoritePage(),
              item: ItemConfig(
                icon: const Icon(Icons.favorite_border_rounded),
                title: "Favorites",
                activeForegroundColor: Colors.blue,
                inactiveForegroundColor: Colors.black54,
              ),
            ),
            PersistentTabConfig(
              screen: const ProfilePage(),
              item: ItemConfig(
                icon: const Icon(Icons.person_outline_rounded),
                title: "Profile",
                activeForegroundColor: Colors.blue,
                inactiveForegroundColor: Colors.black54,
              ),
            ),
          ],
          navBarBuilder: (navBarConfig) =>
              Style16BottomNavBar(navBarConfig: navBarConfig),
        ),
      ),
    );
  }
}