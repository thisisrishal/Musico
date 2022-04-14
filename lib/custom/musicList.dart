// import 'package:flutter/material.dart';
// import 'package:musico_scratch/screens/NowPlaying.dart';
// import 'package:musico_scratch/screens/NowPlaying2.dart';

// class MusicList extends StatelessWidget {
//   String imageurl;
//   String header;
//   String subhead;
//   Widget? icon1;
//   // Widget? icon2;
//   int index;
//   // Color? background = Color.fromARGB(247, 194, 9, 9);
//   // Widget playIcon = IconButton(
//   //     onPressed: () {},
//   //     icon: const Icon(
//   //       Icons.play_arrow,
//   //       color: Colors.white,
//   //     ));
//   // Widget moreButton = IconButton(
//   //     onPressed: () {},
//   //     icon: const Icon(
//   //       Icons.more_horiz_rounded,
//   //       color: Colors.white,
//   //     ));

//   MusicList({
//     Key? key,
//     required this.imageurl,
//     required this.header,
//     required this.subhead,
//     this.icon1,
//     // this.icon2,
//     // this.background,
//     required this.index,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Container(
//               alignment: Alignment.topCenter,
//               height: MediaQuery.of(context).size.height * 0.09,
//               width: MediaQuery.of(context).size.width * 0.90,
//               decoration: BoxDecoration(
//                   // color: background,
//                   borderRadius: BorderRadius.all(Radius.circular(20))),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: ((context) {
//                         return NowPlaying2(
//                             index: index,
//                             imageurl: imageurl,
//                             header: header,
//                             subhead: subhead);
//                       }),
//                     ),
//                   );
//                   // openPlayer(audios, index);
//                 },
//                 child: ListView(
//                   // physics: NeverScrollableScrollPhysics(),
//                   children: [
//                     Material(
//                       borderRadius: BorderRadius.all(Radius.circular(20)),
//                       // color: background,
//                       child: Center(
//                         child: ListTile(
//                           leading: Container(
//                             height: MediaQuery.of(context).size.height * 0.06,
//                             width: MediaQuery.of(context).size.width * 0.10,
//                             child: Image.asset(
//                               imageurl,
//                               height: MediaQuery.of(context).size.height * 0.06,
//                               width: MediaQuery.of(context).size.width * 0.09,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           title: Text(
//                             header,
//                             //style: TextStyle(color: Colors.white),
//                           ),
//                           subtitle: Text(
//                             subhead,
//                             //style: TextStyle(color: Colors.white),
//                           ),
//                           trailing: icon1, iconColor: Colors.white,
//                           // Row(
//                           //   crossAxisAlignment: CrossAxisAlignment.center,
//                           //   mainAxisSize: MainAxisSize.min,
//                           //   children: [
//                           //     // Container(child: icon1 = playIcon),
//                           //     Container(child: icon1)
//                           //   ],
//                           // ),

//                           tileColor: Colors.black,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
