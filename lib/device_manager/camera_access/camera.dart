// camera_access.dart
// Handles camera permission and preview

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraAccessScreen extends StatefulWidget {
  const CameraAccessScreen({super.key});

  @override
  State<CameraAccessScreen> createState() => _CameraAccessScreenState();
}

class _CameraAccessScreenState extends State<CameraAccessScreen> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  /// Request permission & initialize camera
  Future<void> _initializeCamera() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      cameras = await availableCameras();

      if (cameras!.isNotEmpty) {
        _controller = CameraController(cameras![0], ResolutionPreset.medium);

        await _controller!.initialize();

        setState(() {
          isCameraInitialized = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Camera Access"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: isCameraInitialized
            ? CameraPreview(_controller!)
            : const Text(
                "Initializing Camera...",
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
