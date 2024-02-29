class Stall {
  String stallId;
  String stallName;
  String members;
  dynamic photo;
  dynamic createdAt;
  dynamic updatedAt;

  Stall({
    required this.stallId,
    required this.stallName,
    required this.members,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Stall.fromJson(Map<String, dynamic> json) => Stall(
        stallId: json["StallID"],
        stallName: json["StallName"],
        members: json["Members"],
        photo: json["Photo"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "StallID": stallId,
        "StallName": stallName,
        "Members": members,
        "Photo": photo,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
