import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fitlife/core/viewmodels/user/user_provider.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/widgets/CustomAppBar.dart';

import '../../core/viewmodels/connection/connection.dart';
import '../widgets/button.dart';
import '../widgets/history_step_card.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import getolocation.dart';

import 'package:geolocator/geolocator.dart'
    as geolocator; // you can change this to what you want
// you can change this to what you want

class RecordRunScreen extends StatefulWidget {
  const RecordRunScreen({Key? key}) : super(key: key);

  @override
  State<RecordRunScreen> createState() => _RecordRunScreenState();
}

class _RecordRunScreenState extends State<RecordRunScreen> {
   GoogleMapController? _mapController;
  Position? _currentPosition;
  bool _isTracking = false;
  DateTime? _startTime;
  DateTime? _endTime;
  Duration _duration = Duration();
  Timer? _timer;
  double _distance = 0.0;
  double _speed = 0.0;
  double _calories = 0.0;
  @override
  void initState() {
    super.initState();
    _determinePosition().then((position) {
      setState(() {
        _currentPosition = position;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied.';
    }

    return await Geolocator.getCurrentPosition();
  }

   void _startTracking() {
    setState(() {
      _isTracking = true;
      _startTime = DateTime.now();
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _duration = DateTime.now().difference(_startTime!);
        });
      });
    });
  }

  void _stopTracking() {
    setState(() {
      _isTracking = false;
      _endTime = DateTime.now();
      _timer?.cancel();
      _updateStatistics();
    });
  }

  void _updateStatistics() {
    if (_startTime != null && _endTime != null && _currentPosition != null) {
      Duration duration = _endTime!.difference(_startTime!);
      double speed = _currentPosition!.speed;
      double distance = speed * duration.inSeconds.toDouble() / 1000.0;
      double calories = distance * 0.05; // Assuming 1 km burns 0.05 calories

      setState(() {
        Duration duration = _endTime!.difference(_startTime!);
        // _distance = distance;
        // _speed = speed;
        // _calories = calories;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
      appBar: CustomAppBar(
        title: 'Track Aktivitas Jogging',
        backgroundColor: lightModeBgColor,
        elevation: 0,
        
        actions: [
         
           Image.asset(
            'assets/images/work-time.png',
          
          )
        ],
        leading: CustomBackButton(
            iconColor: const Color(0xffF39CFF),
            onClick: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                
                Container(
                  child:  Column(children: [
                    Text(
                      ' ${_duration.toString().split('.')[0]}',
                      style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xffF39CFF)),
                    ),
                    SizedBox(height: 8,),
                    Text("Durasi", style:  GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff484848)
                        ) 
                    )
                   
                  ],),

                 
                ),

                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                  child:  Column(children: [
                    Text(
                      '$_distance' + ' km',
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff212E3D)),
                    ),
                    SizedBox(height: 8,),
                    Text("Jarak", style:  GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff484848)
                        ) 
                    )
                   
                  ],),),
                    Container(
                  child:  Column(children: [
                    Text(
                      ' $_speed' + ' km/h',
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff212E3D)),
                    ),
                    SizedBox(height: 8,),
                    Text("Kecepatan ", style:  GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff484848)
                        ) 
                    )
                   
                  ],),),
                    Container(
                  child:  Column(children: [
                    Text(
                      '$_calories' + ' kcal',
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff212E3D)),
                    ),
                    SizedBox(height: 8,),
                    Text("Kalori terbakar", style:  GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff484848)
                        ) 
                    )
                   
                  ],),),
                  ],
                )
                // Display other statistics here
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                setState(() {
                  _mapController = controller;
                });
              },
              initialCameraPosition: CameraPosition(
                target: _currentPosition != null
                    ? LatLng(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      )
                    : LatLng(37.42796133580664, -122.085749655962),
                zoom: 14,
              ),
              myLocationEnabled: true,
              compassEnabled: true,
              markers: _currentPosition != null
                  ? {
                      Marker(
                        markerId: MarkerId('currentLocation'),
                        position: LatLng(
                          _currentPosition!.latitude,
                          _currentPosition!.longitude,
                        ),
                      ),
                    }
                  : {},
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  const Color(0xffF39CFF),
        onPressed: _isTracking ? _stopTracking : _startTracking,
        child: Icon(_isTracking ? Icons.stop : Icons.play_arrow),
      ),
    );
  }
}
