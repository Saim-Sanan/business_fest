class User {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  dynamic image;
  dynamic branchId;
  dynamic usertype;
  String bfestRole;
  dynamic createdAt;
  dynamic updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.image,
    required this.branchId,
    required this.usertype,
    required this.bfestRole,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        image: json["image"],
        branchId: json["branch_id"],
        usertype: json["usertype"],
        bfestRole: json["BfestRole"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "image": image,
        "branch_id": branchId,
        "usertype": usertype,
        "BfestRole": bfestRole,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
