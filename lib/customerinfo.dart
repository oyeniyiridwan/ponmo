import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponmo/Screens/payment.dart';
import 'package:ponmo/service/user.dart';
class Info extends StatefulWidget {
  final Keep keep;

  const Info({Key key, this.keep}) : super(key: key);
  @override
  _InfoState createState() => _InfoState(this.keep);
}

class _InfoState extends State<Info> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
   final _formKey = GlobalKey<FormState>();
   final Keep keep;


  _InfoState(this.keep);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: (Text("Customer details ",)),backgroundColor: Colors.deepOrange[400],),
        body: Container(
        child: ListView(

          children: <Widget>[
            Form(key: _formKey,
              child: Column(children: <Widget>[
                Row(children: <Widget>[
                  Expanded(child:
                  Container(padding: EdgeInsets.only(top:10,left: 20,right: 20.0, bottom: 10),
                    child:
                    SizedBox(height: 40,),)
                  ),
                Expanded(
                  child: Container(padding: EdgeInsets.only(top:10, bottom:10,left:30, right: 30,),
                      height: 60.0,
                      child: Material(
                        shadowColor: Colors.grey,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        elevation: 0.0,
                        child: GestureDetector(
                          child:Center(child: Text("#${keep.totalAmount}",style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black
                          ),
                            textScaleFactor: 1.5,)),

                          onTap: () {Navigator.pop(context);
                          },

                        ),
                      )

                  ),
                )],),
              Container(
                padding: EdgeInsets.only(top:20,left: 40,right: 40.0, bottom: 20),
                alignment: Alignment.center,
                child: Text("Dear user, pls note this program is only available in Osogbo, Osun State Only, we hope to expand soonest, thanks. ",
                  style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,
                      color: Colors.black),),
              ),
              Container(padding: EdgeInsets.only(top:10,left: 20,right: 20.0, bottom: 20),
                child: TextFormField(
                    controller: emailController,
                    cursorColor: Colors.grey,
                    style: TextStyle(color: Colors.black45),

                    decoration: InputDecoration(icon: Icon(Icons.location_city,color: Colors.deepOrange[200],),
                      labelText: "Email",
                      hintText: "Pls enter Your email",
                      hintStyle: TextStyle(color: Colors.black12),

                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),borderSide: BorderSide(
                          color: Colors.white
                      )),
                    ),
                    validator: (input){if(input.isNotEmpty && input.contains("@") && input.contains(".com")){return null;}else{
                      return "pls enter active email address";}}
                ),
              ),
              Container(padding: EdgeInsets.only(top:10,left: 20,right: 20.0, bottom: 10),
                child: TextFormField(
                  controller: nameController,
                  cursorColor: Colors.grey,
                  style: TextStyle(color: Colors.black45),

                  decoration: InputDecoration(icon: Icon(Icons.person,color: Colors.deepOrange[200],),
                    labelText: "Name",
                    hintText: "Pls enter name",
                    hintStyle: TextStyle(color: Colors.black12),

                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                    ),

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),borderSide: BorderSide(
                        color: Colors.white
                    )),
                  ),
                  validator: (input){if(input.isNotEmpty &&  input.length>= 3){return null;}else{
                    return "pls input your name";}}

          ),
              ),
              Container(padding: EdgeInsets.only(top:10,left: 20,right: 20.0, bottom: 10),
                child: TextFormField(
                    controller: addressController,
                    cursorColor: Colors.grey,
                    style: TextStyle(color: Colors.black45),

                    decoration: InputDecoration(icon: Icon(Icons.location_city,color: Colors.deepOrange[200],),
                      labelText: "Address",
                      hintText: "Pls enter Your Address",
                      hintStyle: TextStyle(color: Colors.black12),

                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),borderSide: BorderSide(
                          color: Colors.white
                      )),
                    ),
                    validator: (input){if(input.isNotEmpty &&  input.length>= 5){return null;}else{
                      return "pls input your current address";}}

                ),
              ),
              Container(padding: EdgeInsets.only(top:10,left: 20,right: 20.0, bottom: 10),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                    controller: phoneController,
                    cursorColor: Colors.grey,
                    style: TextStyle(color: Colors.black45),

                    decoration: InputDecoration(icon: Icon(Icons.phone,color: Colors.deepOrange[200],),
                      labelText: "Phone Number",
                      hintText: "Pls enter your phone number",
                      hintStyle: TextStyle(color: Colors.black12),

                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black45
                      ),

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),borderSide: BorderSide(
                          color: Colors.white
                      )),
                    ),
                    validator: (input){if(input.isNotEmpty &&  input.length>= 11 && input.length<= 11){return null;}else{
                      return "pls input your phone number";}}

                ),
              ),


              Container(padding: EdgeInsets.only(top:30,left: 20,right: 20.0, bottom: 10),
                child: Center(
                  child: Container(padding: EdgeInsets.only(left:40, right: 40,),
                      height: 40.0,
                      child: Material(
                        shadowColor: Colors.grey,
                        color: Colors.deepOrange[500],
                        borderRadius: BorderRadius.circular(20.0),
                        elevation: 0.0,
                        child: GestureDetector(
                          child:Center(child: Text("MAKE PAYMENT",style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey
                          ),
                            textScaleFactor: 1.5,)),

                          onTap: () async{if(_formKey.currentState.validate()){
                            _navigateInfo(context);

                          }
                          },

                        ),
                      )

                  ),
                ),
              )

          ],
        ),
            ),
      ]
    )
    ));

  }
  _navigateInfo(BuildContext context) async{
    CustomInfo customInfo = CustomInfo(emailController.text,nameController.text,phoneController.text,addressController.text, keep.totalAmount,keep.thick,keep.round,keep.normal);
    final result1 = await Navigator.push(context, MaterialPageRoute(builder: (context) => Payment(customInfo: customInfo,)));
    print(result1);
  }
}
