import 'package:flutter/material.dart';
import 'package:musico_scratch/custom/customTexts.dart';

class ScreenArtists extends StatelessWidget {
  const ScreenArtists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: normalText('Kadhar'),
          trailing: Icon(
            Icons.navigate_next,
            color: Colors.white,
          ),
        ),
        ListTile(
          title: normalText('Ed Sheeran'),
          trailing: Icon(
            Icons.navigate_next,
            color: Colors.white,
          ),
        ),
        ListTile(
          title: normalText('Unknown'),
          trailing: Icon(
            Icons.navigate_next,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
