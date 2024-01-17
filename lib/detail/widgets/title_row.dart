import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class TitleRow extends StatefulWidget {
  final String title;
  final String? subtitle;

  const TitleRow({
    required this.title,
    this.subtitle,
    super.key,
  });

  @override
  State<TitleRow> createState() => _TitleRowState();
}

class _TitleRowState extends State<TitleRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              height: 40,
              alignment: Alignment.center,
              child: widget.title.length > 15 ? Marquee(
                text: widget.title,
                style: _titleStyle(),
                velocity: 35.0,
                blankSpace: 30.0,
                startAfter: const Duration(milliseconds: 400),
              ) : Text(
                widget.title,
                textAlign: TextAlign.center,
                style: _titleStyle(),
              ),
            ),
          ),
          _buildSubtitle(),
        ],
      ),
    );
  }

  TextStyle _titleStyle() {
    return const TextStyle(
      fontSize: 24.0,
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle() {
    return widget.subtitle == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              widget.subtitle!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.white54,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
  }
}
