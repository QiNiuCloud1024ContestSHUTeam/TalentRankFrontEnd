import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import 'banner_logic.dart';

abstract class BaseBannerController {
  void reload(bool load);
}

class BannerController extends BaseBannerController {
  BannerLogic? logic;

  @override
  void reload(bool load) {
    logic?.getBannerList();
  }

  void initState() {
    //组件初始化阶段获取数据
    logic ??= BannerLogic();
    logic?.getBannerList();
  }

  void dispose() {
    logic?.dispose();
  }
}

///活动图片轮播图组件：目前只在德国T10推广场景中出现，没有数据默认占位20.h
class ActivityBannerWidget extends StatefulWidget {
  const ActivityBannerWidget({
    super.key,
    this.itemClick,
    required this.controller,
  });

  final ValueChanged<String?>? itemClick;
  final BannerController? controller;

  @override
  State<StatefulWidget> createState() {
    return _ActivityBannerWidgetState();
  }
}

class _ActivityBannerWidgetState extends State<ActivityBannerWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller?.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: widget.controller?.logic?.state,
        stream: widget.controller?.logic?.getStream(),
        builder: (context, AsyncSnapshot<BannerState> snapshot) {
          // if (snapshot.data?.bannerList == null || snapshot.data?.bannerList?.isEmpty == true) {
          //   return SizedBox(height: 20.h);
          // }
          return Container(
              width: double.infinity,
              height: 100.h,
              margin: EdgeInsets.only(left: 23.w, right: 23.w, top: 20.h, bottom: 20.h),
              child: Swiper(
                autoplayDelay: 5000,
                duration: 800,
                autoplay: true,
                // pagination: const SwiperPagination(),
                control: SwiperControl(size: 15.r),
                autoplayDisableOnInteraction: false,
                onTap: (int index) {
                  // var url = snapshot.data?.bannerList?[index]?.outUrl ?? "";
                  //
                  // log("ActivityBannerWidget banner点击 地址=$url");
                  // widget.itemClick?.call(url);
                },
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.r)),
                      child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          placeholder: (context, url) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          imageUrl: ""));
                },
                itemCount:  0,
              ));
        });
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }
}
