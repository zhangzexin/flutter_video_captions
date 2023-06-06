// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/provider/player_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class PlayerController extends ConsumerStatefulWidget {
  VideoPlayerController _videoPlayerController;

  PlayerController({super.key, required videoPlayerController}) : _videoPlayerController = videoPlayerController;

  @override
  ConsumerState<PlayerController> createState() => _PlayerControllerState();
}

class _PlayerControllerState extends ConsumerState<PlayerController> {
  @override
  Widget build(
    BuildContext context,
  ) {
    var notifier = ref.watch(playerUiControllerProvider);
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: VideoProgressIndicator(
            widget._videoPlayerController,
            allowScrubbing: true,
            colors: const VideoProgressColors(
                backgroundColor: Colors.transparent,
                bufferedColor: Colors.transparent,
                playedColor: Colors.blueAccent),
          ),
        ),
        Center(
          child: IconButton(
            color: Colors.black.withOpacity(0.5),
            icon: Icon(notifier.isPlay
                ? Icons.play_circle_fill_sharp
                : Icons.pause_circle_filled_sharp),
            iconSize: 100,
            onPressed: () {
              if (notifier.isPlay) {
                widget._videoPlayerController.pause();
                ref.read(playerUiControllerProvider).isPlay = false;
              } else {
                widget._videoPlayerController.play();
                ref.read(playerUiControllerProvider).isPlay = true;
              }
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
