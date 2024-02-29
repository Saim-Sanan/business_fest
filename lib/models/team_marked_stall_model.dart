class TeamMarkedStall {
  String bfestMarksId;
  String stallId;
  String bfestUserId;
  String bfestMarketingMarks;
  String bfestDecorOfStallMarks;
  String bfestTeamConductMarks;
  String bfestSponsorshipMarks;
  dynamic createdAt;
  dynamic updatedAt;
  String stallName;
  String members;
  String photo;

  TeamMarkedStall({
    required this.bfestMarksId,
    required this.stallId,
    required this.bfestUserId,
    required this.bfestMarketingMarks,
    required this.bfestDecorOfStallMarks,
    required this.bfestTeamConductMarks,
    required this.bfestSponsorshipMarks,
    required this.createdAt,
    required this.updatedAt,
    required this.stallName,
    required this.members,
    required this.photo,
  });

  factory TeamMarkedStall.fromJson(Map<String, dynamic> json) =>
      TeamMarkedStall(
        bfestMarksId: json["BfestMarksID"],
        stallId: json["StallID"],
        bfestUserId: json["BfestUserID"],
        bfestMarketingMarks: json["BfestMarketingMarks"],
        bfestDecorOfStallMarks: json["BfestDecorofStallMarks"],
        bfestTeamConductMarks: json["BfestTeamConductMarks"],
        bfestSponsorshipMarks: json["BfestSponsorshipMarks"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        stallName: json["StallName"],
        members: json["Members"],
        photo: json["Photo"],
      );

  Map<String, dynamic> toJson() => {
        "BfestMarksID": bfestMarksId,
        "StallID": stallId,
        "BfestUserID": bfestUserId,
        "BfestMarketingMarks": bfestMarketingMarks,
        "BfestDecorofStallMarks": bfestDecorOfStallMarks,
        "BfestTeamConductMarks": bfestTeamConductMarks,
        "BfestSponsorshipMarks": bfestSponsorshipMarks,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "StallName": stallName,
        "Members": members,
        "Photo": photo,
      };
}
