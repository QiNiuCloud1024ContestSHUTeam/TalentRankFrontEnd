import 'dart:async';
import 'dart:developer';


class BannerLogic {
  //初始化状态数据
  final BannerState state = BannerState();

  //获取流控制器
  final _controller = StreamController<BannerState>.broadcast(onListen: () {
    log("BannerLogic _controller onListen");
  }, onCancel: () {
    log("BannerLogic _controller onCancel");
  });

  //获取流控制器正在控制的流
  Stream<BannerState> getStream() {
    return _controller.stream;
  }

  ///德国T10并机推广-获取Banner列表
  Future getBannerList() async {
    // try {
    //   ActivityListBannerModel? bannerModel = await ActivityAPI.getAdvertisementBanner();
    //   state.bannerList = bannerModel?.list;
    // } catch (error) {
    //   state.bannerList = [];
    // }
    // _controller.add(state);
  }

  //需要在state-》dispose中调用
  void dispose() {
    _controller.close();
  }
}

class BannerState {
  // List<ActivityBannerModel?>? bannerList = [];
}
