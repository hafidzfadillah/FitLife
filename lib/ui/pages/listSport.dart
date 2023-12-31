import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/pages/pose_ai/pose_ai_screen.dart';
import 'package:fitlife/ui/widgets/CustomAppBar.dart';
import 'package:fitlife/ui/widgets/button.dart';
import 'package:fitlife/ui/widgets/sport_item.dart';
import 'package:fitlife/ui/widgets/top_bar.dart';

class ListSport extends StatefulWidget {
  final Map<String, dynamic> data;

  const ListSport({super.key, required this.data});

  @override
  State<ListSport> createState() => _ListSportState();
}

class _ListSportState extends State<ListSport> {
  late ScrollController _scrollController;
  double lPad = 16.0, bPad = 16.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          lPad = _isSliverAppBarExpanded ? kToolbarHeight : 16;
          bPad = _isSliverAppBarExpanded ? 12 : 16;
        });
      });
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Container(
      //     padding: const EdgeInsets.symmetric(horizontal: 16),
      //     width: double.infinity,
      //     height: 70,
      //     child: FloatingActionButton.extended(
      //       onPressed: () {
      //         Navigator.pushNamed(context, '/action-sport',
      //             arguments: widget.data['exercises']);
      //       },
      //       label: Text("Mulai",
      //           style: normalText.copyWith(
      //               color: Colors.white, fontWeight: FontWeight.w600)),
      //       backgroundColor: primaryColor,
      //     )),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Color(0xffF9D171),
            expandedHeight: 30.h,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding:
                  EdgeInsetsDirectional.only(start: lPad, bottom: bPad),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Hari ${widget.data['day']}",
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: bodySize),
                  ),
                  Text(
                    widget.data['title'],
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: subheaderSize),
                  ),
                ],
              ),
              background: Stack(children: [
                Image.asset(
                  'assets/images/bg_sport.png',
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset('assets/images/skateboard.png' , height: 180, width: 180,)),
              ]),
            ),
          ),
          SliverFillRemaining(
            fillOverscroll: true,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(defMargin),
              // child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // physics: ClampingScrollPhysics(),
                // padding: EdgeInsets.all(defMargin),
                // shrinkWrap: true,
                children: [
                  Text(
                    'Tujuan',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: headerSize),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    widget.data['description'],
                    style: GoogleFonts.poppins(
                        color: Colors.grey, fontSize: subheaderSize),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Latihan',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: headerSize),
                  ),
                  Expanded(
                    child: ListView.builder(
                      // shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.data['exercises'].length,
                      itemBuilder: (c, i) {
                        var item = widget.data['exercises'][i];
                        return SportItem(
                          title: item['title'],
                          durasi: item['durasi'],
                          imgAddress: item['img'],
                          onClick: () {
                            Navigator.pushNamed(context, '/action-sport',
                                arguments: widget.data['exercises']);
                          },
                          onHelp: () {
                            onSelectA(context, 'posenet', item['title']);
                          },
                        );
                      },
                    ),
                  ),
                  RoundedButton(
                      title: 'Mulai',
                      style: GoogleFonts.poppins(),
                      background: Color(0xffF9D171),
                      onClick: () {
                        Navigator.pushNamed(context, '/action-sport',
                            arguments: widget.data['exercises']);
                      },
                      width: double.infinity)
                ],
              ),
              // )
            ),
          )
        ],
      ),
    );
  }

  void onSelectA(BuildContext context, String modelName, String title) async {
    try {
      List<CameraDescription> cameras = await availableCameras();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PoseAiScreen(
            cameras: cameras,
            title: title,
            modelName: modelName,
          ),
        ),
      );
    } on CameraException catch (e) {
      print('Error: $e.code\nError Message: $e.message');
    }
  }
}
