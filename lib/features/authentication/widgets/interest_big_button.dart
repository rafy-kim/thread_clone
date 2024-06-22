import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thread_clone/constants/sizes.dart';

class InterestBigButton extends StatefulWidget {
  final String interest;
  final Function selectInterest;

  const InterestBigButton({
    super.key,
    required this.interest,
    required this.selectInterest,
  });

  @override
  State<InterestBigButton> createState() => _InterestBigButtonState();
}

class _InterestBigButtonState extends State<InterestBigButton> {
  bool _isSelected = false;

  void _onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
    widget.selectInterest(_isSelected, widget.interest);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        width: 170,
        height: 80,
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(
          Sizes.size10,
        ),
        decoration: BoxDecoration(
          color: _isSelected ? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(
            Sizes.size14,
          ),
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: FaIcon(
                FontAwesomeIcons.solidCircleCheck,
                color: Colors.white,
              ),
            ),
            Text(
              widget.interest,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
