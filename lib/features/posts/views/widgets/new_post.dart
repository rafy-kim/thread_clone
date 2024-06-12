import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time/constants/gaps.dart';
import 'package:navigation_time/constants/sizes.dart';

class NewPost extends ConsumerStatefulWidget {
  const NewPost({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewPostState();
}

class _NewPostState extends ConsumerState<NewPost> {
  final String userName = "rafy";
  final TextEditingController _postEditingController = TextEditingController();
  String _post = "";

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
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                              // width: Sizes.size32,
                              thickness: Sizes.size3,
                              color: Colors.grey.shade300,
                              // indent: Sizes.size14,
                              // endIndent: Sizes.size14,
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
                            Expanded(
                              child: TextField(
                                controller: _postEditingController,
                                onTap: _onStartWriting,
                                expands: true,
                                minLines: null,
                                maxLines: null,
                                textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  hintText: "Start a thread...",
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: Sizes.size10,
                                    horizontal: Sizes.size10,
                                  ),
                                ),
                              ),
                            ),
                            Gaps.v10,
                            IconButton(
                              icon: const FaIcon(FontAwesomeIcons.paperclip),
                              onPressed: () {},
                            ),
                            Gaps.v10,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
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
                ),
                Gaps.v10,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
