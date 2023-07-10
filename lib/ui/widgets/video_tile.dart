import 'package:fitlife/ui/home/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:video_player/video_player.dart';

import '../../core/models/video/video_model.dart';
import '../pages/shorts_screen.dart';

class VideoTile extends StatefulWidget {
   VideoTile(
      {Key? key,
      required this.video,
      required this.snappedPageIndex,
      required this.currentIndex,
      required this.currentPage, this.isPlaying = true})
      : super(key: key);
  final Video video;
  final int snappedPageIndex;
  final int currentIndex;
  final int currentPage;
  bool isPlaying;

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  late VideoPlayerController _videoPlayerController;
  late Future _initVideoPlayer;

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.network('${widget.video.videoUrl}');
    _initVideoPlayer = _videoPlayerController.initialize();
    _videoPlayerController.setLooping(true);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void pausePlay() {
    widget.isPlaying ? _videoPlayerController.pause() : _videoPlayerController.play();
    print('tap ${widget.isPlaying}');
    setState(() {
      widget.isPlaying = !widget.isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    (widget.snappedPageIndex == widget.currentIndex) &&
            (widget.currentPage == 1) &&
            widget.isPlaying
        ? _videoPlayerController.play()
        : _videoPlayerController.pause();
    return Container(
      child: FutureBuilder(
        future: _initVideoPlayer,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
                children: [
                  VideoPlayer(_videoPlayerController),
                  Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white.withOpacity(widget.isPlaying ? 0 : 0.8),
                      size: 60,
                    ),
                  )
                ],
              );
          }
          
          return Container(
              color: blackColor,
              child: Center(
                  child: LoadingAnimationWidget.flickr(
                      leftDotColor: primaryColor,
                      rightDotColor: primaryDarkColor,
                      size: 50)),
            );
        },
      ),
    );
  }
}
