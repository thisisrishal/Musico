import 'package:flutter/material.dart';
import 'package:musico_scratch/screens/MyHome.dart';

void main() {
  runApp(const Musico());
}

class Musico extends StatelessWidget {
  const Musico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Musico',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply( 
              bodyColor: Color.fromARGB(255, 241, 241, 242),
              displayColor: Color.fromARGB(255, 233, 233, 238),
            ),
      ),
      home: const MyHome(),
    );
  }
}
