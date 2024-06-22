import 'package:flutter/material.dart';

// 백스페이스가 어설프게 동작함
class OTPInput extends StatefulWidget {
  final Function checkValid;
  const OTPInput({
    super.key,
    required this.checkValid,
  });

  @override
  State<OTPInput> createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  final int otpLength = 6;
  List<FocusNode> focusNodes = [];
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < otpLength; i++) {
      focusNodes.add(FocusNode());
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < otpLength; i++) {
      focusNodes[i].dispose();
      controllers[i].dispose();
    }
    super.dispose();
  }

  void _onKeyPress(String value, int index) {
    if (value.isNotEmpty) {
      if (index + 1 < otpLength) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      }
    } else {
      if (index - 1 >= 0) {
        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      }
    }
    widget.checkValid(_checkValid());
  }

  bool _checkValid() {
    for (int i = 0; i < otpLength; i++) {
      if (controllers[i].value.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(otpLength, (index) {
            return SizedBox(
              width: 50,
              child: TextField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                decoration: const InputDecoration(counterText: ''),
                onChanged: (value) {
                  _onKeyPress(value, index);
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}

// // 물리 키보드 backspace만 잘 동작함
// class OTPInput extends StatefulWidget {
//   const OTPInput({super.key});

//   @override
//   _OTPInputState createState() => _OTPInputState();
// }

// class _OTPInputState extends State<OTPInput> {
//   final int numberOfFields = 6;
//   List<FocusNode> focusNodes = [];
//   List<TextEditingController> controllers = [];

//   @override
//   void initState() {
//     super.initState();
//     focusNodes = List.generate(numberOfFields, (index) => FocusNode());
//     controllers =
//         List.generate(numberOfFields, (index) => TextEditingController());
//   }

//   @override
//   void dispose() {
//     for (var node in focusNodes) {
//       node.dispose();
//     }
//     for (var controller in controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   void onChanged(String value, int index) {
//     if (value.isNotEmpty) {
//       if (index < numberOfFields - 1) {
//         FocusScope.of(context).requestFocus(focusNodes[index + 1]);
//       } else {
//         focusNodes[index].unfocus();
//       }
//     }
//   }

//   void onKey(KeyEvent event) {
//     if (event is KeyDownEvent &&
//         event.logicalKey == LogicalKeyboardKey.backspace) {
//       for (int i = 0; i < numberOfFields; i++) {
//         if (focusNodes[i].hasFocus && controllers[i].text.isEmpty && i > 0) {
//           FocusScope.of(context).requestFocus(focusNodes[i - 1]);
//           controllers[i - 1].clear();
//           break;
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return KeyboardListener(
//       focusNode: FocusNode(), // RawKeyboardListener에 대한 포커스 노드
//       onKeyEvent: onKey, // 키 이벤트 핸들러
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: List.generate(numberOfFields, (index) {
//           return SizedBox(
//             width: 40,
//             child: TextField(
//               controller: controllers[index],
//               focusNode: focusNodes[index],
//               keyboardType: TextInputType.number,
//               textAlign: TextAlign.center,
//               maxLength: 1,
//               decoration: const InputDecoration(
//                 counterText: '',
//                 // border: OutlineInputBorder(),
//               ),
//               onChanged: (value) => onChanged(value, index),
//               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
