import 'package:better_player/better_player.dart';
import 'package:demo/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
class AdminCourses extends StatefulWidget {
  static final String routeName = '/admin-courses';
  final List videoURLs = Get.arguments['videoURLs'];
  final List videosNames = Get.arguments['videosNames'];
  final String courseID = Get.arguments['coursID'];
  final List<BetterPlayerController> videos = Get.arguments['videos'];

  @override
  State<AdminCourses> createState() => _AdminCoursesState();
}

class _AdminCoursesState extends State<AdminCourses> {

    @override
  void dispose() {
    dis();
    super.dispose();
  }

  void dis() {
    for (BetterPlayerController video in widget.videos) {
      video.dispose();
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    for (BetterPlayerController video in widget.videos) {
      if (video.isVideoInitialized() ?? false) await video.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARYCOLOR,
        elevation: 0.0,
        title: Text(
          widget.courseID,
          style: TextStyle(
            color: SECONDARYCOLOR,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: PRIMARYCOLOR,
      body: SingleChildScrollView(child: videosPlayer(context),),
    );
  }
   Column videosPlayer(BuildContext context) => Column(
        children: widget.videoURLs
            .map(
              (video) => Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: BetterPlayer(
                      controller: widget.videos
                          .elementAt(widget.videoURLs.indexOf(video)),
                    ),
                   
                  ),
                  Text(
                    widget.videosNames
                        .elementAt(widget.videoURLs.indexOf(video)),
                    style: TextStyle(
                      color: SECONDARYCOLOR,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 50.0,
                    child: AdWidget(
                      ad: BannerAd(
                        size: AdSize.banner,
                        adUnitId: bannerAdUnitId,
                        listener: BannerAdListener(
                          onAdClosed: (ad) async => await ad.dispose(),
                        ),
                        request: AdRequest(),
                      )..load(),
                    ),
                  ),
                  Divider(
                    color: SECONDARYCOLOR,
                    endIndent: 5,
                    indent: 10,
                  ),
                ],
              ),
            )
            .toList(),
      );

}