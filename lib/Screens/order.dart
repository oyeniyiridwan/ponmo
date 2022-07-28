import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponmo/service/user.dart';

import '../customerinfo.dart';
class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController priceController = TextEditingController();
  TextEditingController priceController1 = TextEditingController();
  TextEditingController priceController2 = TextEditingController();
  var displayResult = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Make Order"),backgroundColor: Colors.deepOrange[400],),
      body: Container(padding: EdgeInsets.only(top: 20, left: 0.0, right: 0.0),
        child: Form(key: _formKey,
          child: ListView(
            children: <Widget>[Row(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[Expanded(
                child: Column(children: <Widget>[
                Container(width: 100,height: 100,
                  decoration: BoxDecoration(shape: BoxShape.circle,
                    image: DecorationImage( image: AssetImage("images/ponmo.jpg"),fit: BoxFit.cover))
                  ),
                Container(padding: EdgeInsets.only(top: 10,bottom: 20, left: 10, right: 10),
                  child: Text("Thick and Soft",style: (TextStyle(color: Colors.black,fontSize: 20,
                  fontWeight: FontWeight.bold,)),),
                )]),
              ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left:0.0, right: 10.0, top:40.0,bottom:10.0),
                      child: TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.grey,
                        style: TextStyle(color: Colors.grey),

                        decoration: InputDecoration(
                          labelText: "Amount",
                          hintText: "amount in naira required",
                          hintStyle: TextStyle(color: Colors.grey),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),

                        ),
                        validator: (input){if(input.isNotEmpty && input.contains("00") && input.length<= 6){return null;}
                        if( input.isEmpty){setState(() {int value = 0;
                          priceController.text = value.toString();

                        });
                        return null;}
                        else{
                          return "Minimum request not met";}},


                      ),
                    ),
                  )


              ],),Row(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[Expanded(
                child: Column(children: <Widget>[
                  Container(width: 100,height: 100,
                      decoration: BoxDecoration(shape: BoxShape.circle,
                          image: DecorationImage( image: AssetImage("images/ponmo1.jpg"),fit: BoxFit.cover))
                  ),
                  Container(padding: EdgeInsets.only(top: 10, bottom: 20, left: 10,right: 10),
                    child: Text("Round and Soft",style: (TextStyle(color: Colors.black,fontSize: 20,
                      fontWeight: FontWeight.bold,)),),
                  )]),
              ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left:0.0, right: 10.0, top:40.0,bottom:10.0),
                    child: TextFormField(
                      controller: priceController1,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.grey,
                      style: TextStyle(color: Colors.grey),

                      decoration: InputDecoration(
                        labelText: "Amount",
                        hintText: "amount in naira required",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),

                      ),
                      validator: (input){
                        if(input.isNotEmpty && input.contains("00") && input.length<= 6){return null;}
                        if( input.isEmpty){setState(() {int value = 0;
                        priceController1.text = value.toString();

                        });
                        return null;}

                        else{
                        return "Minimum request not met";}},

                    ),
                  ),
                )


              ],),Row(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[Expanded(
                child: Column(children: <Widget>[
                  Container(width: 100,height: 100,
                      decoration: BoxDecoration(shape: BoxShape.circle,
                          image: DecorationImage( image: AssetImage("images/ponmo2.jpg"),fit: BoxFit.cover))
                  ),
                  Container(padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 20),
                    child: Text("Normal",style: (TextStyle(color: Colors.black,fontSize: 20,
                      fontWeight: FontWeight.bold,)),),
                  )]),
              ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left:0.0, right: 10.0, top:40.0,bottom:10.0),
                    child: TextFormField(
                      controller: priceController2,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.grey,
                      style: TextStyle(color: Colors.grey),

                      decoration: InputDecoration(
                        labelText: "Amount",
                        hintText: "amount in naira required",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),

                      ),
                      validator: (input){if(input.isNotEmpty && input.contains("00") && input.length<= 6){return null;}
                      if( input.isEmpty){setState(() {int value =00;
                      priceController2.text = value.toString();

                      });
                      return null;}
                      else{
                        return "Minimum request not met";}},

                    ),
                  ),
                ),





              ],),
              Row(children: <Widget>[
                Expanded(
                  child: Container(padding: EdgeInsets.only(left:40, right: 40,),
                      height: 40.0,
                      child: Material(
                        shadowColor: Colors.grey,
                        color: Colors.deepOrange[500],
                        borderRadius: BorderRadius.circular(20.0),
                        elevation: 0.0,
                        child: GestureDetector(
                          child:Center(child: Text("TOTAL",style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey
                          ),
                            textScaleFactor: 1.5,)),

                          onTap: () {setState(() {
                            if(_formKey.currentState.validate())
                            {
                              this.displayResult = calculate();
                              debugPrint("$priceController and $priceController1 and $priceController2");




                            }
                          });},

                        ),
                      )

                  ),
                ),
                Expanded(
                    child:Container(padding: EdgeInsets.only(left: 30),
                        child: Text("${this.displayResult}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),))
                  ),


              ],),
              Center(child: SizedBox(width: 30,height: 30,)),
              Center(
                child: Container(padding: EdgeInsets.only(left:40, right: 40,),
                    height: 40.0,
                    child: Material(
                      shadowColor: Colors.grey,
                      color: Colors.deepOrange[500],
                      borderRadius: BorderRadius.circular(20.0),
                      elevation: 0.0,
                      child: GestureDetector(
                        child:Center(child: Text("CHECKOUT",style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey
                        ),
                          textScaleFactor: 1.5,)),

                        // ignore: missing_return
                        onTap: () async{
                          //if(_formKey.currentState.validate())
                        {
                          this.displayResult = calculate();{if(double.parse(displayResult)>=3000){_navigateInfo(context);
                          }
                          else{
                            _respond(context, "Error", "Mininimum Order is #3000");
                          }}

                        }},

                      ),
                    )

                ),
              )

            ],
          ),
        ),
      ),
    );
  }
  String calculate(){
    int price = int.parse(priceController.text);
    int price1 = int.parse(priceController1.text);
    int price2 = int.parse(priceController2.text);
    int totalAmount = (price + price1 + price2);
    String result = "$totalAmount";
    return result;
  }
  _navigateInfo(BuildContext context) async{
    Keep keep = Keep(displayResult,priceController.text, priceController1.text,priceController2.text);
    final result1 = await Navigator.push(context, MaterialPageRoute(builder: (context) => Info(keep: keep,)));
    print(result1);
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
