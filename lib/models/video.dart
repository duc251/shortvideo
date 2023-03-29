 

import 'package:cloud_firestore/cloud_firestore.dart';

class Video{
  String username;
  String uid;
  String id;
  List like;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilePhoto;

  Video({
    required this.username,
    required this.uid,
    required this.id,
    required this.like,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.profilePhoto,
    required this.thumbnail,
  });
Map<String, dynamic> toJson()=>{
   "username": username,
       "uid": uid,
        "id": id, 
        "like": like, 
        "commentCount": commentCount, 
        "shareCount": shareCount, 
        "songname": songName, 
        "caption": caption, 
        "videoUrl": videoUrl, 
        "profilePhoto": profilePhoto, 
        "thumbnail": thumbnail
};
  static Video fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
      username: snapshot['username'],
       uid: snapshot['uid'],
        id: snapshot ['id'], 
        like:snapshot ['like'], 
        commentCount:snapshot ['commentCount'], 
        shareCount:snapshot ['shareCount'], 
        songName:snapshot ['songname'], 
        caption:snapshot ['caption'], 
        videoUrl:snapshot ['videoUrl'], 
        profilePhoto:snapshot ['profilePhoto'], 
        thumbnail:snapshot ['thumbnail'],
        );
  }
}