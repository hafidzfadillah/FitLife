import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'dart:math' as math;

import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitlife/main.dart';
import 'package:fitlife/ui/home/theme.dart';

typedef void Callback(List<dynamic> list, int h, int w);

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;

  const Camera(
      {super.key, required this.cameras, required this.setRecognitions});

  @override
  _CameraState createState() => new _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController? controller;
  bool isDetecting = false, isFrontCamera = true;

  @override
  void initState() {
    super.initState();

    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No camera is found');
    } else {
      controller = new CameraController(
        widget.cameras[1],
        ResolutionPreset.high,
      );
      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});

        controller!.startImageStream((CameraImage img) {
          if (!isDetecting) {
            isDetecting = true;

            int startTime = new DateTime.now().millisecondsSinceEpoch;

            Tflite.runPoseNetOnFrame(
              bytesList: img.planes.map((plane) {
                return plane.bytes;
              }).toList(),
              imageHeight: img.height,
              imageWidth: img.width,
              //numResults: 2,
              numResults: 1,
              rotation: -90,
              threshold: 0.1,
              nmsRadius: 10,
            ).then((recognitions) {
              int endTime = new DateTime.now().millisecondsSinceEpoch;
              print("Detection took ${endTime - startTime}");

              widget.setRecognitions(recognitions!, img.height, img.width);

              isDetecting = false;
            });
          }
        });
      });
    }
  }

  void toggleCamera() async {
    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No camera is found');
    } else {
      controller = new CameraController(
        isFrontCamera ? widget.cameras[1] : widget.cameras[0],
        ResolutionPreset.high,
      );

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});

        controller!.startImageStream((CameraImage img) {
          if (!isDetecting) {
            isDetecting = true;

            int startTime = new DateTime.now().millisecondsSinceEpoch;

            Tflite.runPoseNetOnFrame(
              bytesList: img.planes.map((plane) {
                return plane.bytes;
              }).toList(),
              imageHeight: img.height,
              imageWidth: img.width,
              //numResults: 2,
              numResults: 1,
              rotation: -90,
              threshold: 0.1,
              nmsRadius: 10,
            ).then((recognitions) {
              int endTime = new DateTime.now().millisecondsSinceEpoch;
              print("Detection took ${endTime - startTime}");

              widget.setRecognitions(recognitions!, img.height, img.width);

              isDetecting = false;
            });
          }
        });
      });

      setState(() {
        isFrontCamera = !isFrontCamera;
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller!.value.previewSize!;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return Stack(
      children: [
        OverflowBox(
          maxHeight: screenRatio > previewRatio
              ? screenH
              : screenW / previewW * previewH,
          maxWidth: screenRatio > previewRatio
              ? screenH / previewH * previewW
              : screenW,
          child: CameraPreview(controller!),
        ),
        // Positioned(
        //     bottom: defMargin * 4 + defMargin,
        //     right: defMargin,
        //     child: FloatingActionButton.extended(
        //       onPressed: () {
        //         toggleCamera();
        //       },
        //       backgroundColor: Colors.white,
        //       icon: Icon(
        //         Icons.cameraswitch_outlined,
        //         color: primaryColor,
        //       ),
        //       isExtended: true,
        //       label: Text(isFrontCamera ? "Kamera Belakang" : "Kamera Depan",
        //           style: GoogleFonts.poppins(color: primaryColor)),
        //     ))
      ],
    );
  }
}
