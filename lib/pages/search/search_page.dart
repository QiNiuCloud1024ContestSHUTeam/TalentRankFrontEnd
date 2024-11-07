import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_flutter/common_ui/web/webview_page.dart';
import 'package:wan_android_flutter/pages/search/search_view_model.dart';
import 'package:wan_android_flutter/repository/model/home_list_model.dart';
import '../../common_ui/common_styles.dart';
import '../../common_ui/web/webview_widget.dart';
import '../../repository/model/rank_information_model.dart';
import '../../route/RouteUtils.dart';

/// 搜索页
class SearchPage extends StatefulWidget {
  final int? topicId;
  final String? nation;
  final String? q;
  final String? user;



  const SearchPage({this.topicId, this.nation, this.q, this.user});



  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  SearchViewModel viewModel = SearchViewModel();
  TextEditingController? _editController;
  late RefreshController _refreshController;

  //搜索条件选择更新
  bool selectedFilter = false; // 默认选择 '领域'
  String selectedArea = ""; // 默认选择地区为'无'


  // 新增一个列表来保存每个 item 的展开状态
  List<bool> _isExpanded = [];

  late int type;


  @override
  @override
  void initState() {
    super.initState();

    _editController = TextEditingController(text: widget.q ?? "");
    _refreshController = RefreshController(initialRefresh: false);

    if (widget.topicId != null) {
      _loadRankListById(widget.topicId!);
    }
  }

  Future<void> _loadRankListById(int topicId) async {
    final result = await viewModel.searchReById(topicId);
    if (result != null) {
      setState(() {
        viewModel.RankList = result;
      });
    }
  }


  void refreshOrLoad(bool loadMore) {
    viewModel.initDataList();
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
                onSubmitted: (value) async {
                  if (!value.trim().isNotEmpty) {
                    showToast("输入不可以为空啊！");
                    return;
                  }
                  // viewModel.searchList(value);
                  if(selectedFilter){
                    type=1;
                    viewModel.RankList = await viewModel.searchReByUser(
                      value
                    ) as List<ScoreUserList>;
                  }else{
                    type=2;
                    viewModel.RankList = await viewModel.searchReByQ(
                      value,
                      selectedArea,  // 传递选定的地区
                    ) as List<ScoreUserList>;
                  }
                },
                onTapFinish: () {
                  Navigator.pop(context);
                },
              ),
              Consumer<SearchViewModel>(
                builder: (context, value, child) {
                  return Expanded(
                    child: SmartRefresher(
                      controller: _refreshController,  // 控制器
                      enablePullUp: true,  // 启用上拉加载
                      onLoading: () {
                        // 上拉加载回调
                        refreshOrLoad(true);
                      },
                      child: ListView.builder(
                        itemCount: value.RankList?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          ScoreUserList? item = value.RankList?[index];
                          if (_isExpanded.length <= index) {
                            _isExpanded.add(false);
                          }
                          return _listItem(
                            item: item,
                            isExpanded: _isExpanded[index],
                            onExpandToggle: () {
                              setState(() {
                                _isExpanded[index] = !_isExpanded[index];
                              });
                            },
                            onItemClick: () {
                              RouteUtils.push(
                                context,
                                WebViewPage(
                                  loadResource: item?.htmlUrl ?? "",
                                  webViewType: WebViewType.URL,
                                  showTitle: true,
                                  title: item?.login,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _listItem({
    ScoreUserList? item,
    required bool isExpanded, // 接收展开状态
    required VoidCallback onExpandToggle, // 接收切换展开状态的回调
    GestureTapCallback? onItemClick,
  }) {
    return GestureDetector(
      onTap: onItemClick,
      child: Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.r)),
          border: Border.all(color: Colors.black26),
        ),
        width: double.infinity,
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h, bottom: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: Image.network(
                    item?.avatarUrl ?? '',
                    width: 80.r,
                    height: 80.r,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item?.login}", // 显示 item?.author，如果为空则显示空字符串
                    style: TextStyle(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.bold),  // 设置样式
                  ),
                  Text("nation:${item?.nation ?? ""}",style: TextStyle(color: Colors.black, fontSize: 15.sp),),
                  Text("置信度：${item?.confidence}",style: TextStyle(color: Colors.black, fontSize: 15.sp),),
                  Text("followers:${item?.followers ?? ""}",style: TextStyle(color: Colors.black, fontSize: 15.sp),),
                  Text("following:${item?.following ?? ""}",style: TextStyle(color: Colors.black, fontSize: 15.sp),),
                ],
                ),
                const Expanded(child: SizedBox()),
                InkWell(
                  onTap: onExpandToggle,
                  borderRadius: BorderRadius.circular(25),  // 设置圆形点击区域
                  child: Container(
                    padding: EdgeInsets.all(0.5),  // 设置较小的内边距
                    child: Icon(
                      isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      size: 30,
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 5.h),
            Row(children: [
               Column(
                  children: [
                Text(
                  "${item?.topicScore ?? ""}",
                  style: TextStyle(fontSize: 28,color: Colors.red),

                ),
              ]),
              SizedBox(width: 35.w),
              Expanded(
                child: Text(
                  "个人简介：${item?.bio}",
                  style: TextStyle(fontSize: 18),
                  softWrap: true,  // 自动换行
                ),
              )

            ],),

            SizedBox(height: 5.h),
            if (isExpanded) // 仅在展开时添加额外内容
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                    "blog：${item?.blog}",
                    style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "所属公司：${item?.company}",
                    style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                  ),
                ],)
              ),
          ],
        ),
      ),
    );
  }


  Widget _searchBar({
    ValueChanged<String>? onSubmitted,
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
          _filterIcon(),
          SizedBox(width: 10.w),
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

  Widget _filterIcon() {
    return IconButton(
      icon: Icon(Icons.filter_list, color: Colors.white),
      onPressed: () {
        _showFilterDialog();
      },
    );
  }

  void _showFilterDialog() {
    // 保存初始的筛选条件值，用于重置
    bool initialFilter = selectedFilter;
    String initialArea = selectedArea;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("选择筛选条件"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('领域'),
                    leading: Radio<bool>(
                      value: false,  // 领域对应 false
                      groupValue: selectedFilter,  // 确保 groupValue 是 bool 类型
                      onChanged: (value) {
                        setState(() {
                          selectedFilter = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('开发者'),
                    leading: Radio<bool>(
                      value: true,  // 开发者对应 true
                      groupValue: selectedFilter,  // groupValue 是 bool 类型
                      onChanged: (value) {
                        setState(() {
                          selectedFilter = value!;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,  // 控制主轴方向的对齐方式
                    children: [
                      Text(
                        '地区',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600), // 你可以调整字体样式
                      ),
                      SizedBox(width: 10.w),  // 增加间距
                      Expanded(
                        child: Text(
                          selectedArea == "" ? "" : selectedArea,  // 显示选择的地区
                          style: TextStyle(fontSize: 14.sp, color: Colors.black87), // 根据需要调整样式
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          _showAreaPicker(setState);  // 将 setState 传递给 _showAreaPicker
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                // 使用 Row 来确保按钮均分
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,  // 确保按钮居中
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedFilter = false;
                            selectedArea = "";
                          });
                        },
                        child: Text("重置"),
                      ),
                    ),
                    SizedBox(width: 10),  // 添加间距，让按钮之间有一点距离
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context); // 关闭对话框
                        },
                        child: Text("确认"),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

// 展示地区选择框，并添加返回按钮
  void _showAreaPicker(StateSetter setState) async {
    List<String> areas = [
      'None',
      'Afghanistan',
      'Albania',
      'Algeria',
      'Andorra',
      'Angola',
      'Antigua and Barbuda',
      'Argentina',
      'Armenia',
      'Australia',
      'Austria',
      'Azerbaijan',
      'Bahamas',
      'Bahrain',
      'Bangladesh',
      'Barbados',
      'Belarus',
      'Belgium',
      'Belize',
      'Benin',
      'Bhutan',
      'Bolivia',
      'Bosnia and Herzegovina',
      'Botswana',
      'Brazil',
      'Brunei Darussalam',
      'Bulgaria',
      'Burkina Faso',
      'Burundi',
      'Cabo Verde',
      'Cambodia',
      'Cameroon',
      'Canada',
      'Central African Republic',
      'Chad',
      'Chile',
      'China',
      'Colombia',
      'Comoros',
      'Congo (Congo-Brazzaville)',
      'Costa Rica',
      'Croatia',
      'Cuba',
      'Cyprus',
      'Czechia (Czech Republic)',
      'Democratic People\'s Republic of Korea (North Korea)',
      'Democratic Republic of the Congo (Congo-Kinshasa)',
      'Denmark',
      'Djibouti',
      'Dominica',
      'Dominican Republic',
      'Ecuador',
      'Egypt',
      'El Salvador',
      'Equatorial Guinea',
      'Eritrea',
      'Estonia',
      'Eswatini (formerly Swaziland)',
      'Ethiopia',
      'Fiji',
      'Finland',
      'France',
      'Gabon',
      'Gambia',
      'Georgia',
      'Germany',
      'Ghana',
      'Greece',
      'Grenada',
      'Guatemala',
      'Guinea',
      'Guinea-Bissau',
      'Guyana',
      'Haiti',
      'Honduras',
      'Hungary',
      'Iceland',
      'India',
      'Indonesia',
      'Iran',
      'Iraq',
      'Ireland',
      'Israel',
      'Italy',
      'Jamaica',
      'Japan',
      'Jordan',
      'Kazakhstan',
      'Kenya',
      'Kiribati',
      'Kuwait',
      'Kyrgyzstan',
      'Lao People\'s Democratic Republic (Laos)',
      'Latvia',
      'Lebanon',
      'Lesotho',
      'Liberia',
      'Libya',
      'Liechtenstein',
      'Lithuania',
      'Luxembourg',
      'Madagascar',
      'Malawi',
      'Malaysia',
      'Maldives',
      'Mali',
      'Malta',
      'Marshall Islands',
      'Mauritania',
      'Mauritius',
      'Mexico',
      'Micronesia (Federated States of)',
      'Moldova',
      'Monaco',
      'Mongolia',
      'Montenegro',
      'Morocco',
      'Mozambique',
      'Myanmar (formerly Burma)',
      'Namibia',
      'Nauru',
      'Nepal',
      'Netherlands',
      'New Zealand',
      'Nicaragua',
      'Niger',
      'Nigeria',
      'North Macedonia (formerly Macedonia)',
      'Norway',
      'Oman',
      'Pakistan',
      'Palau',
      'Panama',
      'Papua New Guinea',
      'Paraguay',
      'Peru',
      'Philippines',
      'Poland',
      'Portugal',
      'Qatar',
      'Romania',
      'Russian Federation (Russia)',
      'Rwanda',
      'Saint Kitts and Nevis',
      'Saint Lucia',
      'Saint Vincent and the Grenadines',
      'Samoa',
      'San Marino',
      'Sao Tome and Principe',
      'Saudi Arabia',
      'Senegal',
      'Serbia',
      'Seychelles',
      'Sierra Leone',
      'Singapore',
      'Slovakia',
      'Slovenia',
      'Solomon Islands',
      'Somalia',
      'South Africa',
      'South Sudan',
      'Spain',
      'Sri Lanka',
      'State of Palestine',
      'Sudan',
      'Suriname',
      'Sweden',
      'Switzerland',
      'Syrian Arab Republic (Syria)',
      'Tajikistan',
      'Thailand',
      'Timor-Leste',
      'Togo',
      'Tonga',
      'Trinidad and Tobago',
      'Tunisia',
      'Turkey',
      'Turkmenistan',
      'Tuvalu',
      'Uganda',
      'Ukraine',
      'United Arab Emirates',
      'United Kingdom',
      'United States of America',
      'Uruguay',
      'Uzbekistan',
      'Vanuatu',
      'Venezuela',
      'Viet Nam (Vietnam)',
      'Yemen',
      'Zambia',
      'Zimbabwe'
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context); // 返回到筛选条件框
                },
              ),
              Text("选择地区"),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: areas
                  .map((area) => ListTile(
                title: Text(area),
                onTap: () {
                  setState(() {
                    selectedArea = area; // 更新选择的地区
                  });
                  Navigator.pop(context);  // 选择完地区后返回
                },
              ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

}
