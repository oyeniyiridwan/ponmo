import 'package:firebase_auth/firebase_auth.dart';
import 'package:ponmo/service/user.dart';



class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _userFromFireBaseUser(FirebaseUser user) {
    return user != null? User(uid: user.uid): null;

  }
  Stream<User> get user{
    return _auth.onAuthStateChanged
        .map(_userFromFireBaseUser);
  }

  Future signInAnon() async{
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    }
    catch(e){
      print(e.toString());}
    return null;}
  Future registerInEmail(String email, String password) async{
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email:email , password: password);
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    }
    catch(e){
      print(e.toString());}
    return null;}
  Future signInEmail(String email, String password) async{
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email:email , password: password);
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    }
    catch(e){
      print(e.toString());}
    return null;}
  Future passwordReset1(String phoneNumber) async{
    try {
      await _auth.verifyPhoneNumber(phoneNumber: phoneNumber, timeout: Duration(minutes: 2), verificationCompleted: null, verificationFailed: null, codeSent: null, codeAutoRetrievalTimeout:null);
      if(true){return true;}

    }
    catch(e){
      print(e.toString());}
    return null;}


  Future passwordReset(String email) async{
    try {
      await _auth.sendPasswordResetEmail(email: email);
      if(true){return true;}

    }
    catch(e){
      print(e.toString());}
    return null;}


  Future signOut() async{
    try {
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());}
    return null;}
}
