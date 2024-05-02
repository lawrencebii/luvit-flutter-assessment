import 'package:flutter/material.dart';
import 'package:prime_template/features/favorites/views/favorites.dart';
import 'package:prime_template/features/homepage/views/home_page.dart';
import 'package:prime_template/features/others/profile_page.dart';
import 'package:prime_template/main.dart';
import 'package:prime_template/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../homepage/home_provider.dart';
import '../components/bottomNar.dart';
import '../components/convex_bottom_nav.dart';
import '../navigation_provider.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeProvider>().setMangos();
      context.read<NavigationProvider>().getInitialRoute();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Stack(
        children: [
          SafeArea(
            child: Scaffold(
              body: Consumer<NavigationProvider>(
                builder: (context, provider, child) {
                  return IndexedStack(
                    index: provider.selectedIndex,
                    children: [
                      const HomepageScreen(),
                      ProfilePage(
                        name: "Discover Page",
                      ),
                      ProfilePage(
                        name: "Favorites Page",
                      ),
                      ProfilePage(
                        name: "Chat Page",
                      ),
                      ProfilePage(
                        name: "Profile Page",
                      ),
                    ],
                  );
                },
              ),
              bottomNavigationBar: convexBottomNav(context),
              // bottomNavigationBar: const BottomNavBar(),
            ),
          ),
          // const AppProgressIndicator(),
        ],
      ),
    );
  }
}
