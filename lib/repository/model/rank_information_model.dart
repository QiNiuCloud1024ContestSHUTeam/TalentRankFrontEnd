/// data : {"total":89,"scoreUserList":[{"topicScore":6.057591996187196,"login":"mrdoob","id":97088,"nodeId":"MDQ6VXNlcjk3MDg4","avatarUrl":"https://avatars.githubusercontent.com/u/97088?v=4","gravatarId":"","url":"https://api.github.com/users/mrdoob","htmlUrl":"https://github.com/mrdoob","followersUrl":"https://api.github.com/users/mrdoob/followers","followingUrl":"https://api.github.com/users/mrdoob/following{/other_user}","gistsUrl":"https://api.github.com/users/mrdoob/gists{/gist_id}","starredUrl":"https://api.github.com/users/mrdoob/starred{/owner}{/repo}","subscriptionsUrl":"https://api.github.com/users/mrdoob/subscriptions","organizationsUrl":"https://api.github.com/users/mrdoob/orgs","reposUrl":"https://api.github.com/users/mrdoob/repos","eventsUrl":"https://api.github.com/users/mrdoob/events{/privacy}","receivedEventsUrl":"https://api.github.com/users/mrdoob/received_events","type":"User","userViewType":"public","siteAdmin":false,"name":null,"company":null,"blog":"https://mrdoob.com","location":null,"email":null,"hireable":false,"bio":null,"twitterUsername":"mrdoob","publicRepos":42,"publicGists":70,"followers":23457,"following":187,"createdAt":"2009-06-19T08:54:00.000+00:00","updatedAt":"2024-10-31T12:04:59.000+00:00","nation":"unkown","confidence":null}],"userIdToReposMap":{"97088":[{"id":576201,"nodeId":"MDEwOlJlcG9zaXRvcnk1NzYyMDE=","name":"three.js","fullName":"mrdoob/three.js","privateFlag":false,"htmlUrl":"https://github.com/mrdoob/three.js","description":"JavaScript 3D Library.","fork":false,"url":"https://api.github.com/repos/mrdoob/three.js","languagesUrl":"https://api.github.com/repos/mrdoob/three.js/languages","createdAt":"2010-03-23 18:58:01","updatedAt":"2024-10-31 13:52:26","pushedAt":"2024-10-31 12:22:25","gitUrl":"git://github.com/mrdoob/three.js.git","sshUrl":"git@github.com:mrdoob/three.js.git","cloneUrl":"https://github.com/mrdoob/three.js.git","homepage":"https://threejs.org/","stargazersCount":102475,"language":"JavaScript","hasIssues":true,"forksCount":35364,"openIssuesCount":522,"allowForking":true,"visibility":"public","score":10.238355396634983}]}}

class RankInformationModel {
  RankInformationModel({
      this.data,});

  RankInformationModel.fromJson(dynamic json) {
    data = json['data'] != null ? UserDatum.fromJson(json['data']) : null;
  }
  UserDatum? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// total : 89
/// scoreUserList : [{"topicScore":6.057591996187196,"login":"mrdoob","id":97088,"nodeId":"MDQ6VXNlcjk3MDg4","avatarUrl":"https://avatars.githubusercontent.com/u/97088?v=4","gravatarId":"","url":"https://api.github.com/users/mrdoob","htmlUrl":"https://github.com/mrdoob","followersUrl":"https://api.github.com/users/mrdoob/followers","followingUrl":"https://api.github.com/users/mrdoob/following{/other_user}","gistsUrl":"https://api.github.com/users/mrdoob/gists{/gist_id}","starredUrl":"https://api.github.com/users/mrdoob/starred{/owner}{/repo}","subscriptionsUrl":"https://api.github.com/users/mrdoob/subscriptions","organizationsUrl":"https://api.github.com/users/mrdoob/orgs","reposUrl":"https://api.github.com/users/mrdoob/repos","eventsUrl":"https://api.github.com/users/mrdoob/events{/privacy}","receivedEventsUrl":"https://api.github.com/users/mrdoob/received_events","type":"User","userViewType":"public","siteAdmin":false,"name":null,"company":null,"blog":"https://mrdoob.com","location":null,"email":null,"hireable":false,"bio":null,"twitterUsername":"mrdoob","publicRepos":42,"publicGists":70,"followers":23457,"following":187,"createdAt":"2009-06-19T08:54:00.000+00:00","updatedAt":"2024-10-31T12:04:59.000+00:00","nation":"unkown","confidence":null}]
/// userIdToReposMap : {"97088":[{"id":576201,"nodeId":"MDEwOlJlcG9zaXRvcnk1NzYyMDE=","name":"three.js","fullName":"mrdoob/three.js","privateFlag":false,"htmlUrl":"https://github.com/mrdoob/three.js","description":"JavaScript 3D Library.","fork":false,"url":"https://api.github.com/repos/mrdoob/three.js","languagesUrl":"https://api.github.com/repos/mrdoob/three.js/languages","createdAt":"2010-03-23 18:58:01","updatedAt":"2024-10-31 13:52:26","pushedAt":"2024-10-31 12:22:25","gitUrl":"git://github.com/mrdoob/three.js.git","sshUrl":"git@github.com:mrdoob/three.js.git","cloneUrl":"https://github.com/mrdoob/three.js.git","homepage":"https://threejs.org/","stargazersCount":102475,"language":"JavaScript","hasIssues":true,"forksCount":35364,"openIssuesCount":522,"allowForking":true,"visibility":"public","score":10.238355396634983}]}

class UserDatum {
  UserDatum({
      this.total, 
      this.scoreUserList,
      this.userIdToReposMap
  });

  UserDatum.fromJson(dynamic json) {
    total = json['total'];
    if (json['scoreUserList'] != null) {
      scoreUserList = [];
      json['scoreUserList'].forEach((v) {
        scoreUserList?.add(ScoreUserList.fromJson(v));
      });
    }

    if(json['userIdToReposMap'] != null) {
      userIdToReposMap = {};
      json['userIdToReposMap'].forEach((key, value) {
        int userId = int.parse(key);
        List<Repo> repos = (value as List).map((v) => Repo.fromJson(v)).toList();
        userIdToReposMap?[userId] = repos;
      });
    }
  }
  num? total;
  List<ScoreUserList>? scoreUserList;
  Map<int, List<Repo>>? userIdToReposMap;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    if (scoreUserList != null) {
      map['scoreUserList'] = scoreUserList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
/// topicScore : 6.057591996187196
/// login : "mrdoob"
/// id : 97088
/// nodeId : "MDQ6VXNlcjk3MDg4"
/// avatarUrl : "https://avatars.githubusercontent.com/u/97088?v=4"
/// gravatarId : ""
/// url : "https://api.github.com/users/mrdoob"
/// htmlUrl : "https://github.com/mrdoob"
/// followersUrl : "https://api.github.com/users/mrdoob/followers"
/// followingUrl : "https://api.github.com/users/mrdoob/following{/other_user}"
/// gistsUrl : "https://api.github.com/users/mrdoob/gists{/gist_id}"
/// starredUrl : "https://api.github.com/users/mrdoob/starred{/owner}{/repo}"
/// subscriptionsUrl : "https://api.github.com/users/mrdoob/subscriptions"
/// organizationsUrl : "https://api.github.com/users/mrdoob/orgs"
/// reposUrl : "https://api.github.com/users/mrdoob/repos"
/// eventsUrl : "https://api.github.com/users/mrdoob/events{/privacy}"
/// receivedEventsUrl : "https://api.github.com/users/mrdoob/received_events"
/// type : "User"
/// userViewType : "public"
/// siteAdmin : false
/// name : null
/// company : null
/// blog : "https://mrdoob.com"
/// location : null
/// email : null
/// hireable : false
/// bio : null
/// twitterUsername : "mrdoob"
/// publicRepos : 42
/// publicGists : 70
/// followers : 23457
/// following : 187
/// createdAt : "2009-06-19T08:54:00.000+00:00"
/// updatedAt : "2024-10-31T12:04:59.000+00:00"
/// nation : "unkown"
/// confidence : null

class ScoreUserList {
  ScoreUserList({
      this.topicScore, 
      this.login, 
      this.id, 
      this.nodeId, 
      this.avatarUrl, 
      this.gravatarId, 
      this.url, 
      this.htmlUrl, 
      this.followersUrl, 
      this.followingUrl, 
      this.gistsUrl, 
      this.starredUrl, 
      this.subscriptionsUrl, 
      this.organizationsUrl, 
      this.reposUrl, 
      this.eventsUrl, 
      this.receivedEventsUrl, 
      this.type, 
      this.userViewType, 
      this.siteAdmin, 
      this.name, 
      this.company, 
      this.blog, 
      this.location, 
      this.email, 
      this.hireable, 
      this.bio, 
      this.twitterUsername, 
      this.publicRepos, 
      this.publicGists, 
      this.followers, 
      this.following, 
      this.createdAt, 
      this.updatedAt, 
      this.nation, 
      this.confidence,});

  ScoreUserList.fromJson(dynamic json) {
    topicScore = double.parse((json['topicScore'] as double).toStringAsFixed(1));
    login = json['login'];
    id = json['id'];
    nodeId = json['nodeId'];
    avatarUrl = json['avatarUrl'];
    gravatarId = json['gravatarId'];
    url = json['url'];
    htmlUrl = json['htmlUrl'];
    followersUrl = json['followersUrl'];
    followingUrl = json['followingUrl'];
    gistsUrl = json['gistsUrl'];
    starredUrl = json['starredUrl'];
    subscriptionsUrl = json['subscriptionsUrl'];
    organizationsUrl = json['organizationsUrl'];
    reposUrl = json['reposUrl'];
    eventsUrl = json['eventsUrl'];
    receivedEventsUrl = json['receivedEventsUrl'];
    type = json['type'];
    userViewType = json['userViewType'];
    siteAdmin = json['siteAdmin'];
    name = json['name'];
    company = json['company'];
    blog = json['blog'];
    location = json['location'];
    email = json['email'];
    hireable = json['hireable'];
    bio = json['bio'];
    twitterUsername = json['twitterUsername'];
    publicRepos = json['publicRepos'];
    publicGists = json['publicGists'];
    followers = json['followers'];
    following = json['following'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    nation = json['nation'];
    confidence = json['confidence'];
  }
  num? topicScore;
  String? login;
  num? id;
  String? nodeId;
  String? avatarUrl;
  String? gravatarId;
  String? url;
  String? htmlUrl;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? starredUrl;
  String? subscriptionsUrl;
  String? organizationsUrl;
  String? reposUrl;
  String? eventsUrl;
  String? receivedEventsUrl;
  String? type;
  String? userViewType;
  bool? siteAdmin;
  dynamic name;
  dynamic company;
  String? blog;
  dynamic location;
  dynamic email;
  bool? hireable;
  dynamic bio;
  String? twitterUsername;
  num? publicRepos;
  num? publicGists;
  num? followers;
  num? following;
  String? createdAt;
  String? updatedAt;
  String? nation;
  dynamic confidence;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['topicScore'] = topicScore;
    map['login'] = login;
    map['id'] = id;
    map['nodeId'] = nodeId;
    map['avatarUrl'] = avatarUrl;
    map['gravatarId'] = gravatarId;
    map['url'] = url;
    map['htmlUrl'] = htmlUrl;
    map['followersUrl'] = followersUrl;
    map['followingUrl'] = followingUrl;
    map['gistsUrl'] = gistsUrl;
    map['starredUrl'] = starredUrl;
    map['subscriptionsUrl'] = subscriptionsUrl;
    map['organizationsUrl'] = organizationsUrl;
    map['reposUrl'] = reposUrl;
    map['eventsUrl'] = eventsUrl;
    map['receivedEventsUrl'] = receivedEventsUrl;
    map['type'] = type;
    map['userViewType'] = userViewType;
    map['siteAdmin'] = siteAdmin;
    map['name'] = name;
    map['company'] = company;
    map['blog'] = blog;
    map['location'] = location;
    map['email'] = email;
    map['hireable'] = hireable;
    map['bio'] = bio;
    map['twitterUsername'] = twitterUsername;
    map['publicRepos'] = publicRepos;
    map['publicGists'] = publicGists;
    map['followers'] = followers;
    map['following'] = following;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['nation'] = nation;
    map['confidence'] = confidence;
    return map;
  }

  @override
  String toString() {
    return 'ScoreUserList(name: $name, score: $topicScore)';
  }
}

class RepoList {
  RepoList({
    this.repolist,});

  RepoList.fromJson(dynamic json) {
    if (json['repo'] != null) {
      repolist = [];
      json['repo'].forEach((v) {
        repolist?.add(Repo.fromJson(v));
      });
    }
  }
  List<Repo>? repolist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (repolist != null) {
      map['repo'] = repolist?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Repo {
  Repo({
    this.id,
    this.nodeId,
    this.name,
    this.fullName,
    this.privateFlag,
    this.htmlUrl,
    this.description,
    this.fork,
    this.url,
    this.languagesUrl,
    this.createdAt,
    this.updatedAt,
    this.pushedAt,
    this.gitUrl,
    this.sshUrl,
    this.cloneUrl,
    this.homepage,
    this.stargazersCount,
    this.language,
    this.hasIssues,
    this.forksCount,
    this.openIssuesCount,
    this.allowForking,
    this.visibility,
    this.score,});

  Repo.fromJson(dynamic json) {
    id = json['id'];
    nodeId = json['nodeId'];
    name = json['name'];
    fullName = json['fullName'];
    privateFlag = json['privateFlag'];
    htmlUrl = json['htmlUrl'];
    description = json['description'];
    fork = json['fork'];
    url = json['url'];
    languagesUrl = json['languagesUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    pushedAt = json['pushedAt'];
    gitUrl = json['gitUrl'];
    sshUrl = json['sshUrl'];
    cloneUrl = json['cloneUrl'];
    homepage = json['homepage'];
    stargazersCount = json['stargazersCount'];
    language = json['language'];
    hasIssues = json['hasIssues'];
    forksCount = json['forksCount'];
    openIssuesCount = json['openIssuesCount'];
    allowForking = json['allowForking'];
    visibility = json['visibility'];
    score = json['score'];
  }
  num? id;
  String? nodeId;
  String? name;
  String? fullName;
  bool? privateFlag;
  String? htmlUrl;
  String? description;
  bool? fork;
  String? url;
  String? languagesUrl;
  String? createdAt;
  String? updatedAt;
  String? pushedAt;
  String? gitUrl;
  String? sshUrl;
  String? cloneUrl;
  String? homepage;
  num? stargazersCount;
  String? language;
  bool? hasIssues;
  num? forksCount;
  num? openIssuesCount;
  bool? allowForking;
  String? visibility;
  num? score;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['nodeId'] = nodeId;
    map['name'] = name;
    map['fullName'] = fullName;
    map['privateFlag'] = privateFlag;
    map['htmlUrl'] = htmlUrl;
    map['description'] = description;
    map['fork'] = fork;
    map['url'] = url;
    map['languagesUrl'] = languagesUrl;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['pushedAt'] = pushedAt;
    map['gitUrl'] = gitUrl;
    map['sshUrl'] = sshUrl;
    map['cloneUrl'] = cloneUrl;
    map['homepage'] = homepage;
    map['stargazersCount'] = stargazersCount;
    map['language'] = language;
    map['hasIssues'] = hasIssues;
    map['forksCount'] = forksCount;
    map['openIssuesCount'] = openIssuesCount;
    map['allowForking'] = allowForking;
    map['visibility'] = visibility;
    map['score'] = score;
    return map;
  }
  @override
  String toString() {
    return 'Repo(repoName: $name, repoUrl: $htmlUrl)';
  }
}