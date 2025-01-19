import 'package:blueberry_edu/publishing_1/widget/calendar/non_responsive_calendar.dart';
import 'package:blueberry_edu/publishing_1/widget/calendar/responsive_calendar.dart';
import 'package:blueberry_edu/publishing_1/widget/post/bottombar/blog_bottombar.dart';
import 'package:blueberry_edu/publishing_1/widget/post/bottombar/social_bottombar.dart';
import 'package:blueberry_edu/publishing_1/widget/post/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          home: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    spacing: 20.w,
                    children: [
                      NonResponsiveCalendar(),
                      ResponsiveCalendar(),
                      PostCard(
                        profileImage: "https://picsum.photos/200",
                        username: "사용자명",
                        content: "내용",
                        bottomBar: SocialBottomBar(
                          likeCount: 100,
                          commentCount: 50,
                          onLikeTap: () {},
                          onCommentTap: () {},
                          onShareTap: () {},
                        ),
                      ),
                      PostCard(
                        profileImage: "https://picsum.photos/200",
                        username: "사용자명",
                        content: "내용",
                        bottomBar: BlogBottomBar(
                          readTime: "5분",
                          isBookmarked: true,
                          onBookmarkTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
