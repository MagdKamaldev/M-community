// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:udemy_course/modules/bmi/bmi_result.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);



  @override
  State<BmiScreen> createState() => _BmiCalcState();
}

class _BmiCalcState extends State<BmiScreen> {
  bool isMale = true;
  double height = 120.0;
  int weight = 40;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bmi App"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                          setState(() {
                              isMale = true;
                          });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: isMale ? Colors.blue : Colors.grey[400],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                              image: AssetImage("assets/images/male.png"),
                              height: 90.0,
                              width: 90.0,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Male",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isMale = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: !isMale? Colors.blue:Colors.grey[400],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                              image: AssetImage("assets/images/female.png"),
                              height: 90.0,
                              width: 90.0,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "FEMALE",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[400]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Height",
                      style:  TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisAlignment: MainAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          height.round().toString(),
                          style: const TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Text(
                          "cm",
                          style:  TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    Slider(
                        value: height,
                        max: 220.0,
                        min: 80,
                        onChanged: (value){
                          setState(() {
                            height=value;
                          });
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),color: Colors.grey[400]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Age",
                            style: const TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            age.toString(),
                            style: const TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    age--;
                                  });
                                },
                                heroTag: "Age-",
                                mini: true,
                                child:const Icon(Icons.remove) ,
                              ),
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    age ++;
                                  });
                                },
                                heroTag: "age+",
                                mini: true,
                                child:const Icon(Icons.add) ,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),color: Colors.grey[400]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         const Text(
                            "Weight",
                            style:  TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            weight.toString(),
                            style: const TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    weight--;
                                  });
                                },
                                heroTag: "weight-",
                                mini: true,
                                child:const Icon(Icons.remove) ,
                              ),
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    weight++;
                                  });
                                },
                                heroTag: "weight+",
                                mini: true,
                                child:const Icon(Icons.add) ,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            child: MaterialButton(
              height: 50.0,
              onPressed: (){
                var result = weight /pow(height/100, 2);
                Navigator.push(context, MaterialPageRoute(builder:(context)=>BmiResult(age: age,isMale: isMale,result: result,),));
              },
              child: const Text("Calculate",style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}
