import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:flutter/material.dart';

class MeetingControls extends StatelessWidget {
  final void Function() onToggleMicButtonPressed;
  final void Function() onToggleWebcamButtonPressed;
  final void Function() onLeaveButtonPressed;
  final void Function() onswitchButtonPressed;
  const MeetingControls(
      {Key? key,
      required this.onToggleMicButtonPressed,
      required this.onToggleWebcamButtonPressed,
      required this.onLeaveButtonPressed,
      required this.onswitchButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
/*    return Sizer(builder: (context, orientation, deviceType) {*/
    return Material(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          iconSize: 25,
          color: ColorUtils.trendyButtonColor,
          icon: const Icon(
            Icons.call_end,
          ),
          // the method which is called
          // when button is pressed
          onPressed: onLeaveButtonPressed,
        ),
        IconButton(
          iconSize: 25,
          color: ColorUtils.trendyButtonColor,
          icon: const Icon(
            Icons.mic,
          ),
          // the method which is called
          // when button is pressed
          onPressed: onToggleMicButtonPressed,
        ),
        IconButton(
          iconSize: 25,
          color: ColorUtils.trendyButtonColor,
          icon: const Icon(
            Icons.camera_alt,
          ),
          // the method which is called
          // when button is pressed
          onPressed: onToggleWebcamButtonPressed,
        ),
        IconButton(
          iconSize: 25,
          color: ColorUtils.trendyButtonColor,
          icon: const Icon(
            Icons.switch_camera,
          ),
          // the method which is called
          // when button is pressed
          onPressed: onToggleWebcamButtonPressed,
        ),
      ],
    ));
  }
}
