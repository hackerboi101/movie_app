import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPlayerPage extends StatelessWidget {
  final String videoId;

  const TrailerPlayerPage({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    final controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.greenAccent,
        ),
      ),
    );
  }
}
