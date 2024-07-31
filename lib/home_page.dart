import 'dart:ui';
import 'package:flutter/material.dart';



class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){

    return  Padding(padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      SizedBox(
      width: double.infinity,
      child:  Card(
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child:   ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 6, sigmaY: 9),
              child: const Padding(padding: EdgeInsets.all(16), child:Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
                child:Text("300 F", style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Icon(Icons.cloud,size: 100
                ,)
                ,),
              Padding(padding: EdgeInsets.symmetric(vertical: 10),
                child:Text("Rain",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),
                ),
              )

            ],
          ),
          ),
          ),
        )

      ),
    ),
      const Padding(padding: EdgeInsets.all(16),
         child: Text("Weather Forecast", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)
           ,)
        ,),
       const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              HourlyForecast(icon: Icons.cloud,temp: "78.9", time :'13:00'),
              HourlyForecast(icon: Icons.sunny, temp: '55.0', time: '14:00',),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.all(15),
          child: Text("Additional Information", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)
            ,)
          ,),
        const Row(
          children: [
             AdditionalInformation(text: "Humidity", icon: Icon(Icons.water_drop_rounded), value: "78.9"),
             AdditionalInformation(text: "Wind Speed", icon:  Icon(Icons.air), value: '7.67'),
            AdditionalInformation(text: "Pressure", icon: Icon(Icons.beach_access), value: '19.06')
          ],
        )
    ],
    ),
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
            Padding(padding:const EdgeInsets.symmetric(vertical: 10.0), child: Text(temp),)
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
                child: Text(text),
              ),
              Padding(padding:const EdgeInsets.symmetric(vertical: 4.0), child: Text(value),)
            ],
          ),
        ),

      ],
    );
  }
}