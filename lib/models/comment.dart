import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Comment{
String username;
String comment;
final datepublished;
List likes;
String profilePhoto;
String uid;
String id;

Comment( {
  required this.username,
  required this.comment,
  required this.datepublished,
  required this.likes,
  required this.profilePhoto,
  required this.id,
  required this.uid,
});
Map<String,dynamic> toJson() =>{
"username":username,
"comment":comment,
"datepublished":datepublished,
"likes":likes,
"profilePhoto":profilePhoto,
"id":id,
"uid":uid,
};
static Comment fromSnap(DocumentSnapshot snap){
  var snapshot = snap.data() as Map<String,dynamic>;
  return Comment(
    username:snapshot ['username'],
     comment:snapshot ['comment'], 
     datepublished:snapshot ['datepublished'],
      likes:snapshot ['likes'], 
      profilePhoto:snapshot ['profilePhoto'], 
      id:snapshot ['id'], 
      uid:snapshot ['uid'],);
}
}