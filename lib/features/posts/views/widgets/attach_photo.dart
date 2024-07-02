import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'package:permission_handler/permission_handler.dart';

class AttachPhoto extends ConsumerStatefulWidget {
  const AttachPhoto({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AttachPhotoState();
}

class _AttachPhotoState extends ConsumerState<AttachPhoto>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isSelfieMode = false;
  late CameraController _cameraController;
  bool _isCameraInitialized = false;

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);

  final List<FlashMode> _flashModes = [
    FlashMode.auto,
    FlashMode.off,
    FlashMode.always,
    FlashMode.torch,
  ];
  int _currentFlashModeIndex = 0;

  final List<IconData> _flashIcons = [
    Icons.flash_auto_rounded,
    Icons.flash_off_rounded,
    Icons.flash_on_rounded,
    Icons.flashlight_on_rounded,
  ];

  @override
  void initState() {
    super.initState();
    // iOS 시뮬레이터에서는 카메라 사용 X
    if (!kDebugMode || !Platform.isIOS) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    if (_isCameraInitialized) {
      _cameraController.dispose();
      _buttonAnimationController.dispose();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_isCameraInitialized) return;
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed && _hasPermission) {
      initCamera();
    }
  }

  Future<void> initCamera() async {
    if (!mounted) return;

    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    try {
      await _cameraController.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    if (cameraPermission.isGranted) {
      setState(() {
        _hasPermission = true;
      });
      await initCamera();
    }
  }

  Future<void> _toggleSelfieMode() async {
    setState(() {
      _isSelfieMode = !_isSelfieMode;
    });
    await initCamera();
  }

  Future<void> _setFlashMode() async {
    if (!_isCameraInitialized) return;
    setState(() {
      _currentFlashModeIndex =
          (_currentFlashModeIndex + 1) % _flashModes.length;
    });
    await _cameraController.setFlashMode(_flashModes[_currentFlashModeIndex]);
  }

  Future<void> _startRecording(TapDownDetails _) async {
    if (!_isCameraInitialized) return;
    _buttonAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_isCameraInitialized) return;
    _buttonAnimationController.reverse();
    final photo = await _cameraController.takePicture();
    if (!mounted) return;
    Navigator.of(context).pop(File(photo.path));
  }

  Future<void> _onPickVideoPressed() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null || !mounted) return;
    Navigator.of(context).pop(File(photo.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission
            ? const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        if (_isCameraInitialized)
                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: CameraPreview(_cameraController),
                          ),
                        Positioned(
                          top: Sizes.size80,
                          left: Sizes.size20,
                          child: GestureDetector(
                            onTap: () => context.pop(),
                            child: const Row(
                              children: [
                                Gaps.h10,
                                FaIcon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: Sizes.size40,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    color: Colors.white,
                                    onPressed: _setFlashMode,
                                    icon: Icon(
                                        _flashIcons[_currentFlashModeIndex]),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTapDown: _startRecording,
                                onTapUp: (details) => _stopRecording(),
                                child: ScaleTransition(
                                  scale: _buttonAnimation,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      const SizedBox(
                                        width: Sizes.size80 + Sizes.size14,
                                        height: Sizes.size80 + Sizes.size14,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: Sizes.size6,
                                          value: 1,
                                        ),
                                      ),
                                      Container(
                                        width: Sizes.size80,
                                        height: Sizes.size80,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    color: Colors.white,
                                    onPressed: _toggleSelfieMode,
                                    icon: const Icon(Icons.cameraswitch),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.v32,
                  SizedBox(
                    height: 100,
                    child: Row(
                      children: [
                        const Spacer(),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: const Text(
                              "Camera",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: _onPickVideoPressed,
                            child: Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Library",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: Sizes.size18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
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
