import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musico_scratch/database/dbSongs.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musico_scratch/main_page/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(dbSongsAdapter());
  await Hive.openBox<List>(boxname);
  await Hive.openBox<List>(boxname1);
  ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: Colors.black),
    primarySwatch: Colors.blue,
    backgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
      ),
    ),
  );

  

  final box = MusicBox.getInstance();

  List<dynamic> favKeys = box.keys.toList();
  if (!favKeys.contains("favourites")) {
    List<dynamic> likedSongs = [];
    await box.put("favourites", likedSongs);
  }
  
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
        fontFamily: 'futura',
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Color.fromARGB(255, 241, 241, 242),
              displayColor: Colors.grey[500],
            ),
      ),
      home: const SplashScreen(),
    );
  }
}
