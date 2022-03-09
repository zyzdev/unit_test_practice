/// login : "mojombo"
/// id : 1
/// node_id : "MDQ6VXNlcjE="
/// avatar_url : "https://avatars.githubusercontent.com/u/1?v=4"
/// gravatar_id : ""
/// url : "https://api.github.com/users/mojombo"
/// html_url : "https://github.com/mojombo"
/// followers_url : "https://api.github.com/users/mojombo/followers"
/// following_url : "https://api.github.com/users/mojombo/following{/other_user}"
/// gists_url : "https://api.github.com/users/mojombo/gists{/gist_id}"
/// starred_url : "https://api.github.com/users/mojombo/starred{/owner}{/repo}"
/// subscriptions_url : "https://api.github.com/users/mojombo/subscriptions"
/// organizations_url : "https://api.github.com/users/mojombo/orgs"
/// repos_url : "https://api.github.com/users/mojombo/repos"
/// events_url : "https://api.github.com/users/mojombo/events{/privacy}"
/// received_events_url : "https://api.github.com/users/mojombo/received_events"
/// type : "User"
/// site_admin : false

class UserOverview {
  UserOverview({
    String? login,
    int? id,
    String? nodeId,
    String? avatarUrl,
    String? gravatarId,
    String? url,
    String? htmlUrl,
    String? followersUrl,
    String? followingUrl,
    String? gistsUrl,
    String? starredUrl,
    String? subscriptionsUrl,
    String? organizationsUrl,
    String? reposUrl,
    String? eventsUrl,
    String? receivedEventsUrl,
    String? type,
    bool? siteAdmin,
  }) {
    _login = login;
    _id = id;
    _nodeId = nodeId;
    _avatarUrl = avatarUrl;
    _gravatarId = gravatarId;
    _url = url;
    _htmlUrl = htmlUrl;
    _followersUrl = followersUrl;
    _followingUrl = followingUrl;
    _gistsUrl = gistsUrl;
    _starredUrl = starredUrl;
    _subscriptionsUrl = subscriptionsUrl;
    _organizationsUrl = organizationsUrl;
    _reposUrl = reposUrl;
    _eventsUrl = eventsUrl;
    _receivedEventsUrl = receivedEventsUrl;
    _type = type;
    _siteAdmin = siteAdmin;
  }

  UserOverview.fromJson(dynamic json) {
    _login = json['login'];
    _id = json['id'];
    _nodeId = json['node_id'];
    _avatarUrl = json['avatar_url'];
    _gravatarId = json['gravatar_id'];
    _url = json['url'];
    _htmlUrl = json['html_url'];
    _followersUrl = json['followers_url'];
    _followingUrl = json['following_url'];
    _gistsUrl = json['gists_url'];
    _starredUrl = json['starred_url'];
    _subscriptionsUrl = json['subscriptions_url'];
    _organizationsUrl = json['organizations_url'];
    _reposUrl = json['repos_url'];
    _eventsUrl = json['events_url'];
    _receivedEventsUrl = json['received_events_url'];
    _type = json['type'];
    _siteAdmin = json['site_admin'];
  }
  String? _login;
  int? _id;
  String? _nodeId;
  String? _avatarUrl;
  String? _gravatarId;
  String? _url;
  String? _htmlUrl;
  String? _followersUrl;
  String? _followingUrl;
  String? _gistsUrl;
  String? _starredUrl;
  String? _subscriptionsUrl;
  String? _organizationsUrl;
  String? _reposUrl;
  String? _eventsUrl;
  String? _receivedEventsUrl;
  String? _type;
  bool? _siteAdmin;

  String? get login => _login;
  int? get id => _id;
  String? get nodeId => _nodeId;
  String? get avatarUrl => _avatarUrl;
  String? get gravatarId => _gravatarId;
  String? get url => _url;
  String? get htmlUrl => _htmlUrl;
  String? get followersUrl => _followersUrl;
  String? get followingUrl => _followingUrl;
  String? get gistsUrl => _gistsUrl;
  String? get starredUrl => _starredUrl;
  String? get subscriptionsUrl => _subscriptionsUrl;
  String? get organizationsUrl => _organizationsUrl;
  String? get reposUrl => _reposUrl;
  String? get eventsUrl => _eventsUrl;
  String? get receivedEventsUrl => _receivedEventsUrl;
  String? get type => _type;
  bool? get siteAdmin => _siteAdmin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['login'] = _login;
    map['id'] = _id;
    map['node_id'] = _nodeId;
    map['avatar_url'] = _avatarUrl;
    map['gravatar_id'] = _gravatarId;
    map['url'] = _url;
    map['html_url'] = _htmlUrl;
    map['followers_url'] = _followersUrl;
    map['following_url'] = _followingUrl;
    map['gists_url'] = _gistsUrl;
    map['starred_url'] = _starredUrl;
    map['subscriptions_url'] = _subscriptionsUrl;
    map['organizations_url'] = _organizationsUrl;
    map['repos_url'] = _reposUrl;
    map['events_url'] = _eventsUrl;
    map['received_events_url'] = _receivedEventsUrl;
    map['type'] = _type;
    map['site_admin'] = _siteAdmin;
    return map;
  }

  @override
  String toString() {
    return 'UserOverview{_login: $_login, _id: $_id, _nodeId: $_nodeId, _avatarUrl: $_avatarUrl, _gravatarId: $_gravatarId, _url: $_url, _htmlUrl: $_htmlUrl, _followersUrl: $_followersUrl, _followingUrl: $_followingUrl, _gistsUrl: $_gistsUrl, _starredUrl: $_starredUrl, _subscriptionsUrl: $_subscriptionsUrl, _organizationsUrl: $_organizationsUrl, _reposUrl: $_reposUrl, _eventsUrl: $_eventsUrl, _receivedEventsUrl: $_receivedEventsUrl, _type: $_type, _siteAdmin: $_siteAdmin}';
  }
}
