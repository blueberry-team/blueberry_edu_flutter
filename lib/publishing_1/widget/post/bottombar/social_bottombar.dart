import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialBottomBar extends StatelessWidget {
  final VoidCallback? onLikeTap;
  final VoidCallback? onCommentTap;
  final VoidCallback? onShareTap;
  final int likeCount;
  final int commentCount;

  const SocialBottomBar({
    super.key,
    this.onLikeTap,
    this.onCommentTap,
    this.onShareTap,
    this.likeCount = 0,
    this.commentCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onLikeTap,
          child: Row(
            children: [
              Icon(Icons.favorite_border, size: 20.w, color: Colors.grey[600]),
              SizedBox(width: 4.w),
              Text(
                likeCount.toString(),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16.w),
        InkWell(
          onTap: onCommentTap,
          child: Row(
            children: [
              Icon(Icons.chat_bubble_outline,
                  size: 20.w, color: Colors.grey[600]),
              SizedBox(width: 4.w),
              Text(
                commentCount.toString(),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16.w),
        InkWell(
          onTap: onShareTap,
          child: Icon(Icons.share, size: 20.w, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
