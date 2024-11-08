import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Result extends StatefulWidget {
  final String place;

  const Result({ Key? key, required this.place }) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Future<Map<String, dynamic>> getDataFromAPI() async {
    final response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=bogor&appid=3d51200ceeda7ad57f3cf2b72a82c4e5&units=metric"));

    if (response.statusCode == 200){
      final data = json.decode(response.body);

      return data;
    }else{
      throw Exception("ERROR : API gagal diakses");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Hasil Tracking"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          leading: GestureDetector(
            onTap:() {
              Navigator.pop(context);
            } ,
            child: const Icon(Icons.arrow_back),
          )
        ),

        body: Container(
          padding: const EdgeInsets.only(left: 70, right: 70),
          child: FutureBuilder(
            future: getDataFromAPI(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator();
              }

              if (snapshot.hasData) {
                final data = snapshot.data!;

                print(data.runtimeType);
                return Text("cikk");
                // return Text(data["weather"][0]["main"]);
              } else {
                return const  Text("Tempat tidak ditemukan!");
              }
            }
          )
        )
      ),
    );
  }
}