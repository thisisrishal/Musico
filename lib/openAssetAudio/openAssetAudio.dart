import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpenPlayer {
  List<Audio> fullSongs;
  int index;
  bool? notify;
  Future<bool?> setNotifyValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    notify = preferences.getBool('notification');
    return notify;
  }

  OpenPlayer({required this.fullSongs, required this.index});

  openAssetPlayer({List<Audio>? songs, required int index}) async {
    notify = await setNotifyValue();
    assetsAudioPlayer.open(
      Playlist(audios: songs, startIndex: index),
      showNotification: notify == null || notify == true ? true : false,
      notificationSettings: const NotificationSettings(
        stopEnabled: false,
      ),
      autoStart: true,
      loopMode: LoopMode.playlist,
      headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
      playInBackground: PlayInBackground.enabled,
    );
  }
}

final assetsAudioPlayer = AssetsAudioPlayer.withId("0");

// Take the list and take playing  audio with that list
// and return the audio that in list
Audio find(List<Audio> source, String fromPath) {
  return source.firstWhere((element) => element.path == fromPath);
}
