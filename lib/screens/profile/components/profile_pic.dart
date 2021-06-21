import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatefulWidget {
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File _imageFile;
  final picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;
  var _currentUser = FirebaseAuth.instance.currentUser;
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child('Users');

  Future _pickImage() async {
    //use dialog if want to add getImage from library
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    // final pickedImageFile = File(pickedImage.path);
    setState(() {
      _imageFile = File(pickedFile.path);
    });
    //forward the image to auth form
    // widget.imagePickFn(pickedImageFile);
    _uploadImageToFirebase();
    // dbRef.child(_currentUser.uid).update({'avatar': 'jhvjvvj'});
  }

  Future _uploadImageToFirebase() async {
    String fileName = basename(_imageFile.path);
    String url;
    Reference ref =
        storage.ref().child('user/avatar/${_currentUser.uid}_$fileName');
    UploadTask uploadTask = ref.putFile(_imageFile);
    uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
      await dbRef.child(_currentUser.uid).update({'avatar': url});
    }).catchError((onError) {
      print(onError);
    });
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: _imageFile != null ? FileImage(_imageFile) : null,
          ),
          Positioned(
            right: -12,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: _pickImage,
                child: SvgPicture.asset('assets/icons/Camera Icon.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
