import 'dart:ffi';

import 'package:fitlife/ui/home/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  double height = 0;
  bool hide = false;

  @override
  void initState() {
    super.initState();
    // Memulai animasi setelah 1 detik
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        height = 107;
        hide = true; // Tampilkan
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Background dengan efek overlay
            Positioned.fill(
              child: Opacity(
                opacity: 0.6,
                child: Image.asset(
                  'assets/images/5403942.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Stack(
                      children: [
                        // position center
                        Positioned(
                            top: 20,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Stack(
                                children: <Widget>[
                                  // Stroked text as border.
                                  Text(
                                    'Oasis Kehidupan',
                                    style: GoogleFonts.bungee(
                                      fontSize: 18,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 1
                                        ..color = Color(0xff18B279),
                                    ),
                                  ),
                                  // Solid text as fill.
                                  Text(
                                    'Oasis Kehidupan',
                                    style: GoogleFonts.bungee(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ],
                              ),
                            )),

                        // Gambar juara top 3
                        Positioned(
                          bottom: 0,
                          right: 145,
                          child: Column(
                            children: [
                              Stack(
                                children: <Widget>[
                                  // Stroked text as border.
                                  Text(
                                    'Rifki',
                                    style: GoogleFonts.bungee(
                                      fontSize: 18,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 1
                                        ..color = Color(0xff18B279),
                                    ),
                                  ),
                                  // Solid text as fill.
                                  Text(
                                    'Rifki',
                                    style: GoogleFonts.bungee(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ],
                              ),
                              Image.asset(
                                'assets/images/avatar_1.png',
                                width: 65,
                                height: 65,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 69,
                                height: 133,
                                decoration: BoxDecoration(
                                    color: Color(0xffFFCD00),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(11),
                                      topRight: Radius.circular(11),
                                    )),
                                child: Center(
                                  child: Text(
                                    '1',
                                    style: GoogleFonts.poppins(
                                        fontSize: 34,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 66,
                          child: Column(
                            children: [
                              hide
                                  ? Stack(
                                      children: <Widget>[
                                        // Stroked text as border.
                                        AnimatedContainer(
                                          duration: Duration(
                                              seconds: 1), // Durasi animasi
                                          curve:
                                              Curves.easeInOut, // Kurva animasi
                                          child: Text(
                                            'Rifki',
                                            style: GoogleFonts.bungee(
                                              fontSize: 18,
                                              foreground: Paint()
                                                ..style = PaintingStyle.stroke
                                                ..strokeWidth = 1
                                                ..color = Color(0xff18B279),
                                            ),
                                          ),
                                        ),
                                        // Solid text as fill.
                                        Text(
                                          'Rifki',
                                          style: GoogleFonts.bungee(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                              hide
                                  ? Image.asset(
                                      'assets/images/avatar_2.png',
                                      width: 65,
                                      height: 65,
                                      fit: BoxFit.cover,
                                    )
                                  : SizedBox(),
                              SizedBox(height: 10),
                              AnimatedContainer(
                                duration:
                                    Duration(seconds: 1), // Durasi animasi
                                curve: Curves.easeInOut, // Kurva animasi
                                width: 69,
                                height: height,
                                decoration: BoxDecoration(
                                  color: Color(0xff9E9E9E),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(11),
                                    topRight: Radius.circular(11),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '2',
                                    style: GoogleFonts.poppins(
                                      fontSize: 34,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 66,
                          child: Column(
                            children: [
                              Stack(
                                children: <Widget>[
                                  // Stroked text as border.
                                  Text(
                                    'as',
                                    style: GoogleFonts.bungee(
                                      fontSize: 18,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 1
                                        ..color = Color(0xff18B279),
                                    ),
                                  ),
                                  // Solid text as fill.
                                  Text(
                                    'as',
                                    style: GoogleFonts.bungee(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ],
                              ),
                              Image.asset(
                                'assets/images/avatar_3.png',
                                width: 65,
                                height: 65,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 69,
                                height: 69,
                                decoration: BoxDecoration(
                                    color: Color(0xffCE7430),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(11),
                                      topRight: Radius.circular(11),
                                    )),
                                child: Center(
                                  child: Text(
                                    '3',
                                    style: GoogleFonts.poppins(
                                        fontSize: 34,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Bagian bawah (Top 4 hingga 10)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 7, // Jumlah peserta dari 4 hingga 10
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(
                              (index + 4).toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 18, color: Colors.black),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 70,
                              padding:  EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
                              decoration: BoxDecoration(
                                color: Color(0xffF3F9FC),
                                borderRadius: index == 0
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      )
                                    : index == 6
                                        ? BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          )
                                        : null,
                              ),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              child:  Row(
                                children: [
                                  Image.asset(
                                    'assets/images/avatar_3.png',
                                    width: 44,
                                    height: 44,
                                    fit: BoxFit.cover,
                                  
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rifki',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Row(children: [
                                        Image.asset(
                                          'assets/images/star.png',
                                          width: 16,
                                          height: 16,
                                          fit: BoxFit.cover,
                                        
                                        ),
                                        SizedBox(width:  5,),
                                        Text(
                                              '124',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Color(0xffC7C7C7),
                                                  ),
                                            ),
                                      ],)
                                      
                                    ],
                                  )
                                ],
                              )
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
