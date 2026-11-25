import 'package:flutter/material.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/widgets/home_doctor_art.dart';

class HomeCareHeader extends StatelessWidget {
  const HomeCareHeader({
    super.key,
    required this.userName,
    required this.userImage,
    required this.onProfileTap,
    this.searchPanel,
  });

  final String userName;
  final String userImage;
  final VoidCallback onProfileTap;
  final Widget? searchPanel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
          child: Container(
            height: 186,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.topEnd,
                end: AlignmentDirectional.bottomStart,
                colors: [
                  Color(0xFF9CE0C0),
                  Color(0xFFE6F7EE),
                ],
              ),
            ),
            child: Stack(
              children: [
                const HomeHeaderWaves(),
                PositionedDirectional(
                  start: 20,
                  end: 110,
                  top: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '👋 ${ManagerStrings.hi}$userName',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getMediumTextStyle(
                          fontSize: 15,
                          color: const Color(0xFF227350),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        ManagerStrings.findYourDoctor,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: ManagerFontFamily.fontFamily,
                          fontSize: 30,
                          height: 1.15,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF154734),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                PositionedDirectional(
                  end: 20,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: InkWell(
                      onTap: onProfileTap,
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xD9FFFFFF),
                            width: 3,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1F154734),
                              blurRadius: 16,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: SizedBox(
                            width: 76,
                            height: 76,
                            child: userImage.isEmpty
                                ? Image.asset(
                                    ManagerImages.defaultDoctorImage,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    userImage,
                                    fit: BoxFit.cover,
                                    cacheWidth: 240,
                                    errorBuilder: (_, __, ___) => Image.asset(
                                      ManagerImages.defaultDoctorImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (searchPanel != null)
          Positioned(
            left: 20,
            right: 20,
            bottom: -28,
            child: searchPanel!,
          ),
      ],
    );
  }
}
