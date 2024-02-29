import 'package:bfest/auth/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MarkingController extends GetxController {
  RxBool isLoading = RxBool(false);

  Future<bool?> submitJudgingMarks({
    required String stallID,
    required String productMarks,
    required String innovationMarks,
    required String sdgRelationMarks,
    required String revenueStreamMarks,
    required String futurePotentialMarks,
    required String teamPresentationMarks,
    required String marketResearchMarks,
    required String decorOfStallMarks,
    required String judgeID,
  }) async {
    try {
      isLoading.value = true;

      final headers = {
        'token':
            '\$2a\$09\$eoI2FfGruHb1/hpztWA6eOw37Z622O3a7h.B9C/u0O1yu8j6kABem'
      };

      final response = await http.post(
        Uri.parse(
            'https://businessfest.imdigisol.com/api/insertjudgemarks?ProductMarks=$productMarks&InnovationMarks=$innovationMarks&SDGRelationMarks=$sdgRelationMarks&RevenueStreamMarks=$revenueStreamMarks&FuturePotentialMarks=$futurePotentialMarks&TeamPresentationMarks=$teamPresentationMarks&MarketResearchMarks=$marketResearchMarks&StallID=$stallID&DecorofStallMarks=$decorOfStallMarks&JudgeID=$judgeID'),
        headers: headers,
      );

      if (response.statusCode == 201) {
        // Handle success, e.g., show a success message
        print('Marks submitted successfully');
        return true;
      } else {
        // Handle failure, e.g., show an error message
        print('Failed to submit marks');
        return false;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> submitTeamEvaluationMarks({
    required String stallID,
    required String marketingMarks,
    required String recordManagementMarks,
    required String teamConductMarks,
    required String sponsorshipMarks,
    required String decorOfStallMarks,
    required String bfestUserID,
  }) async {
    try {
      isLoading.value = true;

      final headers = {
        'token':
            '\$2a\$09\$eoI2FfGruHb1/hpztWA6eOw37Z622O3a7h.B9C/u0O1yu8j6kABem'
      };

      final response = await http.post(
        Uri.parse(
            'https://businessfest.imdigisol.com/api/insertbfestmarks?StallID=$stallID&BfestMarketingMarks=$marketingMarks&BfestDecorofStallMarks=$decorOfStallMarks&BfestTeamConductMarks=$teamConductMarks&BfestSponsorshipMarks=$sponsorshipMarks&BfestUserID=$bfestUserID'),
        headers: headers,
      );

      if (response.statusCode == 201) {
        // Handle success, e.g., show a success message
        print('Marks submitted successfully');
        return true;
      } else {
        // Handle failure, e.g., show an error message
        print('Failed to submit marks');
        return false;
      }
    } finally {
      isLoading.value = false;
    }
  }

  void updateMarkedStalls({required String userID, required String bfestRole}) {
    final LoginController loginController = Get.put(LoginController());
    loginController.getMarkedStalls(userID, bfestRole);
    loginController.update();
  }
}
