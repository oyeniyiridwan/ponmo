import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ponmo/Screens/dots.dart';
import 'package:ponmo/Screens/order.dart';
import 'package:ponmo/model/slidemodel.dart';
import 'package:ponmo/widgets/Slider.dart';
import 'package:ponmo/shared/constants.dart';

class Introduction extends StatefulWidget {
  @override
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  final PageController _pageController = PageController(initialPage: 0);
 bool loading = false;
 int _currentPage = 0;

 @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 7), (Timer timer){
      if(_currentPage<2){_currentPage++;}else{_currentPage = 0  ;}
      _pageController.animateToPage(_currentPage, duration:(Duration(seconds: 5)),
          curve: Curves.easeInSine);
    });
  }
  

 @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index){
   setState(() {
     _currentPage = index;
   });
  }


  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(

        body:Container(
          child: Column(
              children: <Widget>[

          Expanded(
            child: Stack(alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[

              PageView.builder(controller: _pageController,
                onPageChanged: _onPageChanged,
                scrollDirection:Axis.horizontal ,
                itemCount:slideList.length,
                itemBuilder:(ctx, i)=> SlideItem(i),),
                Stack(alignment: AlignmentDirectional.topStart,
                  children: <Widget>[
                  Container(
                    margin:const EdgeInsets.only(bottom: 20),
                    child: Row(mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      for(int i = 0; i<slideList.length; i++)
                        if(i == _currentPage)
                          Dots(true)
                        else
                          Dots(false)
                    ],




                    ),
                  )

                ],)
            ],

            ),
          ),
            Center(child:
            Container(padding: EdgeInsets.only(left:40, right: 40,),
                height: 50.0,child:
                Material(
                  shadowColor: Colors.grey,
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(20.0),
                  elevation: 0.0,
                  child: GestureDetector(
                    child:Center(child: Text("MAKE ORDER",style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey
                    ),
                      textScaleFactor: 1.0,)),



                    onTap: (){Navigator.push(context, MaterialPageRoute(builder:(context){
                      return OrderDetails();
                    }));


                     },

                  ),
                )

            )),
                SizedBox(height: 40,)


    ]
    ),
        ));
  }
}
