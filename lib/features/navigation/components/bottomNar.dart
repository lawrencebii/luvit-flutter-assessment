import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../notifications/notification_provider.dart';
import '../navigation_provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: 60,
      width: width,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 0.5, color: Color(0xffBDBDBD)),
          )),
      child: Consumer<NavigationProvider>(
        builder: (context, provider, child) {
          int selected = provider.selectedIndex;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomIconButton2(
                onTap: () {
                  context.read<NavigationProvider>().setSelectedIndex(0);
                },
                mainfocus: selected == 0,
                svglink: 'assets/icons/Home.svg',
                name: "home",
              ),
              CustomIconButton2(
                onTap: () {
                  context.read<NavigationProvider>().setSelectedIndex(1);
                },
                mainfocus: selected == 1,
                svglink: 'assets/icons/shop.svg',
                name: "shop",
              ),
              CustomIconButtonNotification(
                onTap: () {
                  context.read<NavigationProvider>().setSelectedIndex(2);
                },
                mainfocus: selected == 2,
                svglink: 'assets/icons/notifications.svg',
                name: "notifications",
              ),
              CustomIconButton2(
                onTap: () {
                  context.read<NavigationProvider>().setSelectedIndex(3);
                },
                mainfocus: selected == 3,
                svglink: 'assets/icons/user.svg',
                name: "profile",
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomIconButton2 extends StatelessWidget {
  CustomIconButton2({
    this.mainfocus = false,
    this.svglink,
    required this.onTap,
    this.backgroundcolor,
    this.iconcolor,
    this.name,
    Key? key,
  }) : super(key: key);
  String? name;
  final bool mainfocus;
  final String? svglink;
  final Function() onTap;
  final Color? backgroundcolor;
  final Color? iconcolor;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var primary = Theme.of(context).colorScheme.inversePrimary;
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.01),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        top: 4, left: 4, bottom: 2, right: 4),
                    child: SvgPicture.asset(
                      svglink!,
                      color:
                          mainfocus ? primary : ColorsConstants.bottomDisabled,
                      width: 24,
                      height: 24,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomIconButtonNotification extends StatelessWidget {
  CustomIconButtonNotification({
    this.mainfocus = false,
    this.svglink,
    required this.onTap,
    this.backgroundcolor,
    this.iconcolor,
    this.name,
    Key? key,
  }) : super(key: key);
  String? name;
  final bool mainfocus;
  final String? svglink;
  final Function() onTap;
  final Color? backgroundcolor;
  final Color? iconcolor;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var primary = Theme.of(context).colorScheme.inversePrimary;
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.01),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 4, left: 4, bottom: 2, right: 4),
                  child: Consumer2<NotificationProvider, NavigationProvider>(
                    builder: (context, provider, nav, child) {
                      // bool hasNotifications =
                      //     provider.readNotificationsMap !=
                      //             null &&
                      //         provider.readNotificationsMap
                      //             .isNotEmpty;
                      return Badge(
                        isLabelVisible: false,
                        smallSize: 11,
                        child: SvgPicture.asset(
                          svglink!,
                          color: mainfocus
                              ? primary
                              : ColorsConstants.bottomDisabled,
                          width: 24,
                          height: 24,
                        ),
                      );
                    },
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
