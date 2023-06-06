import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/player_controller.dart';
import 'package:flutter_application_1/app/provider/player_status.dart';
import 'package:flutter_application_1/app/srt_info.dart';
import 'package:flutter_application_1/app/widgets/user_avatar_animation.dart';
import 'package:flutter_application_1/app/widgets/words_widgets.dart';
import 'package:flutter_application_1/app/words.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends ConsumerStatefulWidget {
  const VideoPage({super.key});

  @override
  ConsumerState<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends ConsumerState<VideoPage> {
  var url_play =
      "https://video-cdn.100935.com/video/oztXqE.mp4?auth_key=1696044909-0-0-7f2f2c255b9ff52e3cb740c2bf0b00e5";
  late VideoPlayerController _videoPlayerController;
  int play_time = -1;
  List<SrtInfo> srtlist = [];
  SrtInfo? showSrtInfo = null;
  Words? cur_words = null;
  var curKey = "";

  @override
  Widget build(BuildContext context) {
    var showTextSrt = showSrtInfo != null ? showSrtInfo!.getSrtText() : null;
    var isShowUi = ref.watch(playerUiControllerProvider).isShowUi;
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        children: [
          Center(
            child: _videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController))
                : Container(),
          ),
          WordsWidgets(
              showTextSrt: showTextSrt,
              cur_words: cur_words),
          FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 1,
            child: GestureDetector(
              onTap: () {
                onClickPlayerUi();
              },
            ),
          ),
          if (isShowUi)
            PlayerController(videoPlayerController: _videoPlayerController),
          const Align(
            alignment: Alignment.topRight,
            child: UserAvatarAnimation(),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("首页" , style: TextStyle(fontSize: 20, color: Colors.yellow),),
                SizedBox(width: 30,),
                Text("词库", style: TextStyle( fontSize: 20, color: Color(0xFF404040),),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    srtlist.add(SrtInfo(
        1,
        7,
        "Five seven, well ok five six and a half is not enough to teach happiness?",
        "happiness",
        "happiness",
        "英/ˈhapēnəs/  美/ˈhapēnəs/",
        "n.幸福;愉快;(用语等的)适当;幸运"));
    srtlist.add(SrtInfo(
        11,
        12,
        "Just not enough.",
        "enough",
        "enough",
        "英/ɪˈnʌf/  美/ɪˈnʌf/",
        "det.足够地;(用于复数或不可数名词前)足够的，充足的，充分的\npron.足够;充足;充分\nadv.足够地;充分地;充足地;相当;尚;十分;很\nn.足够 int.够了 adj.充足的"));
    srtlist.add(SrtInfo(
        16,
        19,
        "because we have got enough people on the panel today!",
        "today",
        "today",
        "英/təˈdeɪ/  美/təˈdeɪ/",
        "n.今天;今日;现在;当今;当代\nadv.现在;当今;在今天;在今日;当代"));
    loadNetworkPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);

  }

  void loadNetworkPlayer() async {
    // _videoPlayerController = VideoPlayerController.network(url_play);
    _videoPlayerController = VideoPlayerController.asset('assets/video/video.mp4');
    _videoPlayerController.setLooping(true);
    _videoPlayerController.addListener(() async {
      var isPlaying = _videoPlayerController.value.isPlaying;
      ref.read(playerUiControllerProvider).isPlay = isPlaying;
      if (isPlaying) {
        play_time = _videoPlayerController.value.position.inSeconds;
        showSrtInfo = await findSrtData(play_time);
        if (showSrtInfo != null) {
          cur_words = showSrtInfo;
        }
        setState(() {});
      }
    });
    if (!_videoPlayerController.value.isInitialized) {
      await _videoPlayerController.initialize().then((value) {
        setState(() {});
        _videoPlayerController.play();
      });
    }
  }

  Future<SrtInfo?> findSrtData(int play_time) async {
    for (var i = 0; i < srtlist.length; i++) {
      if (srtlist[i].isMatch(play_time)) {
        return srtlist[i];
      }
    }
    return null;
  }

  void play() {
    setState(() {
      _videoPlayerController.play();
    });
  }

  void pause() {
    setState(() {
      _videoPlayerController.pause();
    });
  }

  void onClickPlayerUi() {
    ref.read(playerUiControllerProvider).isShowUi =
        !ref.read(playerUiControllerProvider).isShowUi;
    setState(() {});
  }
}


