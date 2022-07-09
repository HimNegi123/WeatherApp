import 'package:flutter/material.dart';

import 'package:weatherapp/weatherAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var value = 'mumbai';
Future<Model> fechModel({String name = 'delhi'}) async {
  final response = await http.get(Uri.parse(
      'http://api.weatherapi.com/v1/current.json?key=f62ac7f569f04dac896153442211008&q=$name'));
  if (response.statusCode != null) {
    return Model.fromJson(jsonDecode(response.body));
  } else {
                                                                                       //Data Fetching from api;
    throw Exception('VALUE NOT PROVIEDE BY SERVER');
  }
}

void main() {
  runApp(MaterialApp(
    home: Connector(),
    debugShowCheckedModeBanner: false,
  ));
}

class Connector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainUi();
  }
}

class MainUi extends State<Connector> {
  late dynamic Apidata;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final control = TextEditingController();
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 47, 46, 46),
        body: FutureBuilder<Model>(
            future: fechModel(name: value),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data!.name);
                return Stack(
                  children: [
                    Container(
                      height: 500,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60),
                              bottomRight: Radius.circular(60))),
                      child: Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(top: 40, left: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 20,
                                  ),
                                  Text(
                                    "${snapshot.data!.name}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Text(
                                    " ${snapshot.data!.temp} \u2103",
                                    style: TextStyle(
                                        fontSize: 100,
                                        fontWeight: FontWeight.bold),
                                  ) // temperater meter
                                ],
                              )),
                          if (snapshot.data!.temp! < 5.0) ...[
                            Image.asset(
                              'image/winter.gif',
                              height: 300,
                              width: double.infinity,
                            )
                          ],
                          if (snapshot.data!.temp! < 27.0 &&
                              snapshot.data!.temp! >= 5.0) ...[
                            Image.asset(
                              'image/rainy.gif',
                              height: 300,
                              width: double.infinity,
                            )
                          ],
                          if (snapshot.data!.temp! >= 27.0) ...[
                            Image.asset(
                              'image/summer.gif',
                              height: 300,
                              width: double.infinity,
                            )
                          ]
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 520, left: 23),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('image/humidity.webp')),
                              SizedBox(width: 5),
                              Text(
                                "${snapshot.data!.humidity}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(
                                width: 105,
                              ),
                              Text(
                                "${snapshot.data!.windSpeed}" "kpm",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(width: 10),
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('image/wind.jpg')),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: const [
                              Text(
                                "HUMIDITY",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 200),
                              Text(
                                "WIND SPEED",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(height: 40),
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('image/pressure.jpg')),
                              SizedBox(width: 5),
                              Text(
                                "${snapshot.data!.pressure}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(
                                width: 105,
                              ),
                              Text(
                                "INDIA",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(width: 10),
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('image/india.jpg')),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: const [
                              Text(
                                "PRESSURE",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 210),
                              Text(
                                "COUNTRY",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            height: 50,
                            width: 455,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 204, 202, 202),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Center(
                                child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: AlertDialog(
                                          content: TextField(
                                            controller: control,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText:
                                                    "         SEARCH THE CITY",
                                                hintStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 14, 14, 15),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          actions: [
                                            Center(
                                              child: OutlinedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      value = control.text;
                                                      if (value == null) {}
                                                    });

                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "SUBMIT",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  )),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Text(
                                "SEARCH",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            )),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Image.asset(
                  'image/loading.gif',
                  height: 100,
                  width: 100,
                ),
              );
            }));
  }
}
