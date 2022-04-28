import 'package:flutter/material.dart';

class listofPlaylists extends StatelessWidget {
  final String title;
  Icon? leadingIcon;
  Color? leadingColor;
  Widget? trailingWidget;
  // Widget? ontapNew;

  listofPlaylists(
      {Key? key,
      required this.title,
      this.leadingIcon,
      this.leadingColor,
      this.trailingWidget,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // onTap: () {
      //   ontapNew != null
      //       ? Navigator.push(
      //           context, MaterialPageRoute(builder: (context) => ontapNew!))
      //       : () {};
      // },
      leading: Container(
        decoration: BoxDecoration(
          color: leadingColor ?? Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
        ),
        height: 40,
        width: 40,
        child: leadingIcon ??
            Icon(
              Icons.audiotrack,
              color: Colors.white,
            ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: trailingWidget ??= Icon(
        Icons.navigate_next,
        color: Colors.white,
      ),
    );
  }
}
