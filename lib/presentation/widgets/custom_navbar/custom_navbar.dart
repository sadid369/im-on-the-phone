import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/custom_assets/assets.gen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<String> icons = [
    Assets.icons.home.path,
    Assets.icons.scan.path,
    Assets.icons.transaction.path,
    Assets.icons.profile.path,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: const Color(0xFF282F291A).withOpacity(0.1),
        borderRadius: BorderRadius.circular(50.r),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(icons.length, (index) {
          bool isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              padding: EdgeInsets.zero,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: isSelected ? 150.w : 65.w,
              height: 65.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFFFD54F)
                    : const Color(0xFFC4C4C4),
                borderRadius: BorderRadius.circular(isSelected ? 25.r : 50.r),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                icons[index],
              ),
            ),
          );
        }),
      ),
    );
  }
}
