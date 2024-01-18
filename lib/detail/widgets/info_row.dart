import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usability_projekt/common/colors.dart';
import 'package:usability_projekt/common/snackbars.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({
    required this.icon,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return text.isEmpty
        ? Container()
        : Row(
            children: [
              Icon(
                icon,
                color: Colors.grey[600],
              ),
              // create vertical divider
              VerticalDivider(
                color: Colors.grey[600],
                thickness: 10.0,
                width: 20.0,
                indent: 10.0,
                endIndent: 10.0,
              ),
              Expanded(
                child: SelectableRegion(
                  focusNode: FocusNode(),
                  selectionControls: MaterialTextSelectionControls(),
                  child: GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: text)).then(
                        (value) => showSuccessSnackBar(
                          context,
                          message: 'Text wurde in die Zwischenablage kopiert.',
                          color: blackColor,
                        ),
                      );
                    },
                    child: Text(
                      text,
                      maxLines: 2,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
