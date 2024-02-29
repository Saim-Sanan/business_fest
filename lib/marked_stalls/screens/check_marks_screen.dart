import 'package:bfest/models/judge_marked_stall_model.dart';
import 'package:bfest/models/team_marked_stall_model.dart';
import 'package:bfest/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckMarksScreen extends StatefulWidget {
  const CheckMarksScreen({super.key});

  @override
  State<CheckMarksScreen> createState() => _CheckMarksScreenState();
}

class _CheckMarksScreenState extends State<CheckMarksScreen> {
  @override
  Widget build(BuildContext context) {
    final dynamic args = Get.arguments;
    final User user = args['user'];
    late JudgeMarkedStall judgeStall;
    late TeamMarkedStall teameStall;
    if (user.bfestRole == '1') {
      judgeStall = args['stall'];
    } else {
      teameStall = args['stall'];
    }

    return Scaffold(
      appBar: AppBar(
        title: user.bfestRole == '1'
            ? Text(
                judgeStall.stallName,
                style: TextStyle(
                  fontSize: Get.height * 0.03,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            : Text(
                teameStall.stallName,
                style: TextStyle(
                  fontSize: Get.height * 0.03,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (user.bfestRole == '1') ...[
                Image.network(
                  "https://businessfest.imdigisol.com/${judgeStall.photo}",
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Center(
                  child: Text(
                    'Stall Marks',
                    style: TextStyle(
                      fontSize: Get.height * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                Marks(
                  title: 'Product',
                  marks: judgeStall.productMarks,
                ),
                Marks(
                  title: 'Innovation',
                  marks: judgeStall.innovationMarks,
                ),
                Marks(
                  title: 'SDGs Relation',
                  marks: judgeStall.sdgRelationMarks,
                ),
                Marks(
                  title: 'Revenue Stream',
                  marks: judgeStall.revenueStreamMarks,
                ),
                Marks(
                  title: 'Future Potential of Idea',
                  marks: judgeStall.futurePotentialMarks,
                ),
                Marks(
                  title: 'Team Presentation',
                  marks: judgeStall.teamPresentationMarks,
                ),
                Marks(
                  title: 'Market Research',
                  marks: judgeStall.marketResearchMarks,
                ),
                Marks(
                  title: 'Decor of Stall',
                  marks: judgeStall.decorofStallMarks,
                ),
              ],
              if (user.bfestRole == '2') ...[
                Image.network(
                  "https://businessfest.imdigisol.com/${teameStall.photo}",
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Center(
                  child: Text(
                    'Stall Marks',
                    style: TextStyle(
                      fontSize: Get.height * 0.025,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                Marks(
                  title: 'Marketing (Social Media + on Campus)',
                  marks: teameStall.bfestMarketingMarks,
                ),
                Marks(
                  title: 'Decor of Stall',
                  marks: teameStall.bfestDecorOfStallMarks,
                ),
                Marks(
                  title: 'Record Management/Legal Documentation/Sponsorship',
                  marks: teameStall.bfestTeamConductMarks,
                ),
                Marks(
                  title: 'Team Conduct',
                  marks: teameStall.bfestTeamConductMarks,
                ),
                Marks(
                  title: 'Sales',
                  marks: teameStall.bfestSponsorshipMarks,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class Marks extends StatelessWidget {
  final String title;
  final String marks;
  const Marks({
    super.key,
    required this.title,
    required this.marks,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: TextStyle(
              fontSize: Get.height * 0.012,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            marks,
            style: TextStyle(
              fontSize: Get.height * 0.02,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
