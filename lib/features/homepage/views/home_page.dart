// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prime_template/features/homepage/components/main_card.dart';
import 'package:prime_template/features/homepage/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../../utils/constants.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  late ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(() {
      if (_scrollController.offset > 40) {
        context.read<HomeProvider>().resetIndex();
      }
    });

    super.initState();
  }

  MatchEngine matchEngine = MatchEngine();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: blackColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 20,
                      width: 20,
                      child: Stack(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: greyStarColor,
                          ),
                          Positioned(
                            top: 6,
                            left: 10,
                            child: Container(
                              height: 5,
                              width: 5,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            ),
                          )
                        ],
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Jane Doe",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  const Expanded(
                      child: SizedBox(
                    width: 10,
                  )),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: greyStarColor,
                    ),
                    child: const IntrinsicWidth(
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: primaryColor,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '323,233',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset('assets/icons/notifications.svg'),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<HomeProvider>(
              builder: (context, provider, child) {
                if (provider.mangos == null || provider.mangos.isEmpty) {
                  return Container(
                    height: size.height * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "No more feed come back later",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<HomeProvider>().setMangos();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Refresh",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...provider.mangos.map((mango) {
                        return Draggable(
                          // height: size.height * 0.90,
                          // width: size.width * 0.95,
                          feedback: MainCard(
                            mango: mango,
                          ),
                          onDragEnd: (details) {
                            if (details.offset.dy > 200 ||
                                details.offset.dx > 150) {
                              context.read<HomeProvider>().removeMango(mango);
                            }
                          },
                          child: MainCard(
                            mango: mango,
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
