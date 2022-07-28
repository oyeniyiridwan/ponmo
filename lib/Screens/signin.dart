import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponmo/service/auth.dart';
import 'package:ponmo/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  String error = "";
  String success = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
   final _formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    //TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return loading? Loading():Scaffold(
      backgroundColor: Colors.deepOrange[400],

      appBar: AppBar(title: (Text(" Sign in")),actions: <Widget>[
        FlatButton.icon(onPressed: (){widget.toggleView();},
            icon: Icon(Icons.person), label:Text("Register"))
      ], ),

      body:Form(
        key: _formKey,
        child: Stack(
          fit: StackFit.expand,
        children: <Widget>[
          Image(image: AssetImage("images/ponmo.jpg"), fit: BoxFit.fill,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,),
          ListView(
            children: <Widget>[
              Container(padding: EdgeInsets.only(left: 10.0),
                child: Stack(children: <Widget>[
              Text("Hello",
                 style: TextStyle(
                  fontSize: 70.0,
                  fontWeight: FontWeight.bold,
                     fontStyle: FontStyle.normal,
                  color: Colors.white70),
              )
                ]
                  ,)
                ,)
              ,
              Padding(padding: EdgeInsets.only(top: 0.0, bottom: 20.0),
                  child:Row(children: <Widget>[
                //Expanded(child:
                Container(padding: EdgeInsets.only(left: 10.0,right: 0.0),
                child: Stack(children: <Widget>[
                  Text("There",
                    style: TextStyle(
                      fontSize: 70.0,
                      fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                      color: Colors.white70),)],)
                  ,
               // )
                ),
                //Expanded(child:
    Container(padding: EdgeInsets.only(left: 0.0),
                  child: Stack(children: <Widget>[
                    Text(".", style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold, fontStyle: FontStyle.normal,
                        color: Colors.deepOrange[400]),)]
                    ,)
                  ,
                //)
                ),
              ])
              ),



              Container(padding: EdgeInsets.only(top: 80),
                  child:Column(
                      children: <Widget>[

                        TextFormField(
                          controller: emailController,
                          cursorColor: Colors.grey,

                          style: TextStyle(color: Colors.grey),
                          decoration: InputDecoration(icon: Icon(Icons.email,color: Colors.deepOrange[200],),
                              labelText: "EMAIL",
                              hintText: "Pls enter email Address",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,)
                          ),

                          validator: (input){if(input.isNotEmpty && input.contains("@") && input.contains(".com")){return null;}else{
                            return "pls input a correct email address";
                        }},
                        )])),
              Container(padding: EdgeInsets.only(top: 30,bottom: 30),
                  child:Column(

                      children: <Widget>[

                        TextFormField(
                          controller: passwordController,
                          cursorColor: Colors.grey,
                          style: TextStyle(color: Colors.grey),
                          obscureText: true,

                          decoration: InputDecoration(icon: Icon(Icons.keyboard_hide,color: Colors.deepOrange[200],),
                              labelText: "PASSWORD",
                              hintText: "Pls enter Password",
                              hintStyle: TextStyle(color: Colors.grey),


                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey
                              ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),),

                          ),
                          validator: (input){if(input.isNotEmpty &&  input.length>= 5 && input.length<= 20){return null;}else{
    return "pls input character in between 5-7";}},

                        )
                      ]
                  )
              ),
              Container(padding: EdgeInsets.only(left:300, right: 20,),
                  height: 30.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(1000),
                    elevation: 0.0,color: Colors.black,
                    child: GestureDetector(
                      child:Center(child: Text("RESET",style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.deepOrange[400]
                      ),
                        textScaleFactor: 0.8,)),

                      onTap: ()async{
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.passwordReset(emailController.text);
                          if (result == null) {
                            setState(() {loading =false;
                            _respond(context,"ERROR" ,"Pls enter a valid email");
                            });
                          } else{
                            setState(() {loading = false;
                            _respond(context, "Success","Pls check your mail to reset password");


                            });
                          }


                      },

                    ),
                  )

              ),
            SizedBox(height: 50.0),
            Center(child:
            Container(padding: EdgeInsets.only(left:20, right: 20,),
              height: 50.0,
              child: Material(
                borderRadius: BorderRadius.circular(1000),
                elevation: 0.0,color: Colors.deepOrange[500],
                child: GestureDetector(
                  child:Center(child: Text("LOG IN",style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey
                  ),
                  textScaleFactor: 1.5,)),

                  onTap: ()async{
                    if(_formKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInEmail(
                          emailController.text.toLowerCase().trim(),
                          passwordController.text.toLowerCase().trim());
                      if (result == null) {
                        setState(() {loading =false;
                        _respond(context,"Error", "Pls enter a valid email");
                        });
                      } else {
                        debugPrint("$emailController");
                        debugPrint("$passwordController");

                      }
                    }

                  },

                ),
              )

            )),


            ],

          ),

        ],

      ),
    ));
  }

  void _respond(BuildContext context, String message, String message2){
    var alertDialog = AlertDialog(backgroundColor: Colors.grey,
      title:Text(message),
      content:Text(message2),);
    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        } );
  }
}
