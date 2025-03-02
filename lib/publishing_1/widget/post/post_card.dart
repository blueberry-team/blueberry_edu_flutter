import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCard extends StatelessWidget {
  final String profileImage;
  final String username;
  final String content;
  final List<String>? images;
  final Widget? bottomBar;

  const PostCard({
    super.key,
    required this.profileImage,
    required this.username,
    required this.content,
    this.images,
    this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: CachedNetworkImageProvider(profileImage),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  username,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            content,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.4,
            ),
          ),
          if (images != null && images!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: images!
                    .map(
                      (url) => Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: CachedNetworkImage(
                            imageUrl: url,
                            width: 120.w,
                            height: 120.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
          if (bottomBar != null) ...[
            SizedBox(height: 12.h),
            bottomBar!,
          ],
        ],
      ),
    );
  }
}
