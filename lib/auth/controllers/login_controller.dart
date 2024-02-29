import 'package:bfest/models/judge_marked_stall_model.dart';
import 'package:bfest/models/stall_model.dart';
import 'package:bfest/models/team_marked_stall_model.dart';
import 'package:bfest/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Stall> allStalls = <Stall>[].obs;
  // RxList<Stall> fullyMarkedStalls = <Stall>[].obs;
  // RxList<Stall> userMarkedStalls = <Stall>[].obs;
  // RxList<Stall> unMarkedStalls = <Stall>[].obs;
  // RxList<Stall> unMarkedJudgeStalls = <Stall>[].obs;
  // RxList<Stall> unMarkedTeamStalls = <Stall>[].obs;
  RxList<JudgeMarkedStall> judgeMarkedStalls = <JudgeMarkedStall>[].obs;
  RxList<TeamMarkedStall> teamMarkedStalls = <TeamMarkedStall>[].obs;
  // RxList<Stall> markedTeamStalls = <Stall>[].obs;

  Rx<User> currentUser = User(
    id: 0,
    name: '',
    email: '',
    emailVerifiedAt: null,
    image: null,
    branchId: null,
    usertype: null,
    bfestRole: '0',
    createdAt: null,
    updatedAt: null,
  ).obs;

  Future<void> login(String userName, String password) async {
    try {
      var userResponse = await http.post(
        Uri.parse(
          'https://businessfest.imdigisol.com/api/login?email=$userName&password=$password&device_name=phone',
        ),
      );
      if (userResponse.statusCode == 200) {
        final responseData = json.decode(userResponse.body);

        if (responseData != null) {
          final user = User.fromJson(responseData);

          currentUser.value = user;

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userName', userName);
          prefs.setString('password', password);

          getMarkedStalls(
              '${currentUser.value.id}', currentUser.value.bfestRole);

          var stallResponse = await http.get(
            Uri.parse(
              'https://businessfest.imdigisol.com/api/getstalls',
            ),
          );

          if (stallResponse.statusCode == 200) {
            final responseData = json.decode(stallResponse.body);

            if (responseData is List) {
              // If response is a list of stall objects
              List<Stall> data =
                  responseData.map((stall) => Stall.fromJson(stall)).toList();
              allStalls.assignAll(data);
              // unMarkedStalls.assignAll(
              //     data.where((stall) => stall.markingStatus == "Pending"));
              // unMarkedJudgeStalls
              //     .assignAll(data.where((stall) => stall.judgeMarking == "0"));
              // unMarkedTeamStalls
              //     .assignAll(data.where((stall) => stall.teamMarking == "0"));
              // markedJudgeStalls
              //     .assignAll(data.where((stall) => stall.judgeMarking == "1"));
              // markedTeamStalls
              //     .assignAll(data.where((stall) => stall.teamMarking == "1"));
              // fullyMarkedStalls.assignAll(data.where((stall) =>
              //     stall.judgeMarking == "1" && stall.teamMarking == "1"));
            } else if (responseData is Map<String, dynamic>) {
              // If response is a single stall object
              Stall singleStall = Stall.fromJson(responseData);
              allStalls.assignAll([singleStall]);
            } else {
              // Invalid data format
              throw ('Invalid data format');
            }
          } else {
            throw ("Failed to load data");
          }
        }
      } else {
        throw ('Failed to log In');
      }
    } catch (error) {
      // If an exception occurs during login, throw it to the caller
      throw error;
    }
  }

  Future<void> getMarkedStalls(String userID, String bFestRole) async {
    try {
      var markedStallResponse = await http.get(
        Uri.parse(
            'https://businessfest.imdigisol.com/api/getmarksbyuserid?UserID=${userID}'),
      );
      if (markedStallResponse.statusCode == 200) {
        final markedStallResponseData =
            json.decode(markedStallResponse.body.toString());
        // Get.snackbar("decoded", '$markedStallResponseData');

        if (markedStallResponseData is List) {
          if (currentUser.value.bfestRole == '1') {
            judgeMarkedStalls.clear(); // Clear existing data
            List<JudgeMarkedStall> data = markedStallResponseData
                .map((markedStall) => JudgeMarkedStall.fromJson(markedStall))
                .toList();
            judgeMarkedStalls.assignAll(data);
          } else if (currentUser.value.bfestRole == '2') {
            teamMarkedStalls.clear(); // Clear existing data
            List<TeamMarkedStall> data = markedStallResponseData
                .map((markedStall) => TeamMarkedStall.fromJson(markedStall))
                .toList();
            teamMarkedStalls.assignAll(data);
          }
        } else if (markedStallResponseData is Map<String, dynamic>) {
          // If response is a single stall object
          if (currentUser.value.bfestRole == '1') {
            JudgeMarkedStall singleStall =
                JudgeMarkedStall.fromJson(markedStallResponseData);
            judgeMarkedStalls.assignAll([singleStall]);
          } else if (currentUser.value.bfestRole == '2') {
            TeamMarkedStall singleStall =
                TeamMarkedStall.fromJson(markedStallResponseData);
            teamMarkedStalls.assignAll([singleStall]);
          }
        } else {
          // Invalid data format
          throw ('Invalid data format');
        }
      } else {
        throw ("Failed to load data. Status code: ${markedStallResponse.statusCode}");
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<void> logOut() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove("userName");
    // prefs.remove("password");
    Get.offAllNamed('/login');
  }

  Future<void> checkLoggedInUser() async {
    try {
      isLoading.value = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userName = prefs.getString('userName');
      final password = prefs.getString('password');
      if (userName != null && password != null) {
        await login(userName, password);
        update();
        if (allStalls.isNotEmpty) {
          Get.offAllNamed('/dashboard', arguments: {
            'user': currentUser.value,
          });
        } else {
          Get.offAllNamed('/login');
        }
      } else {
        Get.offAllNamed('/login');
      }
    } finally {
      isLoading.value = false;
      update(); // Notify listeners about changes
    }
  }
}
