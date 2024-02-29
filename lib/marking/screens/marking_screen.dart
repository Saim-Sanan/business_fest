import 'package:bfest/auth/controllers/login_controller.dart';
import 'package:bfest/marking/controllers/marking_controller.dart';
import 'package:bfest/models/stall_model.dart';
import 'package:bfest/models/user_model.dart';
import 'package:bfest/widgets/animated_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarkingScreen extends StatefulWidget {
  const MarkingScreen({Key? key}) : super(key: key);

  @override
  State<MarkingScreen> createState() => _MarkingScreenState();
}

class _MarkingScreenState extends State<MarkingScreen> {
  final TextEditingController productController = TextEditingController();
  final TextEditingController innovationController = TextEditingController();
  final TextEditingController sdgRelationController = TextEditingController();
  final TextEditingController revenueStreamController = TextEditingController();
  final TextEditingController futurePotentialController =
      TextEditingController();
  final TextEditingController teamPresentationController =
      TextEditingController();
  final TextEditingController marketResearchController =
      TextEditingController();
  final TextEditingController decorOfStallController = TextEditingController();
  final TextEditingController marketingController = TextEditingController();
  final TextEditingController recordManagementController =
      TextEditingController();
  final TextEditingController teamConductController = TextEditingController();
  final TextEditingController sponsorshipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dynamic args = Get.arguments;
    final Stall stall = args['stall'];
    final User user = args['user'];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Get.height * 0.13,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: Get.width * 0.2,
        leading: Container(
          margin: const EdgeInsets.only(top: 10, left: 5),
          // padding:
          child: ClipOval(
            child: Image.network(
              "https://businessfest.imdigisol.com/${stall.photo}",
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Text(
          stall.stallName,
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
              stall.members,
              style: TextStyle(
                color: Colors.white,
                fontSize: Get.height * 0.015,
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        final MarkingController markingController =
            Get.put(MarkingController());
        return markingController.isLoading.value
            ? const AnimatedLoader()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (user.bfestRole == '1') ...[
                        Center(
                          child: Text(
                            'Judge Evaluation',
                            style: TextStyle(
                              fontSize: Get.height * 0.025,
                              color: Colors.purple,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        _buildCriterionField('Product', productController, 10),
                        _buildCriterionField(
                            'Innovation', innovationController, 10),
                        _buildCriterionField(
                            'SDGs Relation', sdgRelationController, 10),
                        _buildCriterionField(
                            'Revenue Stream', revenueStreamController, 5),
                        _buildCriterionField('Future Potential of Idea',
                            futurePotentialController, 10),
                        _buildCriterionField('Team Presentation',
                            teamPresentationController, 10),
                        _buildCriterionField(
                            'Market Research', marketResearchController, 5),
                        _buildCriterionField(
                            'Decor of Stall', decorOfStallController, 5),
                      ],
                      if (user.bfestRole == '2') ...[
                        Center(
                          child: Text(
                            'Team Evaluation',
                            style: TextStyle(
                              fontSize: Get.height * 0.025,
                              color: Colors.purple,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        _buildCriterionField(
                            'Marketing', marketingController, 10),
                        _buildCriterionField(
                            'Decor of Stall', decorOfStallController, 5),
                        _buildCriterionField(
                            'Record Management', recordManagementController, 5),
                        _buildCriterionField(
                            'Team Conduct', teamConductController, 5),
                        _buildCriterionField(
                            'Sales', sponsorshipController, 10),
                      ],
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.withOpacity(0.8),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          minimumSize: Size(Get.width, 50),
                        ),
                        onPressed: (user.bfestRole == '1' &&
                                    Get.find<LoginController>()
                                        .judgeMarkedStalls
                                        .any((judgeStall) =>
                                            judgeStall.stallId ==
                                            stall.stallId)) ||
                                (user.bfestRole == '2' &&
                                    Get.find<LoginController>()
                                        .teamMarkedStalls
                                        .any((teamStall) =>
                                            teamStall.stallId == stall.stallId))
                            ? null
                            : () {
                                _submitMarks(user.bfestRole, stall, user);
                              },
                        child: Text(
                          (user.bfestRole == '1' &&
                                      Get.find<LoginController>()
                                          .judgeMarkedStalls
                                          .any((judgeStall) =>
                                              judgeStall.stallId ==
                                              stall.stallId)) ||
                                  (user.bfestRole == '2' &&
                                      Get.find<LoginController>()
                                          .teamMarkedStalls
                                          .any((teamStall) =>
                                              teamStall.stallId ==
                                              stall.stallId))
                              ? 'Submitted'
                              : 'Submit Marks',
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  Widget _buildCriterionField(
      String criterion, TextEditingController controller, int limit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$criterion:',
          style: TextStyle(
            fontSize: Get.height * 0.02,
          ),
        ),
        NumberInputField(
          limit: limit,
          onValueChanged: (selectedNumber) {
            controller.text = selectedNumber.toString();
          },
        ),
        // Expanded(
        //   child: TextField(
        //     controller: controller,
        //     keyboardType: TextInputType.number,
        //     decoration: const InputDecoration(
        //       hintText: 'Enter marks (Max: 10)',
        //     ),
        //     inputFormatters: <TextInputFormatter>[
        //       FilteringTextInputFormatter.digitsOnly
        //     ],
        //     onChanged: (value) {
        //       if (value.isNotEmpty) {
        //         int marks = int.parse(value);
        //         if (marks > 10) {
        //           controller.text = '10';
        //         }
        //       }
        //     },
        //   ),
        // ),
      ],
    );
  }

  void _submitMarks(String userRole, Stall stall, User user) {
    if (userRole == '1') {
      if (!_validateJudgeMarks()) {
        Get.snackbar(
          'Validation Error',
          'please enter marks for all.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
    } else if (userRole == '2') {
      if (!_validateTeamMarks()) {
        Get.snackbar(
          'Validation Error',
          'Please enter marks for all.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
    }

    // Confirmation Dialog
    Get.defaultDialog(
      title: 'Confirmation',
      middleText: 'Are you sure you want to submit these marks?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirm: ElevatedButton(
        onPressed: () async {
          Get.back();
          await _handleSubmission(userRole, stall, user);
        },
        child: const Text('Yes'),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('No'),
      ),
    );
  }

  bool _validateJudgeMarks() {
    List<TextEditingController> controllers = [
      productController,
      innovationController,
      sdgRelationController,
      revenueStreamController,
      futurePotentialController,
      teamPresentationController,
      marketResearchController,
      decorOfStallController,
    ];

    for (var controller in controllers) {
      int marks = int.tryParse(controller.text) ?? -1;
      if (marks < 0 || marks > 10) {
        return false;
      }
    }

    return true;
  }

  bool _validateTeamMarks() {
    List<TextEditingController> controllers = [
      marketingController,
      decorOfStallController,
      recordManagementController,
      teamConductController,
      sponsorshipController,
    ];

    for (var controller in controllers) {
      int marks = int.tryParse(controller.text) ?? -1;
      if (marks < 0 || marks > 10) {
        return false;
      }
    }

    return true;
  }

  Future<void> _handleSubmission(
      String userRole, Stall stall, User user) async {
    final MarkingController markingController = Get.put(MarkingController());

    try {
      markingController.isLoading(true);
      if (userRole == '1') {
        final status = await markingController.submitJudgingMarks(
          stallID: stall.stallId,
          productMarks: productController.text,
          innovationMarks: innovationController.text,
          sdgRelationMarks: sdgRelationController.text,
          revenueStreamMarks: revenueStreamController.text,
          futurePotentialMarks: futurePotentialController.text,
          teamPresentationMarks: teamPresentationController.text,
          marketResearchMarks: marketResearchController.text,
          decorOfStallMarks: decorOfStallController.text,
          judgeID: '${user.id}',
        );

        if (status == true) {
          markingController.updateMarkedStalls(
              userID: '${user.id}', bfestRole: userRole);
          markingController.update();

          Get.snackbar(
            'submitted Successful',
            'data inserted successfully',
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Submission Failed',
            'failed to submit',
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else if (userRole == '2') {
        final status = await markingController.submitTeamEvaluationMarks(
          stallID: stall.stallId,
          marketingMarks: marketingController.text,
          decorOfStallMarks: decorOfStallController.text,
          recordManagementMarks: recordManagementController.text,
          teamConductMarks: teamConductController.text,
          sponsorshipMarks: sponsorshipController.text,
          bfestUserID: '${user.id}',
        );

        if (status == true) {
          markingController.updateMarkedStalls(
              userID: '${user.id}', bfestRole: userRole);
          markingController.update();

          Get.snackbar(
            'submitted Successful',
            'data inserted successfully',
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Submission Failed',
            'failed to submit',
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      throw e;
    } finally {
      markingController.isLoading(false);
    }
  }
}

class NumberInputField extends StatefulWidget {
  final int limit;
  final Function(int) onValueChanged;

  const NumberInputField(
      {super.key, required this.limit, required this.onValueChanged});

  @override
  State<NumberInputField> createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  int selectedNumber = 0;

  @override
  Widget build(BuildContext context) {
    List<int> numberList = List.generate(widget.limit + 1, (index) => index);

    return Container(
      // decoration: BoxDecoration(color: Colors.purple),
      padding: const EdgeInsets.all(13.0),
      child: DropdownButton<int>(
        value: selectedNumber,
        onChanged: (int? newValue) {
          setState(() {
            selectedNumber = newValue!;
            widget.onValueChanged(selectedNumber);
          });
        },
        items: numberList.map((int number) {
          return DropdownMenuItem<int>(
            value: number,
            child: Text('$number'),
          );
        }).toList(),
      ),
    );
  }
}
