import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveCalendar extends StatelessWidget {
  const ResponsiveCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20.w,
                ),
                onPressed: () {},
              ),
              Text(
                '2024년 1월',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 20.w,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: ['일', '월', '화', '수', '목', '금', '토']
                .map((day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 8.h),
          ...List.generate(
            6,
            (weekIndex) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                children: List.generate(
                  7,
                  (dayIndex) => Expanded(
                    child: Container(
                      height: 36.w,
                      margin: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${weekIndex * 7 + dayIndex + 1}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[800],
                          ),
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
    );
  }
}
