// * media_kit_libs_video
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class BnVideoPlayer extends StatefulWidget {
  const BnVideoPlayer(
      {super.key, required this.videoUrl, required this.thumbnailUrl});
  final String videoUrl;
  final String thumbnailUrl;
  @override
  State<BnVideoPlayer> createState() => BnVideoPlayerState();
}

class BnVideoPlayerState extends State<BnVideoPlayer> {
  late final player = Player();
  late final controller = VideoController(
    player,
  );

  @override
  void initState() {
    super.initState();
    player.open(
        Media(
          widget.videoUrl,
        ),
        play: true);
    player.setVolume(0);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
    Logger().w("[VIDEO DISPOSED]");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 9.0 / 16.0,
        // Use [Video] widget to display video output.
        child: Video(
          controller: controller,
        ),
      ),
    );
  }
}
