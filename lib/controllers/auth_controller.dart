
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/cconstants.dart';
import 'package:tiktok_clone/models/user.dart' as model;
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';
 

class AuthController extends GetxController{
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  late Rx<File?> _pickedImage;
  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;
@override
  void onReady(){
    super.onReady();
    _user = Rx<User?> (firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitalScreen);
  }

  _setInitalScreen(User? user){
    if(user == null){
      Get.offAll(()=> LoginScreen());
    }else{
      Get.offAll(()=> HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      Get.snackbar('profile picture', 'you have succesfully selected your profile picture');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  Future<String> _uploadToStorage(File image) async{
    Reference ref = firebaseStorage
    .ref()
    .child('profilePic')
    .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
  void registerUser(
    String username, String email, String password,File? image
  )async{
    try{
       if(username.isNotEmpty&&
    email.isNotEmpty &&
    password.isNotEmpty &&
    image != null
    ){
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, 
          password: password);
         String downloadurl = await _uploadToStorage(image);
         model.User user = model.User(
          name: username, 
          email: email, 
          profilePhoto: downloadurl,
           uid: cred.user!.uid);
           await firestore
           .collection('users')
           .doc(cred.user!.uid)
           .set(user.toJson());
    }else{
      Get.snackbar('Error Creating Account', 'Please enter all the fields',);
    }
    }catch (e){
      Get.snackbar('Error Creating Account', e.toString(),);
    }
   
  }

  void loginUser(String email, String password) async{
    try{
      if(
        email.isNotEmpty&&
    email.isNotEmpty 
      ){
        await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      }else{
        Get.snackbar('Error Account', 'Please enter all the fields',);
    }
    }catch (e){
       Get.snackbar('Error Account', e.toString(),);
    }
  }
}