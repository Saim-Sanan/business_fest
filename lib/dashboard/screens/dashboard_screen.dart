import 'package:badges/badges.dart';
import 'package:bfest/marked_stalls/screens/marked_stalls_screen.dart';
import 'package:bfest/models/user_model.dart';
import 'package:bfest/widgets/counting_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bfest/auth/controllers/login_controller.dart';
import 'package:bfest/marking/screens/marking_screen.dart';
import 'package:bfest/models/stall_model.dart';
import 'package:bfest/widgets/search_widget.dart';
import 'package:badges/badges.dart' as badges;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final dynamic args = Get.arguments;
    final User user = args['user'];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Get.height * 0.13,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: Get.width * 0.25,
        leading: Image.asset(
          "assets/images/bfest.png",
          fit: BoxFit.contain,
        ),
        title: Text(
          'Business Fest 2024',
          style: TextStyle(
            fontSize: Get.height * 0.022,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pink.withOpacity(0.9),
                Colors.purple.withOpacity(0.9),
                Colors.blue.withOpacity(0.9),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.find<LoginController>().logOut();
            },
          )
        ],
        bottom: PreferredSize(
          preferredSize: Get.size * 0.01,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              user.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: Get.height * 0.015,
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () {
          if (Get.find<LoginController>().allStalls.isEmpty) {
            return const Center(
              child: Text('No stalls available'),
            );
          } else {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                height: Get.height,
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      // decoration: BoxDecoration(color: Colors.purple),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CountingContainer(
                            title: 'Total Stalls',
                            subtitle:
                                '${Get.find<LoginController>().allStalls.length}',
                            onTap: () {},
                          ),
                          CountingContainer(
                            title: 'Marked',
                            subtitle: user.bfestRole == "1"
                                ? '${Get.find<LoginController>().judgeMarkedStalls.length}'
                                : '${Get.find<LoginController>().teamMarkedStalls.length}',
                            onTap: () {
                              Get.to(() => const MarkedStallsScreen(),
                                  arguments: {
                                    'user': user,
                                    'stallList': user.bfestRole == '1'
                                        ? Get.find<LoginController>()
                                            .judgeMarkedStalls
                                        : Get.find<LoginController>()
                                            .teamMarkedStalls,
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    buildSearch(),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Container(
                          height: Get.height * 0.05,
                          width: Get.width * 0.02,
                          decoration: const BoxDecoration(
                            color: Colors.purple,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Text(
                          "Stalls",
                          style: TextStyle(
                            fontSize: Get.height * 0.03,
                            color: Colors.purple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.2,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                const Text("UnMarked"),
                              ],
                            ),
                            SizedBox(
                              width: Get.width * 0.1,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                const Text("Marked"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    SizedBox(
                      height: Get.height * 0.5,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: filteredStalls.length,
                            itemBuilder: (context, index) {
                              var stall = filteredStalls[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => const MarkingScreen(),
                                      arguments: {
                                        'stall': stall,
                                        'user': user,
                                      });
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    // decoration: BoxDecoration(
                                    // color: stall.markingStatus == "Pending"
                                    //     ? Colors.red
                                    //     : Colors.green,
                                    // gradient: LinearGradient(
                                    //   colors: [
                                    //     Colors.pink.withOpacity(0.1),
                                    //     Colors.purple.withOpacity(0.1),
                                    //     Colors.blue.withOpacity(0.1),
                                    //   ],
                                    //   begin: Alignment.bottomLeft,
                                    //   end: Alignment.topRight,
                                    // ),
                                    // ),
                                    child: badges.Badge(
                                      badgeStyle: BadgeStyle(
                                        badgeColor: (user.bfestRole == '1' &&
                                                    Get.find<LoginController>()
                                                        .judgeMarkedStalls
                                                        .any((judgeStall) =>
                                                            judgeStall
                                                                .stallId ==
                                                            stall.stallId)) ||
                                                (user.bfestRole == '2' &&
                                                    Get.find<LoginController>()
                                                        .teamMarkedStalls
                                                        .any((teamStall) =>
                                                            teamStall.stallId ==
                                                            stall.stallId))
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      showBadge:
                                          // (Get.find<LoginController>()
                                          //                     .currentUser
                                          //                     .value
                                          //                     .bfestRole ==
                                          //                 '1' &&
                                          //             stall.judgeMarking ==
                                          //                 '0') ||
                                          //         (Get.find<LoginController>()
                                          //                     .currentUser
                                          //                     .value
                                          //                     .bfestRole ==
                                          //                 '2' &&
                                          //             stall.teamMarking == "0")
                                          //     ? true
                                          //     :
                                          true,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Container(
                                              height: Get.height * 0.08,
                                              child: Image.network(
                                                "https://businessfest.imdigisol.com/${stall.photo}",
                                                height: Get.height * 0.15,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            stall.stallName,
                                            style: TextStyle(
                                              color: Colors.purple,
                                              fontSize: Get.height * 0.016,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'stall name',
        onChanged: searchStall,
      );

  void searchStall(String query) {
    setState(() {
      this.query = query;
    });
  }

  List<Stall> get filteredStalls {
    // Filter stalls based on the search query
    return Get.find<LoginController>().allStalls.where((stall) {
      return stall.stallName.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
