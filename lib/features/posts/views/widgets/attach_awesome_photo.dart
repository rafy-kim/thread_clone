import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttachAwesomePhoto extends ConsumerStatefulWidget {
  const AttachAwesomePhoto({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AttachAwesomePhotoState();
}

class _AttachAwesomePhotoState extends ConsumerState<AttachAwesomePhoto>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.white,
        child: CameraAwesomeBuilder.awesome(
          saveConfig: SaveConfig.photo(),
          onMediaTap: (mediaCapture) {
            // Hande tap on the preview of the last media captured
            print('Tap on ${mediaCapture.captureRequest.path}');
          },
          // onMediaTap: (mediaCapture) {
          //   OpenFile.open(mediaCapture.filePath);
          // },
        ),
      ),
    );
  }
}
