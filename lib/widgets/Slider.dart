import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponmo/model/slidemodel.dart';
// ignore: must_be_immutable
class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);
  TextEditingController priceController = TextEditingController();
  final  formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Container(
        child:ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30,),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[Container(
                  width: 220,height: 220,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage(slideList[index].imageUrl),
                          fit:BoxFit.cover )
                  )
              ),


                    Container(padding: EdgeInsets.only(top:5.0,bottom: 10,left:40),
                        alignment: Alignment.topLeft,

                        child: Text(slideList[index].price,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,
                            color: Colors.black, ),textScaleFactor: 1.5,),

                    ),
                    Container(padding: EdgeInsets.only(top:5.0,bottom: 10,left: 40.0),
                      alignment: Alignment.topLeft,
                      child: Text(slideList[index].title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,
                          color: Colors.deepOrange),textScaleFactor: 1.3,),
                    ),
                Container(padding: EdgeInsets.only(top:5.0,left: 40,right: 40.0),
                  alignment: Alignment.center,
                  child: Text(slideList[index].description,
                    style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,
                      color: Colors.black),),
                ),






              ],
            ),
          )
          ,]
        )
    ,);
  }
}

