import 'package:flutter/material.dart';
import 'package:tender/core/resources/manager_fonts.dart';

Widget modernMessageBubble({
  required bool isSender,
  required String message,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    child: Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(18),
              topRight: const Radius.circular(18),
              bottomLeft: isSender
                  ? const Radius.circular(18)
                  : const Radius.circular(5),
              bottomRight: isSender
                  ? const Radius.circular(5)
                  : const Radius.circular(18),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isSender
                  ? const [Color(0xFF168A57), Color(0xFF32A577)]
                  : const [Color(0xF2FFFFFF), Color(0xF2EAF7EF)],
            ),
            border: isSender
                ? null
                : Border.all(color: const Color(0x99FFFFFF), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x12154734),
                blurRadius: 12,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  message,
                  style: TextStyle(
                    fontFamily: ManagerFontFamily.fontFamily,
                    fontSize: 14.5,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                    color: isSender
                        ? Colors.white
                        : const Color(0xFF1E2422),
                  ),
                ),
              ),
              if (isSender) ...[
                const SizedBox(width: 6),
                const Icon(
                  Icons.done_all_rounded,
                  size: 13,
                  color: Color(0xCCFFFFFF),
                ),
              ],
            ],
          ),
        ),
      ),
    ),
  );
}
