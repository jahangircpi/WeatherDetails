import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  var textcontroller = TextEditingController();
  var totalcelsius;
  var wholedetails;
  String defultcity = "London";
  weatherFetching({textcontroller}) async {
    var link =
        "https://api.openweathermap.org/data/2.5/weather?q=${textcontroller ?? defultcity}&appid=ad3eb9182b3d7d19001323ff65df27ee";
    var response = await http.get(
      Uri.parse(link),
    );
    var data = jsonDecode(response.body);
    wholedetails = data;
    var kk = 273.15;
    var kelvinintocelcius = data["main"]["temp"] - kk;
    totalcelsius = kelvinintocelcius;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    weatherFetching();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: totalcelsius == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Image.network(
                        "https://images.unsplash.com/photo-1611928482473-7b27d24eab80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: SizedBox()),
                        Text(
                          wholedetails == null ? "" : wholedetails["name"],
                          style: TextStyle(
                              fontSize: 50, color: Colors.amberAccent),
                        ),
                        Text(
                          DateTime.now().toString().split(" ")[0],
                          style: TextStyle(
                              color: Colors.amberAccent, fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          child: Container(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  totalcelsius == null
                                      ? ""
                                      : totalcelsius.toStringAsFixed(0) ??
                                          0.toString(),
                                  style: TextStyle(
                                      color: Colors.amberAccent, fontSize: 80),
                                ),
                                Container(
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "°",
                                        style: TextStyle(
                                            fontSize: 50,
                                            color: Colors.amberAccent),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "C",
                                        style: TextStyle(
                                            fontSize: 35,
                                            color: Colors.amberAccent),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          wholedetails == null
                              ? ""
                              : wholedetails["weather"][0]["main"],
                          style: TextStyle(
                              fontSize: 30, color: Colors.amberAccent),
                        ),
                        Expanded(child: SizedBox()),
                        InkWell(
                            onTap: () {
                              Get.bottomSheet(Container(
                                height: 200,
                                color: Colors.black,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: textcontroller,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white))),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (textcontroller.text.length != 0) {
                                          Get.back();
                                          weatherFetching(
                                              textcontroller:
                                                  textcontroller.text.length ==
                                                          0
                                                      ? defultcity
                                                      : textcontroller.text);
                                        }
                                        print(totalcelsius);

                                        setState(() {});
                                      },
                                      child: Text(
                                        'Enter',
                                      ),
                                      style: TextButton.styleFrom(
                                          primary: Colors.purple,
                                          backgroundColor: Colors.amber,
                                          textStyle: TextStyle(
                                              fontSize: 24,
                                              fontStyle: FontStyle.italic)),
                                    ),
                                  ],
                                ),
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Type another city",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                              ),
                            )),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ],
                )),
    );
  }
}
