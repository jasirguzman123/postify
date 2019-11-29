import 'package:flutter/material.dart';
import 'package:postify/services/date_parser.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animations/loading_animations.dart';

class User extends StatelessWidget{
  String name;
  String email;
  String profilePic;
  String uid;
  String postedAt;

  User({ this.email, this.name, this.postedAt, this.profilePic, this.uid });

  factory User.fromJson(json){
    return User(
      email: json['email'],
      name: json['name'],
      postedAt: DateParser.parseDate(json['posted_at']),
      profilePic: json['profile_pic'],
      uid: json['uid']
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(
          imageUrl: profilePic,
          placeholder: (context, url) => LoadingBouncingLine.circle(),
          errorWidget: (context, url, error) => Image.asset('assets/error.png'),
          height: 100,
        )
      ),
      title: Text(name),
      subtitle: Text(email),
      trailing: Text(postedAt)
    );
  }
}