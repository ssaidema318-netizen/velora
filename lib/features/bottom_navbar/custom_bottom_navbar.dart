import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:velora/features/cart/cart_page.dart';
import 'package:velora/features/favorite/favorite_page.dart';
import 'package:velora/features/home/home_page.dart';
import 'package:velora/features/profile/profile_page.dart';
import 'package:velora/features/search/search_page.dart';

class CustomBageNavbar extends StatefulWidget {
  const CustomBageNavbar({super.key});

  @override
  State<CustomBageNavbar> createState() => _CustomBageNavbarState();
}

class _CustomBageNavbarState extends State<CustomBageNavbar> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
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
    );
  }
}
