import 'package:fitlife/ui/home/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../widgets/text_detail.dart';
import '../widgets/video_detail.dart';
import '../widgets/video_tile.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({Key? key, required this.currentPageIndex})
      : super(key: key);
  final int currentPageIndex;

  @override
  State<ShortsScreen> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  int snappedPageIndex = 0;
  bool isPlaying = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: RefreshIndicator(
          onRefresh: () async {},
          child: PageView.builder(
            onPageChanged: ((value) {
              print("page changed to $value");
              setState(() {
                snappedPageIndex = value;
                isPlaying = true;
              });
            }),
            scrollDirection: Axis.vertical,
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return Swiper(
                itemBuilder: (context, index2) {
                  return index2 == 0
                      ? GestureDetector(
                          onDoubleTap: () {
                            setState(() {
                              isPlaying = !isPlaying;
                            });
                          },
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              VideoTile(
                                video: videos[index],
                                snappedPageIndex: snappedPageIndex,
                                currentIndex: index,
                                currentPage: widget.currentPageIndex,
                                isPlaying: isPlaying,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: VideoDetail(
                                      video: videos[index],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      : TextDetail(caption: videos[index].caption);
                },
                indicatorLayout: PageIndicatorLayout.NONE,
                autoplay: false,
                itemCount: 2,
              );
            },
          ),
        ));
  }

  User user1 = User(
      username: 'hfzfadillah', imgUrl: 'https://picsum.photos/id/1062/400/400');

  final List<Video> videos = [
    Video(
        videoUrl: 'tiktok_data1.mp4',
        caption:
            'Part 1 | your habits become your lifestyle your habits become your lifestyle your habits become your lifestyle #motivation #healthyhabits #healthyliving #SelfCare #betterme #selflove #motivation #healthyhabits #healthyliving #SelfCare #betterme #selflove #motivation #healthyhabits #healthyliving #SelfCare #betterme #selflove'),
    Video(
        videoUrl: 'tiktok_data1.mp4',
        caption:
            'Part 2 | your habits become your lifestyle #motivation #healthyhabits #healthyliving #SelfCare #betterme #selflove'),
    Video(
        videoUrl: 'tiktok_data1.mp4',
        caption:
            'Part 3 | your habits become your lifestyle #motivation #healthyhabits #healthyliving #SelfCare #betterme #selflove'),
    Video(
        videoUrl: 'tiktok_data1.mp4',
        caption:
            'Part 4 | your habits become your lifestyle #motivation #healthyhabits #healthyliving #SelfCare #betterme #selflove'),
    Video(
        videoUrl: 'tiktok_data1.mp4',
        caption:
            'Part 5 | your habits become your lifestyle #motivation #healthyhabits #healthyliving #SelfCare #betterme #selflove'),
  ];
}

class Video {
  final String videoUrl;
  final String caption;

  Video({required this.videoUrl, required this.caption});
}

class User {
  final String username;
  final String imgUrl;

  User({required this.username, required this.imgUrl});
}
