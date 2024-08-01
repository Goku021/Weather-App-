import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'api_key.dart';


// Make sure to replace 'your_api_key' with your actual API key

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String cityName = "London";
  double temp = 0;
   String weatherType ='Clouds';
  late double humidity;
  late double pressure;
  late double windSpeed;
  Future<Map<String, dynamic>> getData() async {
    try {
      final response = await http.get(
          Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$apiKey"));
      final data = jsonDecode(response.body);
      if (data['cod'] != '200') {
        throw "An unexpected error occurs";
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getData().then((data) {
      setState(() {
        temp = data['list'][0]['main']['temp'];
        windSpeed = data['list'][0]['wind']['speed'];
        humidity = data['list'][0]['main']['humidity'];
        pressure =  data['list'][0]['main']['pressure'];
        weatherType = data['list'][0]['weather'][0]['main'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child:  CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 9),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  "$temp F",
                                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                                ),
                              ),
                               Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child:weatherType == "Rain" || weatherType =="Clouds" ?const Icon(
                                  Icons.cloud,
                                  size: 100,
                                ): const Icon(Icons.sunny),
                              ),
                               Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  weatherType,
                                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Hourly Forecast",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                ),
                // const SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //
                //       HourlyForecast(icon: Icons.sunny, temp: '55.0', time: '14:00'),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final time = DateTime.parse(snapshot.data!['list'][index + 1]['dt_txt']);
                      final parsedTime = DateFormat.jm().format(time);
                      return HourlyForecast(
                        icon: Icons.cloud,
                        temp: "${snapshot.data!['list'][index + 1]['main']['temp']} °C",
                        time: parsedTime,
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Additional Information",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                ),
                 Row(
                  children: [
                    AdditionalInformation(text: "Humidity", icon: const Icon(Icons.water_drop_rounded), value: "$humidity"),
                    AdditionalInformation(text: "Wind Speed", icon: const Icon(Icons.air), value: '$windSpeed'),
                    AdditionalInformation(text: "Pressure", icon:const Icon(Icons.beach_access), value: '$pressure')
                  ],
                )
              ],
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}


class HourlyForecast extends StatelessWidget{
  final String time;
  final IconData icon;
  final String temp;
  const HourlyForecast({super.key, required this.icon, required this.time, required this.temp});

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: 120,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(14)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(time, style: const TextStyle(fontWeight: FontWeight.bold,),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Icon(icon, size: 20,),
            ),
            Padding(padding:const EdgeInsets.symmetric(vertical: 10.0), child: Text(temp,overflow: TextOverflow.ellipsis,),)
          ],
        ),
      ),
    );
  }
}

class AdditionalInformation extends StatelessWidget{

  final String text;
  final String  value;
  final Icon icon;
  const AdditionalInformation({super.key, required this.text, required this.icon, required this.value});
  @override
  Widget build(BuildContext context){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: icon,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(text,),
              ),
              Padding(padding:const EdgeInsets.symmetric(vertical: 4.0), child: Text(value),)
            ],
          ),
        ),

      ],
    );
  }
}
