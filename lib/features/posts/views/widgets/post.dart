import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'package:thread_clone/features/posts/views/widgets/modal_sheet.dart';
import 'package:thread_clone/features/posts/views/widgets/post_more.dart';

class Post extends StatelessWidget {
  final String userName;
  final String content;
  final List<String> imgs;
  const Post({
    super.key,
    required this.userName,
    required this.content,
    required this.imgs,
  });

  void _onMoreTap(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      // barrierColor: Colors.red,
      // backgroundColor: Colors.transparent,
      builder: (context) => const ModalSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.start,
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
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        top: 14,
                        child: CircleAvatar(
                          backgroundColor: Colors.teal[200],
                          foregroundColor: Colors.white,
                          radius: 12.0,
                          child: const Text("A"),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.amber[200],
                          foregroundColor: Colors.white,
                          radius: 16.0,
                          child: const Text("B"),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.pink[200],
                          foregroundColor: Colors.white,
                          radius: 8.0,
                          child: const Text("C"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CircleAvatar(
                      //   child: Text(userName.substring(0, 2)),
                      // ),
                      Gaps.h10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
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
                          ],
                        ),
                      ),

                      const Text(
                        "2m",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Gaps.h10,
                      GestureDetector(
                        onTap: () => _onMoreTap(context),
                        child: const Icon(Icons.more_horiz),
                      ),
                    ],
                  ),
                  Text(
                    content,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                    ),
                  ),

                  Gaps.v10,
                  // Post image
                  if (imgs.isNotEmpty)
                    SizedBox(
                      height: 250,
                      child: PageView.builder(
                        controller: imgs.length > 1
                            ? PageController(viewportFraction: 0.9)
                            : null,
                        itemCount: imgs.length,
                        padEnds: false,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Image.network(
                              imgs[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                  Gaps.v10,
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.heart),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.comment),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.rotate),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.paperPlane),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Like
                  const Row(
                    children: [
                      Gaps.h14,
                      Text(
                        '53 replies',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        " · ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '437 likes',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  //Rows and comments count

                  Gaps.v10,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
