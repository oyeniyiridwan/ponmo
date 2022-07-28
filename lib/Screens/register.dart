import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponmo/service/auth.dart';
import 'package:ponmo/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    //TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.deepOrange[400],
            appBar: AppBar(
              title: (Text(" Register")),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Sign in"))
              ],
            ),
            body: Form(
              key: _formKey,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image(
                    image: AssetImage("images/ponmo.jpg"),
                    fit: BoxFit.fill,
                    color: Colors.black87,
                    colorBlendMode: BlendMode.darken,
                  ),
                  ListView(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 10.0,
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 0.0, bottom: 20.0),
                          child: Row(children: <Widget>[
                            //Expanded(child:
                            Container(
                              padding: EdgeInsets.only(left: 10.0, right: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Text(
                                    "SignUp",
                                    style: TextStyle(
                                        fontSize: 70.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white70),
                                  )
                                ],
                              ),
                              //)
                            ),
                            //Expanded(child:
                            Container(
                              padding: EdgeInsets.only(left: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Text(
                                    ".",
                                  )
                                ],
                              ),
                            )
                            //),
                          ])),
                      Container(
                        height: 10,
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 50),
                          child: Column(children: <Widget>[
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 0.0, bottom: 20.0),
                                child: Row(children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Column(children: <Widget>[
                                          TextFormField(
                                              controller: nameController,
                                              cursorColor: Colors.grey,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                              decoration: InputDecoration(
                                                icon: Icon(
                                                  Icons.person,
                                                  color: Colors.deepOrange[200],
                                                ),
                                                labelText: "Name",
                                                hintText: "Pls enter name",
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                                labelStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    borderSide: BorderSide(
                                                        color: Colors.white)),
                                              ),
                                              validator: (input) {
                                                if (input.isNotEmpty &&
                                                    input.length >= 5) {
                                                  return null;
                                                } else {
                                                  return "pls input your name";
                                                }
                                              })
                                        ])),
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.only(
                                          top: 20.0,
                                        ),
                                        child: Column(children: <Widget>[
                                          TextFormField(
                                            controller: phoneController,
                                            keyboardType: TextInputType.number,
                                            cursorColor: Colors.grey,
                                            style:
                                                TextStyle(color: Colors.grey),
                                            decoration: InputDecoration(
                                              icon: Icon(
                                                Icons.phone,
                                                color: Colors.deepOrange[200],
                                              ),
                                              labelText: "PHONE NUMBER",
                                              hintText:
                                                  "Pls enter Phone number",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                            validator: (input) {
                                              if (input.isNotEmpty &&
                                                  input.length >= 11 &&
                                                  input.length <= 11) {
                                                return null;
                                              } else {
                                                return "pls input correct Phone number";
                                              }
                                            },
                                          )
                                        ])),
                                  ),
                                ])),
                            TextFormField(
                                controller: addressController,
                                cursorColor: Colors.grey,
                                style: TextStyle(color: Colors.grey),
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.location_city,
                                      color: Colors.deepOrange[200],
                                    ),
                                    labelText: "ADDRESS",
                                    hintText: "Pls enter Home Address",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    )),
                                validator: (input) {
                                  if (input.isNotEmpty && input.length >= 5) {
                                    return null;
                                  } else {
                                    return "pls give a definite address";
                                  }
                                })
                          ])),
                      TextFormField(
                          controller: emailController,
                          cursorColor: Colors.grey,
                          style: TextStyle(color: Colors.grey),
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.email,
                                color: Colors.deepOrange[200],
                              ),
                              labelText: "EMAIL",
                              hintText: "Pls enter email Address",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              )),
                          validator: (input) {
                            if (input.isNotEmpty &&
                                input.contains("@") &&
                                input.contains(".com")) {
                              return null;
                            } else {
                              return "pls input a correct email address";
                            }
                          }),
                      Container(
                          padding: EdgeInsets.only(top: 30),
                          child: Column(children: <Widget>[
                            TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                cursorColor: Colors.grey,
                                style: TextStyle(color: Colors.grey),
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.keyboard_hide,
                                    color: Colors.deepOrange[200],
                                  ),
                                  labelText: "PASSWORD",
                                  hintText: "Pls enter Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                                validator: (input) {
                                  if (input.isNotEmpty &&
                                      input.length >= 5 &&
                                      input.length <= 20) {
                                    return null;
                                  } else {
                                    return "pls input character in between 5-7";
                                  }
                                })
                          ])),
                      Container(
                        height: 20.0,
                      ),
                      SizedBox(height: 30.0),
                      Center(
                          child: Container(
                              padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              height: 50.0,
                              child: Material(
                                shadowColor: Colors.grey,
                                color: Colors.deepOrange[500],
                                borderRadius: BorderRadius.circular(20.0),
                                elevation: 0.0,
                                child: GestureDetector(
                                  child: Center(
                                      child: Text(
                                    "SIGN UP",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                    textScaleFactor: 1.5,
                                  )),
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      dynamic result =
                                          await _auth.registerInEmail(
                                              emailController.text
                                                  .toLowerCase()
                                                  .trim(),
                                              passwordController.text
                                                  .toLowerCase()
                                                  .trim());
                                      if (result == null) {
                                        setState(() {
                                          loading = false;
                                          error = "Pls enter a valid email";
                                        });
                                      } else {}
                                    }
                                  },
                                ),
                              ))),
                      SizedBox(
                        height: 12,
                        child: (Text(
                          error,
                          style: TextStyle(
                              fontSize: 12.0,
                              fontStyle: FontStyle.italic,
                              color: Colors.red),
                        )),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }
}
