import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

// List<CameraDescription> cameras;


class CameraApp extends StatefulWidget {
  List<CameraDescription> cameras;
  CameraApp({this.cameras});
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    print('相机${widget.cameras}');
    controller = CameraController(widget.cameras[0], ResolutionPreset.medium);
    // controller.initialize().then((_) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (!controller.value.isInitialized) {
      return Container();
    // }
    // return AspectRatio(
    //     aspectRatio:
    //     controller.value.aspectRatio,
    //     child: CameraPreview(controller));
  }
}