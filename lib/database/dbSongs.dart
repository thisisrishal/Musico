
import 'package:hive/hive.dart';
part 'dbSongs.g.dart';


@HiveType(typeId: 0)
class dbSongs extends HiveObject {  // hiveObject for save & delete

  dbSongs({
    required this.title,
    required this.artist,
    required this.uri,
    required this.duration,
    required this.id,
  });



  @HiveField(0)
  String? title;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  String? uri;
  @HiveField(3)
  int? duration;
  @HiveField(4)
  int? id;
  
}


String boxname = "songs";
String boxname1 = "rrr";


class MusicBox {
  static Box<List>? _box;

  static Box<List> getInstance() {
    return _box ??= Hive.box(boxname);
  }
}


class MusicBox1 {
  static Box<List>? _box1;

  static Box<List> getInstance() {
    return _box1 ??= Hive.box(boxname1);
  }
}
