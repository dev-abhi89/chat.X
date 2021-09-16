import 'package:firebase_auth/firebase_auth.dart';
class AuthService{
 final FirebaseAuth _auth = FirebaseAuth.instance;

 Future SignupEmailPass(String email, String pass, String name) async {
  try{
   UserCredential usr= await _auth.createUserWithEmailAndPassword(email: email,
       password: pass);
   var user= usr.user;
   await user!.updateDisplayName(name);
    return user;
  }catch(e){
   print(e.toString());
   return null;
  }
 }
Future Logout() async {
  try {
   await _auth.signOut();
  }catch(e){
   print(e.toString());
  }
}


 Future LoginEmailPass(String email,String password) async{
  try{
  UserCredential result  = await _auth.signInWithEmailAndPassword(email: email
      , password: password);
  return result.user;
  }catch(e){
   print(e.toString());
   return null;
  }


 }

}