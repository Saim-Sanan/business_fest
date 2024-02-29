class JudgeMarkedStall {
  String judgeMarksId;
  String stallId;
  String judgeId;
  String productMarks;
  String innovationMarks;
  String sdgRelationMarks;
  String revenueStreamMarks;
  String futurePotentialMarks;
  String teamPresentationMarks;
  String marketResearchMarks;
  String decorofStallMarks;
  dynamic createdAt;
  dynamic updatedAt;
  String stallName;
  String members;
  String photo;

  JudgeMarkedStall({
    required this.judgeMarksId,
    required this.stallId,
    required this.judgeId,
    required this.productMarks,
    required this.innovationMarks,
    required this.sdgRelationMarks,
    required this.revenueStreamMarks,
    required this.futurePotentialMarks,
    required this.teamPresentationMarks,
    required this.marketResearchMarks,
    required this.decorofStallMarks,
    required this.createdAt,
    required this.updatedAt,
    required this.stallName,
    required this.members,
    required this.photo,
  });

  factory JudgeMarkedStall.fromJson(Map<String, dynamic> json) =>
      JudgeMarkedStall(
        judgeMarksId: json["JudgeMarksID"],
        stallId: json["StallID"],
        judgeId: json["JudgeID"],
        productMarks: json["ProductMarks"],
        innovationMarks: json["InnovationMarks"],
        sdgRelationMarks: json["SDGRelationMarks"],
        revenueStreamMarks: json["RevenueStreamMarks"],
        futurePotentialMarks: json["FuturePotentialMarks"],
        teamPresentationMarks: json["TeamPresentationMarks"],
        marketResearchMarks: json["MarketResearchMarks"],
        decorofStallMarks: json["DecorofStallMarks"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        stallName: json["StallName"],
        members: json["Members"],
        photo: json["Photo"],
      );

  Map<String, dynamic> toJson() => {
        "JudgeMarksID": judgeMarksId,
        "StallID": stallId,
        "JudgeID": judgeId,
        "ProductMarks": productMarks,
        "InnovationMarks": innovationMarks,
        "SDGRelationMarks": sdgRelationMarks,
        "RevenueStreamMarks": revenueStreamMarks,
        "FuturePotentialMarks": futurePotentialMarks,
        "TeamPresentationMarks": teamPresentationMarks,
        "MarketResearchMarks": marketResearchMarks,
        "DecorofStallMarks": decorofStallMarks,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "StallName": stallName,
        "Members": members,
        "Photo": photo,
      };
}
