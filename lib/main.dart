import 'package:flutter/material.dart';
import 'package:weather_app/home_page.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Weather App",
      darkTheme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Weather App", style: TextStyle(color: Colors.white),
        ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){}, icon:const Icon(Icons.refresh),
            ),
          ],
        ),
        body: const SingleChildScrollView(child:  HomePage()),
      ),
    );
  }
}

