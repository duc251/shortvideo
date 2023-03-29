 

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/cconstants.dart';
import 'package:tiktok_clone/models/comment.dart';

class CommentController extends GetxController{
  final Rx<List<Comment>> _comments= Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;
  String _postId = "";

  updatePostId(String id){
    _postId = id;

     getComment();
  }
  getComment() async{

  }
postComment(String commentText) async{
  try{
    if(commentText.isNotEmpty){
    DocumentSnapshot userDoc = await firestore.collection('users').doc(authController.user.uid).get();
    var allDocs = await firestore.collection('videos').doc(_postId).collection('comment').get();
    int len = allDocs.docs.length;

    Comment comment = Comment(
      username: (userDoc.data()!as dynamic)['name'], 
      comment: commentText.trim(), 
      datepublished: DateTime.now(), 
      likes: [], 
      profilePhoto: (userDoc.data()! as dynamic)['profilePhoto'], 
      id: 'Comment $len', 
      uid: authController.user.uid,
      );
      await firestore
      .collection('videos')
      .doc(_postId)
      .collection('commnets')
      .doc('Comment $len')
      .set(comment.toJson());
  }
  
  }catch(e){
    Get.snackbar('Error While Commenting', e.toString());
  }
  
}
}