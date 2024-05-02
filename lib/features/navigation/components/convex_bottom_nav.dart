import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prime_template/features/navigation/components/bottomNar.dart';
import 'package:prime_template/features/navigation/navigation_provider.dart';
import 'package:prime_template/utils/constants.dart';
import 'package:provider/provider.dart';

ConvexAppBar convexBottomNav(context) {
  return ConvexAppBar(
    backgroundColor: blackColor,
    shadowColor: Colors.white.withOpacity(0.5),
    color: bottomGreyColor,
    activeColor: primaryColor,
    elevation: 4,
    style: TabStyle.fixed,
    items: const [
      TabItem(icon: Icons.home, title: 'Home'),
      TabItem(icon: Icons.location_on_outlined, title: 'Discover'),
      TabItem(
        icon: Icons.star,
      ),
      TabItem(icon: Icons.chat, title: 'Chat'),
      TabItem(icon: Icons.people, title: 'Profile'),
    ],
    onTap: (int i) {
      Provider.of<NavigationProvider>(context, listen: false)
          .setSelectedIndex(i);
    },
  );
}
