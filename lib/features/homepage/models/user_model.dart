import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String name;
  int age;
  String location;
  List<String> hobbies;
  String description;
  String image;
  int likes;
  String distance;
  bool visible;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.location,
    required this.hobbies,
    required this.description,
    required this.image,
    required this.likes,
    required this.distance,
    required this.visible,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        age: json["age"],
        location: json["location"],
        hobbies: List<String>.from(json["hobbies"].map((x) => x)),
        description: json["description"],
        image: json["image"],
        likes: json["likes"],
        distance: json["distance"],
        visible: json["visible"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "age": age,
        "location": location,
        "hobbies": List<dynamic>.from(hobbies.map((x) => x)),
        "description": description,
        "image": image,
        "likes": likes,
        "distance": distance,
        "visible": visible,
      };
}
