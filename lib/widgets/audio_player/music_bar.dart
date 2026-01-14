// import 'package:flutter/material.dart';
// import 'package:focus_up/style/color.dart';
// import 'package:just_audio/just_audio.dart';

// class MusicBar extends StatelessWidget {
//   const MusicBar({super.key, required this.audioPlayer});

//   final AudioPlayer audioPlayer;

//   Stream<int> getSecondsFromCurrentMinute() async* {
//     final now = DateTime.now();
//     final seconds = now.second;
//     yield seconds;
//     await Future.delayed(Duration(seconds: 1 - seconds));
//     yield* getSecondsFromCurrentMinute();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FractionallySizedBox(
//       heightFactor: .15,
//       widthFactor: 1,
//       child: Container(
//         color: secondaryColor,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Song cover
//             Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             SizedBox(width: 15),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "title-Audio",
//                   style: Theme.of(context).textTheme.headlineSmall,
//                 ),
//                 Text(
//                   "Unknown artist",
//                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     color: Colors.grey.withOpacity(.6),
//                   ),
//                 ),
//               ],
//             ),

//             // Padding between first 2 columns and Icons
//             Expanded(child: SizedBox.expand()),

//             StreamBuilder<PlayerState>(
//               stream: audioPlayer.playerStateStream,
//               builder: (context, snapshot) {
//                 return SizedBox(
//                   width: 40,
//                   height: 40,
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         top: 0,
//                         left: 0,
//                         child: SizedBox(
//                           width: 35,
//                           height: 35,
//                           child: IconButton(
//                             icon:
//                                 audioPlayer.playing != true
//                                     ? Icon(
//                                       Icons.play_arrow,
//                                       color: primaryColor,
//                                     )
//                                     : Icon(Icons.pause, color: primaryColor),
//                             onPressed: () {
//                               audioPlayer.playing != true
//                                   ? audioPlayer.play()
//                                   : audioPlayer.pause();
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),

//             SizedBox(width: 16),
//           ],
//         ),
//       ),
//     );
//   }
// }
