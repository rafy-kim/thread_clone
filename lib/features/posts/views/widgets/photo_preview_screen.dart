import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';

class PhotoPreviewScreen extends ConsumerStatefulWidget {
  final XFile photo;
  final bool isPicked;

  const PhotoPreviewScreen({
    super.key,
    required this.photo,
    required this.isPicked,
  });

  @override
  PhotoPreviewScreenState createState() => PhotoPreviewScreenState();
}

class PhotoPreviewScreenState extends ConsumerState<PhotoPreviewScreen> {
  // late final VideoPlayerController _videoPlayerController;

  bool _savedVideo = false;
  late final File _photo;

  // Future<void> _initVideo() async {
  //   _videoPlayerController = VideoPlayerController.file(
  //     File(widget.photo.path),
  //   );

  //   await _videoPlayerController.initialize();
  //   await _videoPlayerController.setLooping(true);
  //   await _videoPlayerController.play();

  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    _photo = File(widget.photo.path);
    // _initVideo();
  }

  @override
  void dispose() {
    // _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _saveToGallery() async {
    if (_savedVideo) return;

    await GallerySaver.saveVideo(
      widget.photo.path,
      albumName: "TikTok Clone!",
    );

    _savedVideo = true;

    setState(() {});
  }

  void _onUploadPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Preview video"),
        actions: [
          if (!widget.isPicked)
            IconButton(
              onPressed: _saveToGallery,
              icon: FaIcon(
                _savedVideo
                    ? FontAwesomeIcons.check
                    : FontAwesomeIcons.download,
              ),
            ),
          IconButton(
            onPressed: _onUploadPressed,
            icon: const FaIcon(FontAwesomeIcons.cloudArrowUp),
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Image.file(_photo),
        ),
      ),
    );
  }
}
