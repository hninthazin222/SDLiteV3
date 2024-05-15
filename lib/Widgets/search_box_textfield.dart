// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchBoxTextField extends StatefulWidget {
  final EdgeInsetsGeometry margin;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String hintText;
  final Color borderColor;
  final double borderWidth;
  final ValueChanged onChanged;
  final VoidCallback onPressed;
  final List<TextInputFormatter> inputFormatters;
  const SearchBoxTextField({
    required this.margin,
    required this.keyboardType,
    required this.controller,
    required this.hintText,
    required this.borderColor,
    required this.borderWidth,
    required this.onChanged,
    required this.onPressed,
    required this.inputFormatters,
  });

  @override
  State<SearchBoxTextField> createState() => _SearchBoxTextFieldState();
}

class _SearchBoxTextFieldState extends State<SearchBoxTextField> {
  Color color = Colors.grey[300]!;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (widget.margin == null)
          ? const EdgeInsets.only(left: 20, right: 20, top: 10)
          : widget.margin,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      (widget.borderColor == null) ? color : widget.borderColor,
                  width:
                      (widget.borderWidth == null) ? 1.0 : widget.borderWidth,
                ),
              ),
              height: 40,
              alignment: Alignment.center,
              child: TextField(
                onChanged: (widget.onChanged != null)
                    ? (value) {
                        widget.onChanged(value);
                      }
                    : null,
                autofocus: false,
                controller: widget.controller,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 23,
                  ),
                  hintText: widget.hintText,
                  isDense: true,
                  contentPadding: const EdgeInsets.all(0),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Myanmar',
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: widget.onPressed,
            child: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: color,
                  width: 1.0,
                ),
              ),
              child: const Icon(
                CupertinoIcons.refresh,
                color: Colors.grey,
                size: 21,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
