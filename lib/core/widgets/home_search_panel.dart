import 'package:flutter/material.dart';
import 'package:tender/core/resources/manager_icons.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';

class HomeSearchPanel extends StatelessWidget {
  const HomeSearchPanel({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14143C2D),
            blurRadius: 25,
            spreadRadius: -5,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        style: getRegularTextStyle(
          fontSize: 14,
          color: const Color(0xFF1E2422),
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: ManagerStrings.search,
          hintStyle: getRegularTextStyle(
            fontSize: 14,
            color: const Color(0xFF94A09C),
          ),
          prefixIcon: Icon(
            ManagerIcons.search,
            size: 20,
            color: Color(0xFF5C6964),
          ),
          suffixIcon: IconButton(
            onPressed: onClear,
            icon: Icon(
              ManagerIcons.clear,
              size: 18,
              color: Color(0xFF5C6964),
            ),
          ),
          contentPadding: const EdgeInsetsDirectional.only(
            start: 16,
            end: 8,
            top: 14,
            bottom: 14,
          ),
        ),
      ),
    );
  }
}
