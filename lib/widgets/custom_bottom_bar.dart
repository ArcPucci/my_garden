import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_garden/utils/utils.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    final overlay = MediaQuery.of(context).padding;
    final selectedIndex = getSelected();
    return Container(
      width: 375.w,
      height: 47.h + overlay.bottom,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.33.sp,
            color: Colors.black.withOpacity(0.3),
          ),
        ),
      ),
      padding: EdgeInsets.only(top: 7.h, left: 42.w, right: 42.w),
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          tabBarItems.length,
          (index) {
            final item = tabBarItems[index];
            final selected = index == selectedIndex;
            return GestureDetector(
              onTap: () => context.go(item.path),
              child: Container(
                height: 40.h,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      item.icon,
                      height: 21.h,
                      color: selected ? AppTheme.blue2 : null,
                    ),
                    Text(
                      item.title,
                      style: AppTextStyles.medium10.copyWith(
                        color: selected ? AppTheme.blue2 : null,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  int getSelected() {
    for(int i = tabBarItems.length - 1; i >= 0; i--) {
      if(path.contains(tabBarItems[i].path)) return i;
    }
    return 0;
  }
}
