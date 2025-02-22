import 'package:flutter/material.dart';
import 'package:orphee_money/utils/constants.dart';

class CustomSelectorPro extends StatefulWidget {
  final Function() onTap;
  final double height;
  final bool isSelected;
  final String label;

  const CustomSelectorPro(
      {super.key,
      required this.onTap,
      this.height = 56.0,
      required this.isSelected,
      required this.label});

  @override
  State<CustomSelectorPro> createState() => _CustomSelectorProState();
}

class _CustomSelectorProState extends State<CustomSelectorPro> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.only(left: 16.0, bottom: 8),
        width: 90,
        height: widget.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                        color: Colors.grey!.withOpacity(.4),
                        offset: Offset(0, 8),
                        blurRadius: 15)
                  ]
                : null),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(
                fontSize: 16,
                color: widget.isSelected ? fontDark : Colors.black45,
                fontWeight:
                    widget.isSelected ? FontWeight.w700 : FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
