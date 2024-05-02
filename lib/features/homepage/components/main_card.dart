import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../home_provider.dart';

class MainCard extends StatefulWidget {
  final mango;
  const MainCard({super.key, this.mango});

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Container(
        height: size.height * 0.70,
        width: size.width * 0.8,
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: greyStarColor),
          image: DecorationImage(
              image: AssetImage(widget.mango['image'].toString()),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(20),
            //   child: Image.asset(
            //     'assets/images/ryan-moreno.jpg',
            //     fit: BoxFit.cover,
            //     height: size.height * 0.70,
            //     width: size.width * 0.8,
            //   ),
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height * 0.25,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                          Colors.black
                        ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.mango['name']}',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: blackColor,
                      ),
                      child: IntrinsicWidth(
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: bottomGreyColor,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              '${widget.mango['likes']}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Builder(builder: (context) {
                          if (provider.currentIndex == 0) {
                            return profile1Content(context);
                          }
                          if (provider.currentIndex == 1) {
                            return profile2Content(context);
                          }

                          return profile3Content(context);
                        }),
                        Expanded(
                            child: SizedBox(
                          width: 20,
                        )),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: extBlueColor)),
                          child: Icon(Icons.favorite, color: extBlueColor),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SvgPicture.asset(
                        'assets/icons/caret_down.svg',
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ...List.generate(5, (index) {
                            return Container(
                              height: 5,
                              width: 45,
                              decoration: BoxDecoration(
                                color: provider.currentIndex == index
                                    ? primaryColor
                                    : blackColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          })
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: size.width * 0.26,
                height: size.height * 0.26,
                child: GestureDetector(
                  onTap: () {
                    context.read<HomeProvider>().tapLeft();
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: size.width * 0.26,
                height: size.height * 0.26,
                child: GestureDetector(onTap: () {
                  context.read<HomeProvider>().tapRight();
                }),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget profile1Content(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Age : ${widget.mango['age']}',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
        ),
        Text(
          '${widget.mango['location']} . ${widget.mango['distance']} Away',
          style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 12,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget profile2Content(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Age : ${widget.mango['age']}',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.6,
          child: Text(
            "${widget.mango['description']}",
            style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 13,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  Widget profile3Content(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Age : ${widget.mango['age']}',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Wrap(
            children: [
              ...widget.mango['hobbies'].map((e) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: blackColor,
                  ),
                  child: IntrinsicWidth(
                    child: Row(
                      children: [
                        Text(
                          e,
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ],
    );
  }
}
