import 'package:flutter/material.dart';

class ActionBottomSheet extends StatelessWidget {
  const ActionBottomSheet(
      {Key? key,
      this.title,
      this.description,
      this.descriptionAction,
      this.warning,
      this.action1,
      this.action2,
      this.onTapAction1,
      this.onTapAction2, this.widget, this.children})
      : super(key: key);
  final String? title;
  final String? description;
  final String? descriptionAction;
  final String? warning;
  final String? action1;
  final String? action2;
  final Function()? onTapAction1;
  final Function()? onTapAction2;
  final Widget? widget;
   final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.9,
      child: BottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children!
          ),
        ),
        onClosing: () => Navigator.pop(context),
      ),
    );
  }
}
