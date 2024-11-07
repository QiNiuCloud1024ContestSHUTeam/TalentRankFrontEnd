/// data : {"total":166,"rows":[{"topicId":1,"topicName":"3d"},{"topicId":2,"topicName":"ajax"},{"topicId":3,"topicName":"algorithm"},{"topicId":4,"topicName":"amphp"},{"topicId":5,"topicName":"android"},{"topicId":6,"topicName":"angular"},{"topicId":7,"topicName":"ansible"},{"topicId":8,"topicName":"api"},{"topicId":9,"topicName":"arduino"},{"topicId":10,"topicName":"aspnet"},{"topicId":11,"topicName":"awesome"},{"topicId":12,"topicName":"aws"},{"topicId":13,"topicName":"azure"},{"topicId":14,"topicName":"babel"},{"topicId":15,"topicName":"bash"},{"topicId":16,"topicName":"bitcoin"}]}

class SearchAllkeyModel {
  SearchAllkeyModel({
      this.data,});

  SearchAllkeyModel.fromJson(dynamic json) {
    data = json['data'] != null ? AllKeyModel.fromJson(json['data']) : null;
  }
  AllKeyModel? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// total : 166
/// rows : [{"topicId":1,"topicName":"3d"},{"topicId":2,"topicName":"ajax"},{"topicId":3,"topicName":"algorithm"},{"topicId":4,"topicName":"amphp"},{"topicId":5,"topicName":"android"},{"topicId":6,"topicName":"angular"},{"topicId":7,"topicName":"ansible"},{"topicId":8,"topicName":"api"},{"topicId":9,"topicName":"arduino"},{"topicId":10,"topicName":"aspnet"},{"topicId":11,"topicName":"awesome"},{"topicId":12,"topicName":"aws"},{"topicId":13,"topicName":"azure"},{"topicId":14,"topicName":"babel"},{"topicId":15,"topicName":"bash"},{"topicId":16,"topicName":"bitcoin"}]

// class AllKeyModel {
//
//   num? total;
//   List<Topic>? rows;
//
//   AllKeyModel({
//       this.total,
//       this.rows,});
//
//   AllKeyModel.fromJson(dynamic json) {
//     total = json['total'];
//     if (json['rows'] is List) {
//       for(var topicItem in json['rows']) {
//         rows?.add(Topic.fromJson(topicItem));
//       }
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['total'] = total;
//     if (rows != null) {
//       map['rows'] = rows?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }

class AllKeyModel {

  num? total;
  List<Topic> rows = []; // 初始化为空的列表

  AllKeyModel({
    this.total,
    this.rows = const [], // 给构造函数提供默认值
  });

  AllKeyModel.fromJson(dynamic json) {
    total = json['total'];
    if (json['rows'] is List) {
      rows = (json['rows'] as List).map((topicItem) => Topic.fromJson(topicItem)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['rows'] = rows.map((v) => v.toJson()).toList();
    return map;
  }

}


/// topicId : 1
/// topicName : "3d"

class Topic {
  Topic({
      this.topicId, 
      this.topicName,});

  Topic.fromJson(dynamic json) {
    topicId = json['topicId'];
    topicName = json['topicName'];
  }
  int? topicId;
  String? topicName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['topicId'] = topicId;
    map['topicName'] = topicName;
    return map;
  }

}