import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/constants/sizes.dart';

class PostMore extends ConsumerStatefulWidget {
  const PostMore({required this.selectIndex, super.key});
  final Function selectIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostMoreState();
}

class _PostMoreState extends ConsumerState<PostMore> {
  void _onTapButton(index) {
    widget.selectIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomRadiusButton(
            radiusTop: true,
            radiusBottom: false,
            text: "Unfollow",
            onTap: () {},
          ),
          CustomRadiusButton(
            radiusTop: false,
            radiusBottom: true,
            text: "Mute",
            onTap: () {},
          ),
          Gaps.v20,
          CustomRadiusButton(
            radiusTop: true,
            radiusBottom: false,
            text: "Hide",
            onTap: () {},
          ),
          CustomRadiusButton(
            radiusTop: false,
            radiusBottom: true,
            text: "Report",
            textColor: Colors.red,
            onTap: () => _onTapButton(4),
          ),
          Gaps.v60,
        ],
      ),
    );
  }
}

class CustomRadiusButton extends StatelessWidget {
  final bool radiusTop;
  final bool radiusBottom;
  final String text;
  final Function onTap;
  final Color? textColor;
  const CustomRadiusButton({
    super.key,
    required this.radiusTop,
    required this.radiusBottom,
    required this.text,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          width: double.infinity,
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            border: radiusTop
                ? const Border(
                    bottom: BorderSide(
                      width: 0.4,
                      color: Color(0xffbbbbbb),
                    ),
                  )
                : null,
            borderRadius: BorderRadius.only(
              topLeft: radiusTop
                  ? const Radius.circular(
                      Sizes.size24,
                    )
                  : Radius.zero,
              topRight: radiusTop
                  ? const Radius.circular(
                      Sizes.size24,
                    )
                  : Radius.zero,
              bottomLeft: radiusBottom
                  ? const Radius.circular(
                      Sizes.size24,
                    )
                  : Radius.zero,
              bottomRight: radiusBottom
                  ? const Radius.circular(
                      Sizes.size24,
                    )
                  : Radius.zero,
            ),
          ),
          padding: const EdgeInsets.all(
            Sizes.size20,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: Sizes.size18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
