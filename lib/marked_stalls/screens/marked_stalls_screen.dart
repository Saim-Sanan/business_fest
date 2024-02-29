import 'package:bfest/auth/controllers/login_controller.dart';
import 'package:bfest/marked_stalls/screens/check_marks_screen.dart';
import 'package:bfest/models/judge_marked_stall_model.dart';
import 'package:bfest/models/team_marked_stall_model.dart';
import 'package:bfest/models/user_model.dart';
import 'package:bfest/widgets/animated_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarkedStallsScreen extends StatefulWidget {
  const MarkedStallsScreen({super.key});

  @override
  State<MarkedStallsScreen> createState() => _MarkedStallsScreenState();
}

class _MarkedStallsScreenState extends State<MarkedStallsScreen> {
  @override
  Widget build(BuildContext context) {
    final dynamic args = Get.arguments;
    final User user = args['user'];
    final LoginController loginController = Get.put(LoginController());
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
          "Marked Stalls",
          style: TextStyle(
            fontSize: Get.height * 0.03,
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
            icon: const Icon(Icons.cancel),
            onPressed: () {
              Get.back();
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
      body: Obx(() {
        return loginController.isLoading.value
            ? const AnimatedLoader()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (user.bfestRole == '1') ...[
                        SizedBox(height: Get.height * 0.01),
                        const JudgeMarkedStallsListView(),
                      ],
                      if (user.bfestRole == '2') ...[
                        SizedBox(height: Get.height * 0.01),
                        const TeamMarkedStallsListView(),
                      ],
                    ],
                  ),
                ),
              );
      }),
    );
  }
}

class JudgeMarkedStallsListView extends StatelessWidget {
  const JudgeMarkedStallsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();
    final User user = loginController.currentUser.value;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: loginController.judgeMarkedStalls.length,
      itemBuilder: (context, index) {
        JudgeMarkedStall judgeStall = loginController.judgeMarkedStalls[index];

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            tileColor: Colors.grey.withOpacity(0.1),
            title: Text(judgeStall.stallName),
            subtitle: Text('lead: ${judgeStall.members}'),
            leading: Image.network(
              "https://businessfest.imdigisol.com/${judgeStall.photo}",
              height: Get.height * 0.15,
              fit: BoxFit.fill,
            ),
            onTap: () {
              Get.to(() => const CheckMarksScreen(), arguments: {
                'stall': judgeStall,
                'user': user,
              });
            },
          ),
        );
      },
    );
  }
}

class TeamMarkedStallsListView extends StatelessWidget {
  const TeamMarkedStallsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();
    final User user = loginController.currentUser.value;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: loginController.teamMarkedStalls.length,
      itemBuilder: (context, index) {
        TeamMarkedStall teamStall = loginController.teamMarkedStalls[index];

        return ListTile(
          title: Text(teamStall.stallName),
          subtitle: Text('lead: ${teamStall.members}'),
          leading: Image.network(
            "https://businessfest.imdigisol.com/${teamStall.photo}",
            height: Get.height * 0.15,
            fit: BoxFit.fill,
          ),
          onTap: () {
            Get.to(() => const CheckMarksScreen(), arguments: {
              'stall': teamStall,
              'user': user,
            });
          },
        );
      },
    );
  }
}
