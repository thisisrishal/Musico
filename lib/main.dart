import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musico_scratch/database/dbSongs.dart';
import 'package:musico_scratch/screens/MyHome.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musico_scratch/screens/ScreenSongHome.dart';
import 'package:musico_scratch/screens/splashScree.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(dbSongsAdapter());
  await Hive.openBox<List>(boxname);
  await Hive.openBox<List>(boxname1);
  runApp(const Musico());
  final box = MusicBox.getInstance();
  List<dynamic> favKeys = box.keys.toList();
  if (!favKeys.contains("favourites")) {
    List<dynamic> likedSongs = [];
    await box.put("favourites", likedSongs);
    
  }

  // if (!favKeys.contains("artists")) {
  //   List<dynamic> allArtists = [];
  //   await box.put("artists", allArtists);
  // }
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
      home: const SplashScreen(),
    );
  }
}
