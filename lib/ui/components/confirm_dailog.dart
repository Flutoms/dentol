import 'package:dental_health/ui/util/colors.dart';
import 'package:dental_health/ui/util/text_styles.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatefulWidget {
  const ConfirmDialog(
      {Key? key,
      required this.titleText,
      required this.warningText,
      required this.okText,
      required this.onTap})
      : super(key: key);

  final String titleText, warningText, okText;
  final Function() onTap;

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Text(widget.titleText,
                    textAlign: TextAlign.center, style: boldText()),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                Text(widget.warningText,
                    textAlign: TextAlign.center,
                    style: regularText(fontSize: 14)),
                const SizedBox(height: 60),
                GestureDetector(
                    onTap: widget.onTap,
                    child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(widget.okText,
                            style: regularText(color: Colors.white))))
              ]),
        ));
  }
}
