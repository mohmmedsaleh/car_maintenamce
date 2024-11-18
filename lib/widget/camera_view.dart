import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

import 'custom_button.dart';

class CameraView extends StatefulWidget {
  const CameraView(
      {Key? key, required this.onImage, required this.onInputImage})
      : super(key: key);

  final Function(Uint8List image) onImage;
  final Function(InputImage inputImage) onInputImage;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  File? _image;
  ImagePicker? _imagePicker;

  @override
  void initState() {
    super.initState();

    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        _image != null
            ? CircleAvatar(
                radius: 40,
                backgroundColor: const Color(0xFF1860a3),
                backgroundImage: FileImage(_image!),
              )
            : const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFF1860a3),
                child: Icon(Icons.camera_alt, size: 30, color: Colors.white),
              ),
        const SizedBox(
          height: 50,
        ),
        _image != null
            ? CustomButton(
                text: "changephoto".tr,
                onTap: () {
                  _getImage();
                },
              )
            : CustomButton(
                text: "takephoto".tr,
                onTap: () {
                  _getImage();
                },
              ),
        // GestureDetector(
        //   onTap: _getImage,
        //   child: Container(
        //     width: 60,
        //     height: 60,
        //     margin: const EdgeInsets.only(top: 20, bottom: 20),
        //     decoration: const BoxDecoration(
        //       gradient: RadialGradient(
        //         stops: [0.4, 0.65, 1],
        //         colors: [
        //           const Color(0xFF1860a3),
        //           primaryWhite,
        //           const Color(0xFF1860a3),
        //         ],
        //       ),
        //       shape: BoxShape.circle,
        //     ),
        //   ),
        // ),
        // Text(
        //   "انقر هنا لاخذ صوره",
        //   style: TextStyle(
        //     fontSize: 14,
        //     color: const Color(0xFF1860a3),
        //   ),
        // ),
      ],
    );
  }

  Future _getImage() async {
    setState(() {
      _image = null;
    });
    final pickedFile = await _imagePicker?.pickImage(
      source: ImageSource.camera,
      maxWidth: 400,
      maxHeight: 400,
      // imageQuality: 50,
    );
    if (pickedFile != null) {
      _setPickedFile(pickedFile);
    }
    setState(() {});
  }

  Future _setPickedFile(XFile? pickedFile) async {
    final path = pickedFile?.path;
    if (path == null) {
      return;
    }
    setState(() {
      _image = File(path);
    });

    Uint8List imageBytes = _image!.readAsBytesSync();
    widget.onImage(imageBytes);

    InputImage inputImage = InputImage.fromFilePath(path);
    widget.onInputImage(inputImage);
  }
}
