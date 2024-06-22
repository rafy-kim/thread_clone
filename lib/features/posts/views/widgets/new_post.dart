import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'package:thread_clone/features/posts/views/widgets/attach_photo.dart';
import 'package:thread_clone/utils.dart';

class NewPost extends ConsumerStatefulWidget {
  const NewPost({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewPostState();
}

class _NewPostState extends ConsumerState<NewPost> {
  final String userName = "rafy";
  final TextEditingController _postEditingController = TextEditingController();
  String _post = "";
  File? _selectedPhoto;

  @override
  void initState() {
    super.initState();
    _postEditingController.addListener(() {
      setState(() {
        _post = _postEditingController.text;
      });
    });
  }

  @override
  void dispose() {
    _postEditingController.dispose();
    super.dispose();
  }

  void _onTapCancel() {
    Navigator.of(context).pop();
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus();
  }

  void _onStartWriting() {}

  void _deleteImage() {
    _stopWriting();
    setState(() {
      _selectedPhoto = null;
    });
  }

  Future<void> _onAttachTap() async {
    _stopWriting();
    final File? result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AttachPhoto(),
      ),
    );
    if (result != null) {
      setState(() {
        _selectedPhoto = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _stopWriting,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size18),
        ),
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80.0,
            title: const Text(
              "New thread",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.15,
              ),
            ),
            leadingWidth: 100,
            leading: GestureDetector(
              onTap: _onTapCancel,
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.15,
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Colors.grey,
                height: 0.5,
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              child: Text(userName.substring(0, 2)),
                            ),
                            Gaps.v10,
                            Expanded(
                              child: VerticalDivider(
                                thickness: Sizes.size3,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            Opacity(
                              opacity: 0.5,
                              child: CircleAvatar(
                                radius: 10,
                                child: Text(
                                  userName.substring(0, 2),
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Gaps.h10,
                                  Text(
                                    userName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Gaps.h5,
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.blue[300],
                                    size: 17,
                                  ),
                                ],
                              ),
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.3,
                                ),
                                child: TextField(
                                  controller: _postEditingController,
                                  onTap: _onStartWriting,
                                  maxLines: null,
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    hintText: "Start a thread...",
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: _post == ""
                                        ? (isDarkMode(context)
                                            ? Colors.grey.shade900
                                            : Colors.grey.shade100)
                                        : (isDarkMode(context)
                                            ? Colors.black
                                            : Colors.white),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: Sizes.size10,
                                      horizontal: Sizes.size10,
                                    ),
                                  ),
                                ),
                              ),
                              Gaps.v10,
                              _selectedPhoto != null
                                  ? SizedBox(
                                      // height: 250,
                                      child: Stack(
                                        children: [
                                          Image.file(
                                            _selectedPhoto!,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: IconButton(
                                              icon: const FaIcon(
                                                FontAwesomeIcons.circleXmark,
                                                color: Colors.white,
                                              ),
                                              onPressed: _deleteImage,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : IconButton(
                                      icon: const FaIcon(
                                          FontAwesomeIcons.paperclip),
                                      onPressed: _onAttachTap,
                                    ),
                              Gaps.v10,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "Anyone can reply",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: _post != "" ? 1.0 : 0.4,
                            child: const Text(
                              "Post",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.v10,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
