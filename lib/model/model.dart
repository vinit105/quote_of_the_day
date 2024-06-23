import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  String id;
  String content;
  String author;
  int length;
  Welcome({
    required this.id,
    required this.content,
    required this.author,
    required this.length,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    id: json["_id"],
    content: json["content"],
    author: json["author"],
    length: json["length"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "content": content,
    "author": author,
    "length": length, };
}
