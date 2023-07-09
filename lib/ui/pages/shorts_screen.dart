import 'package:fitlife/core/viewmodels/video/video_provider.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../core/models/video/video_model.dart';
import '../../core/viewmodels/connection/connection.dart';
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

  Future<void> refreshHome(BuildContext context) async {
    final videos = VideoProvider.instance(context);

    videos.clearVideos();

    ConnectionProvider.instance(context).setConnection(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isPlaying = false;
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
        body: RefreshIndicator(onRefresh: () async {
          refreshHome(context);
        }, child: Consumer<VideoProvider>(
          builder: (context, value, child) {
            if (value.videos == null) {
              if (!value.onSearch) {
                value.getVideos();
              }

              return Container(
                color: blackColor,
                child: Center(
                    child: LoadingAnimationWidget.flickr(
                        leftDotColor: primaryColor,
                        rightDotColor: primaryDarkColor,
                        size: 50)),
              );
            }

            if (value.videos!.isEmpty) {
              return Container(
                  width: double.infinity,
                  color: blackColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tidak ada data',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            refreshHome(context);
                          },
                          child: Text('Muat ulang'))
                    ],
                  ));
            }

            return PageView.builder(
              onPageChanged: ((value) {
                print("page changed to $value");
                setState(() {
                  snappedPageIndex = value;
                  isPlaying = true;
                });
              }),
              scrollDirection: Axis.vertical,
              itemCount: value.videos!.length,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.white,
                  child: Swiper(
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
                                  // for you title

                                  Text("For you " , style: GoogleFonts.poppins(color: Colors.white , fontSize: 18), ),
                                  VideoTile(
                                    video: value.videos![index],
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
                                          video: value.videos![index],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          : TextDetail(
                              caption: value.videos![index].description ??
                                  'Belum ada deskripsi');
                    },
                    indicatorLayout: PageIndicatorLayout.NONE,
                    autoplay: false,
                    itemCount: 2,
                  ),
                );
              },
            );
          },
        )));
  }
}
