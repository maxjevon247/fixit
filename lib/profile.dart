import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  File? _videoFile;

  Future<List<int>> compressImage(File imageFile, {int quality = 85}) async {
    // Get the file as a list of bytes
    Uint8List imageBytes = await imageFile.readAsBytes();

    // Compress the image bytes
    List<int>? compressedBytes = await FlutterImageCompress.compressWithList(
      imageBytes,
      minHeight:
          1920, // Provide minimum height and width for the compressed image
      minWidth: 1080,
      quality: quality,
    );

    // Return the compressed bytes
    return compressedBytes;
  }

  Future<void> _uploadImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      setState(() {
        _imageFile = imageFile;
      });

      // Compress image before uploading (Adjust quality as needed)
      Uint8List? result =
          (await compressImage(imageFile, quality: 85)) as Uint8List?;

      Reference ref = _storage.ref().child('images/${DateTime.now()}.jpg');
      UploadTask uploadTask = ref.putData(result!);

      await uploadTask.whenComplete(() => setState(() {
            // Handle completion or UI updates after upload
          }));
    }
  }

  Future<void> _uploadVideo() async {
    final XFile? pickedFile =
        await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      File videoFile = File(pickedFile.path);
      setState(() {
        _videoFile = videoFile;
      });

      // Compress video before uploading
      MediaInfo? info = await VideoCompress.compressVideo(
        videoFile.path,
        quality: VideoQuality.DefaultQuality,
      );

      File compressedVideo = File(info!.path!);

      Reference ref = _storage.ref().child('videos/${DateTime.now()}.mp4');
      UploadTask uploadTask = ref.putFile(compressedVideo);

      await uploadTask.whenComplete(() => setState(() {
            // Handle completion or UI updates after upload
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _uploadImage,
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _uploadVideo,
              child: const Text('Upload Video'),
            ),
            const SizedBox(height: 20.0),
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                height: 150,
              ),
            if (_videoFile != null)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: VideoPlayerWidget(videoFile: _videoFile!),
              ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final File videoFile;

  const VideoPlayerWidget({super.key, required this.videoFile});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? VideoPlayer(_controller)
        : const CircularProgressIndicator();
  }
}
