import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musico_scratch/database/dbSongs.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musico_scratch/logic/nowPlaying/nowplaying_bloc.dart';

import 'logic/Icon Bloc/icon_bloc_bloc.dart';
import 'logic/search_bloc/search_bloc.dart';
import 'logic/switch_state/switch_state_cubit.dart';
import 'main_page/SplashScreen.dart';

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
}

class Musico extends StatelessWidget {
  const Musico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NowplayingBloc()),
          BlocProvider(create: (context) => SearchBloc()),
          BlocProvider(create: (context) => SwitchstateCubit()),
          BlocProvider(create: (context) => IconBlocBloc())


        
          
        ],
        child: MaterialApp(
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
        ));
  }
}
