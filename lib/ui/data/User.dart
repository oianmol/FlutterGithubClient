import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.for

class User{

/// JSON serialization logic to be generated.
//@JsonSerializable()

/// Every json_serializable class must have the serializer mixin.
/// It makes the generated toJson() method to be usable for the class.
/// The mixin's name follows the source class, in this case, User. class User {
  final String name;
  final String email;
  final String avatarUrl;
  final String followersCount;
  final String followingCount;
  final String bio;
  final String login;


  User(this.name, this.email, this.avatarUrl, this.followersCount,
      this.followingCount, this.bio, this.login);


  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated _$UserFromJson constructor.
  /// The constructor is named after the source class, in this case User.
  User.fromJson(Map<String, dynamic> json):
       this.name= json['name'],
        this.email= json['email'],
        this.avatarUrl = json['avatar_url'],
        this.followersCount=json['followers'],
        this.followingCount= json['following'],
        this.bio=json['bio'],
        this.login=json['login'];


  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'email': email,
        'avatar_url': avatarUrl,
        'followers': followersCount,
        'following': followingCount,
        'bio': bio,
        'login': login
      };

}


class UserList {
  final List<User> users;

  UserList({
    this.users,
  });

  factory UserList.fromJson(List<dynamic> parsedJson) {
    List<User> users = new List<User>();
    users = parsedJson.map((i) => User.fromJson(i)).toList();

    return new UserList(
        users: users
    );
  }
}