import 'dart:convert';

class StorageModel {
  final String username;
  final String password;
  final List<String> listRoom;

  StorageModel({
    required this.username,
    required this.password,
    required this.listRoom,
  });

  factory StorageModel.fromRawJson(String str) =>
      StorageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StorageModel.fromJson(Map<String, dynamic> json) => StorageModel(
        username: json["username"],
        password: json["password"],
        listRoom: List<String>.from(json["listRoom"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "listRoom": List<dynamic>.from(listRoom.map((x) => x)),
      };
}
