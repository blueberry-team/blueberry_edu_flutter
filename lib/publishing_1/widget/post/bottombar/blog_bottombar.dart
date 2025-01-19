import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlogBottomBar extends StatelessWidget {
  final String readTime;
  final bool isBookmarked;
  final VoidCallback? onBookmarkTap;

  const BlogBottomBar({
    super.key,
    required this.readTime,
    this.isBookmarked = false,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.access_time, size: 16.w, color: Colors.grey[600]),
            SizedBox(width: 4.w),
            Text(
              readTime,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: onBookmarkTap,
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            size: 20.w,
            color: isBookmarked ? Colors.blue : Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
