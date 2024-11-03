import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_flutter/common_ui/web/webview_page.dart';
import 'package:wan_android_flutter/common_ui/web/webview_widget.dart';
import 'package:wan_android_flutter/pages/search/search_view_model.dart';
import 'package:wan_android_flutter/repository/model/search_list_model.dart';
import 'package:wan_android_flutter/route/RouteUtils.dart';
import '../../common_ui/common_styles.dart';
import '../../repository/model/home_list_model.dart';

///搜索页
class SearchPage extends StatefulWidget {
  final String? keyWord;
  final String? type;

  //const SearchPage({super.key, this.keyWord});
  const SearchPage({super.key, this.keyWord, this.type});

  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  SearchViewModel viewModel = SearchViewModel();
  TextEditingController? _editController;
  bool switchValue = false; // 将 switchValue 初始化为关闭状态
  //魔改版数据需求
  late RefreshController _refreshController;



  @override
  void initState() {
    _editController = TextEditingController(text: widget.keyWord ?? "");
    super.initState();
    //查找新列表
    viewModel.searchReList(widget.keyWord, widget.type);
    //查找老列表
    viewModel.searchList(widget.keyWord);
    //魔改版初始化需求
    _refreshController = RefreshController(initialRefresh: false);
    viewModel.initDataList(false);
  }
  //魔改版管理数据列表的刷新和加载操作
  void refreshOrLoad(bool loadMore) {
    viewModel.initDataList(loadMore, complete: (loadMore) {
      if (loadMore) {
        _refreshController.loadComplete();
      } else {
        _refreshController.refreshCompleted();
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _searchBar(
                onSubmitted: (value) {
                  if (!value.trim().isNotEmpty) {
                    showToast("输入不可以为空啊！");
                    return;
                  }
                  viewModel.searchList(value);
                  viewModel.searchReList(value, switchValue ? "true" : "false");
                },
                onTapCancel: () {
                  viewModel.clearList();
                  //print("这有用吗？？？"); 此点击事件停用了
                },
                onTapFinish: () {
                  Navigator.pop(context);
                },
              ),
              //搜索结果展示
              // _searchResultsView(
              //   onItemTap: (item) {
              //     RouteUtils.push(
              //       context,
              //       WebViewPage(
              //         loadResource: item?.link ?? "",
              //         title: item?.title,
              //         showTitle: true,
              //         webViewType: WebViewType.URL,
              //       ),
              //     );
              //   },
              // ),
              //魔改版数据列表呈现
              Consumer<SearchViewModel>(builder: (context, value, child) {
                return Expanded(child: ListView.builder(
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.listData?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      HomeListItemData? item = value.listData?[index];
                      return _listItem(
                        item: item,
                        onItemClick: () {
                          //进入网页
                          RouteUtils.push(
                              context,
                              WebViewPage(
                                  loadResource: item?.link ?? "",
                                  webViewType: WebViewType.URL,
                                  showTitle: true,
                                  title: item?.title));
                        },
                        // imageClick: () {
                        //   if (item?.collect == true) {
                        //     //取消收藏
                        //     model.cancelCollect(index, "${item?.id}");
                        //   } else {
                        //     //收藏
                        //     model.collect(index, "${item?.id}");
                        //   }
                        // }
                      );
                    }));
              })

            ],
          ),
        ),
      ),
    );
  }

  //魔改版listview中的函数实现
  Widget _listItem(
      {HomeListItemData? item, GestureTapCallback? onItemClick}) {
    return GestureDetector(
        onTap: onItemClick,
        child: Container(
            margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.r)),
                border: Border.all(color: Colors.black26)),
            width: double.infinity,
            padding: EdgeInsets.all(15.r),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(25.r),
                    child: Image.asset("assets/images/luoxiaohei.png",
                        width: 25.r, height: 25.r, fit: BoxFit.fill)),
                SizedBox(width: 5.w),
                normalText(item?.author),
                const Expanded(child: SizedBox()),
                normalText(item?.niceShareDate),
                SizedBox(
                  width: 10.w,
                ),
                Text(item?.type == 1 ? "置顶" : "",
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.blueAccent))
              ]),
              SizedBox(height: 5.h),
              Text(
                item?.title ?? "",
                style: titleTextStyle15,
              ),
              SizedBox(height: 5.h),
              Row(children: [
                Text(
                  item?.chapterName ?? "",
                  style: TextStyle(fontSize: 13.sp, color: Colors.green),
                ),
              ])
            ])));
  }

  Widget _searchBar({
    ValueChanged<String>? onSubmitted,
    GestureTapCallback? onTapCancel,//停用
    GestureTapCallback? onTapFinish,
  }) {
    return Container(
      color: Colors.teal,
      height: 50.h,
      child: Row(
        children: [
          SizedBox(width: 5.w),
          GestureDetector(
            onTap: onTapFinish,
            child: Image.asset(
              "assets/images/icon_back.png",
              width: 30.r,
              height: 30.r,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: TextField(
                textAlign: TextAlign.justify,
                controller: _editController,
                style: titleTextStyle15,
                decoration: _inputDecoration(),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onSubmitted: onSubmitted,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          _switch(),
          SizedBox(width: 10.w),
          // GestureDetector(
          //   onTap: onTapCancel,
          //   child: Text("取消", style: whiteTextStyle15),
          // ),
          // SizedBox(width: 15.w),
        ],
      ),
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.only(left: 10.w),
      fillColor: Colors.white,
      filled: true,
      enabledBorder: _inputBorder(),
      focusedBorder: _inputBorder(),
      border: _inputBorder(),
    );
  }

  Widget _searchResultsView({ValueChanged<SearchListItemModel?>? onItemTap}) {
    return Selector<SearchViewModel, List<SearchListItemModel>?>(
      builder: (context, value, child) {
        return Expanded(
          child: ListView.builder(
            itemCount: value?.length ?? 0,
            itemBuilder: (context, index) {
              var item = value?[index];
              return _resultItem(item, onItemTap: () {
                onItemTap?.call(item);
              });
            },
          ),
        );
      },
      selector: (context, vm) {
        return vm.dataList;//展示的数据就是viewModel的dataList
      },
    );
  }


  Widget _resultItem(SearchListItemModel? item, {GestureTapCallback? onItemTap}) {
    return GestureDetector(
      onTap: onItemTap,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 15.w, top: 10.h, bottom: 10.h),
        width: double.infinity,
        child: Html(
          data: item?.title ?? "",
          style: {
            "html": Style(fontSize: FontSize(15.sp)),
          },
        ),
      ),
    );
  }

  Widget _switch() {
    return Switch(
      value: switchValue,
      activeColor: Colors.white,
      activeTrackColor: Colors.blue,
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: Colors.teal,
      onChanged: (value) {
        setState(() {
          switchValue = value; // 更新 switchValue 的值
        });
      },
    );
  }
}
