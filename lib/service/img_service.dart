
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class ImageService{

  final ImagePicker _picker = ImagePicker();


  File? imgFile;
String? imgurl;


  Future imgPick(String id) async{
   await _picker.pickImage(source: ImageSource.gallery).then((xfile){
      if(xfile!=null){
        imgFile=File(xfile.path);
        Uploadimg(id);
      }
    });
  }


  Future Uploadimg(String id) async{
    final FirebaseStorage _storage = FirebaseStorage.instance;
    final FirebaseFirestore _firestore =    FirebaseFirestore.instance;
    final FirebaseAuth _authbase = FirebaseAuth.instance;
    String filestr= Uuid().v1();
    int flag=1;
   try {
     await _firestore.collection('chatroom').doc(id).collection('chats').doc(filestr).set({
        'sendby': _authbase.currentUser!.displayName,
        'message': "",
        'type': "img"
        ,'time':FieldValue.serverTimestamp()
      });
   } catch (e) {
     print(e.toString());
     flag=2;
   }
  var ref= _storage.ref().child('images').child("$filestr.jpg");
  await ref.putFile(imgFile!).catchError((e) async{
    print(e.toString());
    flag=2;
    await _firestore.collection('chatroom').doc(id).collection('chats').doc(filestr).delete();
  });
  if(flag==1){
   try{ imgurl= await ref.getDownloadURL();
    _firestore.collection('chatroom').doc(id).collection('chats').doc(filestr).update({
      'message':imgurl
    });
    print(imgurl);

  }catch(e){
     print(e.toString());
   }
  }

}


}