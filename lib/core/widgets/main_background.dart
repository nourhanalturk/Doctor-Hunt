import 'package:flutter/material.dart';
import 'package:tender/core/resources/manager_colors.dart';

import '../resources/manager_height.dart';
import '../resources/manager_opacity.dart';
import '../resources/manager_radius.dart';
import '../resources/manager_width.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const AppScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ManagerColors.scaffoldColor,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            //color: Colors.white,
            child: Stack(
              children: [
                Positioned(
                  top: ManagerHeight.h_33,
                  left: ManagerHeight.h_99,
                  child: Container(
                    width: ManagerWidth.w250,
                    height: ManagerHeight.h250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(ManagerOpacity.op0_2),
                          blurRadius: ManagerRadius.r100,
                          spreadRadius: ManagerRadius.r12,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: ManagerHeight.h_33,
                  right: ManagerHeight.h_99,
                  child: Container(
                    width: ManagerWidth.w250,
                    height: ManagerHeight.h250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(ManagerOpacity.op0_3),
                          blurRadius: ManagerRadius.r100,
                          spreadRadius: ManagerRadius.r12,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (body != null) SafeArea(child: body!)
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
