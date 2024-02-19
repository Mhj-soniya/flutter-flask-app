import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/function.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> dataList = ["Pashupatinath Temple", "Boudhanath (Stupa)", "Swayambhunath Stupa", "Tribhuvan Museum","Dakshinkali Temple", "Narayanhiti Palace", "Garden of Dreams", "Kasthamandap", "Patan Durbar Square"];
  String url = '';
  // ignore: prefer_typing_uninitialized_variables
  var data;//to store output returned
  String output = 'Initial Output';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Simple Flask App')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async{
                //serialize the list into a json array
                String jsonData = jsonEncode(dataList);
                String encodedData = Uri.encodeComponent(jsonData);
                url = 'http://127.0.0.1:5000/api?Query=$encodedData';
                print(url);
            }, child: const Text('Submit Json data', style: TextStyle(fontSize: 20)),
          ),
          TextButton(
            onPressed: () async {
            try {
              data = await fetchdata(url);
              print(data); // Print the raw data received from the server
              var decoded = jsonDecode(data);//this decode is not working why??
              setState(() {
                output = decoded['output'];
              });
            } catch (e) {
              // ignore: avoid_print
              print('Error fetching data: $e');
              setState(() {
                output = 'Error fetching data';
              });
          };
          },
          child: const Text(
            'Get Output', 
            style: TextStyle(fontSize: 20),
          )),
          // Text(data),
          Text(output, style: const TextStyle(fontSize: 40, color: Colors.green),
          ) 
          ]),
        ),
      ),
    );
  }
}