class PullRequest {
  String url;
  int id;
  String nodeId;
  String htmlUrl;
  String diffUrl;
  String patchUrl;
  String issueUrl;
  int number;
  String state;
  bool locked;
  String title;
  User user;
  String body;
  String createdAt;
  String updatedAt;
  String closedAt;
  String mergedAt;
  String mergeCommitSha;
  Assignee assignee;
  List<Assignees> assignees;
  List<RequestedReviewers> requestedReviewers;
  List<String> requestedTeams;
  List<Labels> labels;
  Milestone milestone;
  String commitsUrl;
  String reviewCommentsUrl;
  String reviewCommentUrl;
  String commentsUrl;
  String statusesUrl;
  Head head;
  Base base;
  Links lLinks;
  String authorAssociation;
  bool merged;
  bool mergeable;
  bool rebaseable;
  String mergeableState;
  User mergedBy;
  int comments;
  int reviewComments;
  bool maintainerCanModify;
  int commits;
  int additions;
  int deletions;
  int changedFiles;

  PullRequest(
      {this.url,
      this.id,
      this.nodeId,
      this.htmlUrl,
      this.diffUrl,
      this.patchUrl,
      this.issueUrl,
      this.number,
      this.state,
      this.locked,
      this.title,
      this.user,
      this.body,
      this.createdAt,
      this.updatedAt,
      this.closedAt,
      this.mergedAt,
      this.mergeCommitSha,
      this.assignee,
      this.assignees,
      this.requestedReviewers,
      this.requestedTeams,
      this.labels,
      this.milestone,
      this.commitsUrl,
      this.reviewCommentsUrl,
      this.reviewCommentUrl,
      this.commentsUrl,
      this.statusesUrl,
      this.head,
      this.base,
      this.lLinks,
      this.authorAssociation,
      this.merged,
      this.mergeable,
      this.rebaseable,
      this.mergeableState,
      this.mergedBy,
      this.comments,
      this.reviewComments,
      this.maintainerCanModify,
      this.commits,
      this.additions,
      this.deletions,
      this.changedFiles});

  PullRequest.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    id = json['id'];
    nodeId = json['node_id'];
    htmlUrl = json['html_url'];
    diffUrl = json['diff_url'];
    patchUrl = json['patch_url'];
    issueUrl = json['issue_url'];
    number = json['number'];
    state = json['state'];
    locked = json['locked'];
    title = json['title'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    closedAt = json['closed_at'];
    mergedAt = json['merged_at'];
    mergeCommitSha = json['merge_commit_sha'];
    assignee = json['assignee'] != null
        ? new Assignee.fromJson(json['assignee'])
        : null;
    if (json['assignees'] != null) {
      assignees = new List<Assignees>();
      json['assignees'].forEach((v) {
        assignees.add(new Assignees.fromJson(v));
      });
    }
    if (json['requested_reviewers'] != null) {
      requestedReviewers = new List<RequestedReviewers>();
      json['requested_reviewers'].forEach((v) {
        requestedReviewers.add(new RequestedReviewers.fromJson(v));
      });
    }
    if (json['requested_teams'] != null) {
      requestedTeams = new List<String>();
      json['requested_teams'].forEach((v) {
        requestedTeams.add("");
      });
    }
    if (json['labels'] != null) {
      labels = new List<Labels>();
      json['labels'].forEach((v) {
        labels.add(new Labels.fromJson(v));
      });
    }
    milestone = json['milestone'] != null
        ? new Milestone.fromJson(json['milestone'])
        : null;
    commitsUrl = json['commits_url'];
    reviewCommentsUrl = json['review_comments_url'];
    reviewCommentUrl = json['review_comment_url'];
    commentsUrl = json['comments_url'];
    statusesUrl = json['statuses_url'];
    head = json['head'] != null ? new Head.fromJson(json['head']) : null;
    base = json['base'] != null ? new Base.fromJson(json['base']) : null;
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
    authorAssociation = json['author_association'];
    merged = json['merged'];
    mergeable = json['mergeable'];
    rebaseable = json['rebaseable'];
    mergeableState = json['mergeable_state'];
    mergedBy =
        json['merged_by'] != null ? new User.fromJson(json['merged_by']) : null;
    comments = json['comments'];
    reviewComments = json['review_comments'];
    maintainerCanModify = json['maintainer_can_modify'];
    commits = json['commits'];
    additions = json['additions'];
    deletions = json['deletions'];
    changedFiles = json['changed_files'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['id'] = this.id;
    data['node_id'] = this.nodeId;
    data['html_url'] = this.htmlUrl;
    data['diff_url'] = this.diffUrl;
    data['patch_url'] = this.patchUrl;
    data['issue_url'] = this.issueUrl;
    data['number'] = this.number;
    data['state'] = this.state;
    data['locked'] = this.locked;
    data['title'] = this.title;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['body'] = this.body;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['closed_at'] = this.closedAt;
    data['merged_at'] = this.mergedAt;
    data['merge_commit_sha'] = this.mergeCommitSha;
    if (this.assignee != null) {
      data['assignee'] = this.assignee.toJson();
    }
    if (this.assignees != null) {
      data['assignees'] = this.assignees.map((v) => v.toJson()).toList();
    }
    if (this.requestedReviewers != null) {
      data['requested_reviewers'] =
          this.requestedReviewers.map((v) => v.toJson()).toList();
    }
    if (this.requestedTeams != null) {
      data['requested_teams'] = [];
    }
    if (this.labels != null) {
      data['labels'] = this.labels.map((v) => v.toJson()).toList();
    }
    if (this.milestone != null) {
      data['milestone'] = this.milestone.toJson();
    }
    data['commits_url'] = this.commitsUrl;
    data['review_comments_url'] = this.reviewCommentsUrl;
    data['review_comment_url'] = this.reviewCommentUrl;
    data['comments_url'] = this.commentsUrl;
    data['statuses_url'] = this.statusesUrl;
    if (this.head != null) {
      data['head'] = this.head.toJson();
    }
    if (this.base != null) {
      data['base'] = this.base.toJson();
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    data['author_association'] = this.authorAssociation;
    data['merged'] = this.merged;
    data['mergeable'] = this.mergeable;
    data['rebaseable'] = this.rebaseable;
    data['mergeable_state'] = this.mergeableState;
    data['merged_by'] = this.mergedBy;
    data['comments'] = this.comments;
    data['review_comments'] = this.reviewComments;
    data['maintainer_can_modify'] = this.maintainerCanModify;
    data['commits'] = this.commits;
    data['additions'] = this.additions;
    data['deletions'] = this.deletions;
    data['changed_files'] = this.changedFiles;
    return data;
  }
}

class User {
  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String gravatarId;
  String url;
  String htmlUrl;
  String followersUrl;
  String followingUrl;
  String gistsUrl;
  String starredUrl;
  String subscriptionsUrl;
  String organizationsUrl;
  String reposUrl;
  String eventsUrl;
  String receivedEventsUrl;
  String type;
  bool siteAdmin;

  User(
      {this.login,
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
      this.siteAdmin});

  User.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    nodeId = json['node_id'];
    avatarUrl = json['avatar_url'];
    gravatarId = json['gravatar_id'];
    url = json['url'];
    htmlUrl = json['html_url'];
    followersUrl = json['followers_url'];
    followingUrl = json['following_url'];
    gistsUrl = json['gists_url'];
    starredUrl = json['starred_url'];
    subscriptionsUrl = json['subscriptions_url'];
    organizationsUrl = json['organizations_url'];
    reposUrl = json['repos_url'];
    eventsUrl = json['events_url'];
    receivedEventsUrl = json['received_events_url'];
    type = json['type'];
    siteAdmin = json['site_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['id'] = this.id;
    data['node_id'] = this.nodeId;
    data['avatar_url'] = this.avatarUrl;
    data['gravatar_id'] = this.gravatarId;
    data['url'] = this.url;
    data['html_url'] = this.htmlUrl;
    data['followers_url'] = this.followersUrl;
    data['following_url'] = this.followingUrl;
    data['gists_url'] = this.gistsUrl;
    data['starred_url'] = this.starredUrl;
    data['subscriptions_url'] = this.subscriptionsUrl;
    data['organizations_url'] = this.organizationsUrl;
    data['repos_url'] = this.reposUrl;
    data['events_url'] = this.eventsUrl;
    data['received_events_url'] = this.receivedEventsUrl;
    data['type'] = this.type;
    data['site_admin'] = this.siteAdmin;
    return data;
  }
}

class Assignee {
  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String gravatarId;
  String url;
  String htmlUrl;
  String followersUrl;
  String followingUrl;
  String gistsUrl;
  String starredUrl;
  String subscriptionsUrl;
  String organizationsUrl;
  String reposUrl;
  String eventsUrl;
  String receivedEventsUrl;
  String type;
  bool siteAdmin;

  Assignee(
      {this.login,
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
      this.siteAdmin});

  Assignee.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    nodeId = json['node_id'];
    avatarUrl = json['avatar_url'];
    gravatarId = json['gravatar_id'];
    url = json['url'];
    htmlUrl = json['html_url'];
    followersUrl = json['followers_url'];
    followingUrl = json['following_url'];
    gistsUrl = json['gists_url'];
    starredUrl = json['starred_url'];
    subscriptionsUrl = json['subscriptions_url'];
    organizationsUrl = json['organizations_url'];
    reposUrl = json['repos_url'];
    eventsUrl = json['events_url'];
    receivedEventsUrl = json['received_events_url'];
    type = json['type'];
    siteAdmin = json['site_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['id'] = this.id;
    data['node_id'] = this.nodeId;
    data['avatar_url'] = this.avatarUrl;
    data['gravatar_id'] = this.gravatarId;
    data['url'] = this.url;
    data['html_url'] = this.htmlUrl;
    data['followers_url'] = this.followersUrl;
    data['following_url'] = this.followingUrl;
    data['gists_url'] = this.gistsUrl;
    data['starred_url'] = this.starredUrl;
    data['subscriptions_url'] = this.subscriptionsUrl;
    data['organizations_url'] = this.organizationsUrl;
    data['repos_url'] = this.reposUrl;
    data['events_url'] = this.eventsUrl;
    data['received_events_url'] = this.receivedEventsUrl;
    data['type'] = this.type;
    data['site_admin'] = this.siteAdmin;
    return data;
  }
}

class Assignees {
  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String gravatarId;
  String url;
  String htmlUrl;
  String followersUrl;
  String followingUrl;
  String gistsUrl;
  String starredUrl;
  String subscriptionsUrl;
  String organizationsUrl;
  String reposUrl;
  String eventsUrl;
  String receivedEventsUrl;
  String type;
  bool siteAdmin;

  Assignees(
      {this.login,
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
      this.siteAdmin});

  Assignees.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    nodeId = json['node_id'];
    avatarUrl = json['avatar_url'];
    gravatarId = json['gravatar_id'];
    url = json['url'];
    htmlUrl = json['html_url'];
    followersUrl = json['followers_url'];
    followingUrl = json['following_url'];
    gistsUrl = json['gists_url'];
    starredUrl = json['starred_url'];
    subscriptionsUrl = json['subscriptions_url'];
    organizationsUrl = json['organizations_url'];
    reposUrl = json['repos_url'];
    eventsUrl = json['events_url'];
    receivedEventsUrl = json['received_events_url'];
    type = json['type'];
    siteAdmin = json['site_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['id'] = this.id;
    data['node_id'] = this.nodeId;
    data['avatar_url'] = this.avatarUrl;
    data['gravatar_id'] = this.gravatarId;
    data['url'] = this.url;
    data['html_url'] = this.htmlUrl;
    data['followers_url'] = this.followersUrl;
    data['following_url'] = this.followingUrl;
    data['gists_url'] = this.gistsUrl;
    data['starred_url'] = this.starredUrl;
    data['subscriptions_url'] = this.subscriptionsUrl;
    data['organizations_url'] = this.organizationsUrl;
    data['repos_url'] = this.reposUrl;
    data['events_url'] = this.eventsUrl;
    data['received_events_url'] = this.receivedEventsUrl;
    data['type'] = this.type;
    data['site_admin'] = this.siteAdmin;
    return data;
  }
}

class RequestedReviewers {
  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String gravatarId;
  String url;
  String htmlUrl;
  String followersUrl;
  String followingUrl;
  String gistsUrl;
  String starredUrl;
  String subscriptionsUrl;
  String organizationsUrl;
  String reposUrl;
  String eventsUrl;
  String receivedEventsUrl;
  String type;
  bool siteAdmin;

  RequestedReviewers(
      {this.login,
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
      this.siteAdmin});

  RequestedReviewers.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    nodeId = json['node_id'];
    avatarUrl = json['avatar_url'];
    gravatarId = json['gravatar_id'];
    url = json['url'];
    htmlUrl = json['html_url'];
    followersUrl = json['followers_url'];
    followingUrl = json['following_url'];
    gistsUrl = json['gists_url'];
    starredUrl = json['starred_url'];
    subscriptionsUrl = json['subscriptions_url'];
    organizationsUrl = json['organizations_url'];
    reposUrl = json['repos_url'];
    eventsUrl = json['events_url'];
    receivedEventsUrl = json['received_events_url'];
    type = json['type'];
    siteAdmin = json['site_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['id'] = this.id;
    data['node_id'] = this.nodeId;
    data['avatar_url'] = this.avatarUrl;
    data['gravatar_id'] = this.gravatarId;
    data['url'] = this.url;
    data['html_url'] = this.htmlUrl;
    data['followers_url'] = this.followersUrl;
    data['following_url'] = this.followingUrl;
    data['gists_url'] = this.gistsUrl;
    data['starred_url'] = this.starredUrl;
    data['subscriptions_url'] = this.subscriptionsUrl;
    data['organizations_url'] = this.organizationsUrl;
    data['repos_url'] = this.reposUrl;
    data['events_url'] = this.eventsUrl;
    data['received_events_url'] = this.receivedEventsUrl;
    data['type'] = this.type;
    data['site_admin'] = this.siteAdmin;
    return data;
  }
}

class Labels {
  int id;
  String nodeId;
  String url;
  String name;
  String color;
  bool defaults;

  Labels(
      {this.id, this.nodeId, this.url, this.name, this.color, this.defaults});

  Labels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nodeId = json['node_id'];
    url = json['url'];
    name = json['name'];
    color = json['color'];
    defaults = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['node_id'] = this.nodeId;
    data['url'] = this.url;
    data['name'] = this.name;
    data['color'] = this.color;
    data['default'] = this.defaults;
    return data;
  }
}

class Milestone {
  String url;
  String htmlUrl;
  String labelsUrl;
  int id;
  String nodeId;
  int number;
  String title;
  String description;
  Creator creator;
  int openIssues;
  int closedIssues;
  String state;
  String createdAt;
  String updatedAt;
  String dueOn;
  String closedAt;

  Milestone(
      {this.url,
      this.htmlUrl,
      this.labelsUrl,
      this.id,
      this.nodeId,
      this.number,
      this.title,
      this.description,
      this.creator,
      this.openIssues,
      this.closedIssues,
      this.state,
      this.createdAt,
      this.updatedAt,
      this.dueOn,
      this.closedAt});

  Milestone.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    htmlUrl = json['html_url'];
    labelsUrl = json['labels_url'];
    id = json['id'];
    nodeId = json['node_id'];
    number = json['number'];
    title = json['title'];
    description = json['description'];
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    openIssues = json['open_issues'];
    closedIssues = json['closed_issues'];
    state = json['state'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dueOn = json['due_on'];
    closedAt = json['closed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['html_url'] = this.htmlUrl;
    data['labels_url'] = this.labelsUrl;
    data['id'] = this.id;
    data['node_id'] = this.nodeId;
    data['number'] = this.number;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
    data['open_issues'] = this.openIssues;
    data['closed_issues'] = this.closedIssues;
    data['state'] = this.state;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['due_on'] = this.dueOn;
    data['closed_at'] = this.closedAt;
    return data;
  }
}

class Creator {
  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String gravatarId;
  String url;
  String htmlUrl;
  String followersUrl;
  String followingUrl;
  String gistsUrl;
  String starredUrl;
  String subscriptionsUrl;
  String organizationsUrl;
  String reposUrl;
  String eventsUrl;
  String receivedEventsUrl;
  String type;
  bool siteAdmin;

  Creator(
      {this.login,
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
      this.siteAdmin});

  Creator.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    nodeId = json['node_id'];
    avatarUrl = json['avatar_url'];
    gravatarId = json['gravatar_id'];
    url = json['url'];
    htmlUrl = json['html_url'];
    followersUrl = json['followers_url'];
    followingUrl = json['following_url'];
    gistsUrl = json['gists_url'];
    starredUrl = json['starred_url'];
    subscriptionsUrl = json['subscriptions_url'];
    organizationsUrl = json['organizations_url'];
    reposUrl = json['repos_url'];
    eventsUrl = json['events_url'];
    receivedEventsUrl = json['received_events_url'];
    type = json['type'];
    siteAdmin = json['site_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['id'] = this.id;
    data['node_id'] = this.nodeId;
    data['avatar_url'] = this.avatarUrl;
    data['gravatar_id'] = this.gravatarId;
    data['url'] = this.url;
    data['html_url'] = this.htmlUrl;
    data['followers_url'] = this.followersUrl;
    data['following_url'] = this.followingUrl;
    data['gists_url'] = this.gistsUrl;
    data['starred_url'] = this.starredUrl;
    data['subscriptions_url'] = this.subscriptionsUrl;
    data['organizations_url'] = this.organizationsUrl;
    data['repos_url'] = this.reposUrl;
    data['events_url'] = this.eventsUrl;
    data['received_events_url'] = this.receivedEventsUrl;
    data['type'] = this.type;
    data['site_admin'] = this.siteAdmin;
    return data;
  }
}

class Head {
  String label;
  String ref;
  String sha;
  User user;
  Repo repo;

  Head({this.label, this.ref, this.sha, this.user, this.repo});

  Head.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    ref = json['ref'];
    sha = json['sha'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    repo = json['repo'] != null ? new Repo.fromJson(json['repo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['ref'] = this.ref;
    data['sha'] = this.sha;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.repo != null) {
      data['repo'] = this.repo.toJson();
    }
    return data;
  }
}

class Repo {
  int id;
  String nodeId;
  String name;
  String fullName;
  bool private;
  Owner owner;
  String htmlUrl;
  String description;
  bool fork;
  String url;
  String forksUrl;
  String keysUrl;
  String collaboratorsUrl;
  String teamsUrl;
  String hooksUrl;
  String issueEventsUrl;
  String eventsUrl;
  String assigneesUrl;
  String branchesUrl;
  String tagsUrl;
  String blobsUrl;
  String gitTagsUrl;
  String gitRefsUrl;
  String treesUrl;
  String statusesUrl;
  String languagesUrl;
  String stargazersUrl;
  String contributorsUrl;
  String subscribersUrl;
  String subscriptionUrl;
  String commitsUrl;
  String gitCommitsUrl;
  String commentsUrl;
  String issueCommentUrl;
  String contentsUrl;
  String compareUrl;
  String mergesUrl;
  String archiveUrl;
  String downloadsUrl;
  String issuesUrl;
  String pullsUrl;
  String milestonesUrl;
  String notificationsUrl;
  String labelsUrl;
  String releasesUrl;
  String deploymentsUrl;
  String createdAt;
  String updatedAt;
  String pushedAt;
  String gitUrl;
  String sshUrl;
  String cloneUrl;
  String svnUrl;
  String homepage;
  int size;
  int stargazersCount;
  int watchersCount;
  String language;
  bool hasIssues;
  bool hasProjects;
  bool hasDownloads;
  bool hasWiki;
  bool hasPages;
  int forksCount;
  String mirrorUrl;
  bool archived;
  int openIssuesCount;
  License license;
  int forks;
  int openIssues;
  int watchers;
  String defaultBranch;

  Repo(
      {this.id,
      this.nodeId,
      this.name,
      this.fullName,
      this.private,
      this.owner,
      this.htmlUrl,
      this.description,
      this.fork,
      this.url,
      this.forksUrl,
      this.keysUrl,
      this.collaboratorsUrl,
      this.teamsUrl,
      this.hooksUrl,
      this.issueEventsUrl,
      this.eventsUrl,
      this.assigneesUrl,
      this.branchesUrl,
      this.tagsUrl,
      this.blobsUrl,
      this.gitTagsUrl,
      this.gitRefsUrl,
      this.treesUrl,
      this.statusesUrl,
      this.languagesUrl,
      this.stargazersUrl,
      this.contributorsUrl,
      this.subscribersUrl,
      this.subscriptionUrl,
      this.commitsUrl,
      this.gitCommitsUrl,
      this.commentsUrl,
      this.issueCommentUrl,
      this.contentsUrl,
      this.compareUrl,
      this.mergesUrl,
      this.archiveUrl,
      this.downloadsUrl,
      this.issuesUrl,
      this.pullsUrl,
      this.milestonesUrl,
      this.notificationsUrl,
      this.labelsUrl,
      this.releasesUrl,
      this.deploymentsUrl,
      this.createdAt,
      this.updatedAt,
      this.pushedAt,
      this.gitUrl,
      this.sshUrl,
      this.cloneUrl,
      this.svnUrl,
      this.homepage,
      this.size,
      this.stargazersCount,
      this.watchersCount,
      this.language,
      this.hasIssues,
      this.hasProjects,
      this.hasDownloads,
      this.hasWiki,
      this.hasPages,
      this.forksCount,
      this.mirrorUrl,
      this.archived,
      this.openIssuesCount,
      this.license,
      this.forks,
      this.openIssues,
      this.watchers,
      this.defaultBranch});

  Repo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nodeId = json['node_id'];
    name = json['name'];
    fullName = json['full_name'];
    private = json['private'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    htmlUrl = json['html_url'];
    description = json['description'];
    fork = json['fork'];
    url = json['url'];
    forksUrl = json['forks_url'];
    keysUrl = json['keys_url'];
    collaboratorsUrl = json['collaborators_url'];
    teamsUrl = json['teams_url'];
    hooksUrl = json['hooks_url'];
    issueEventsUrl = json['issue_events_url'];
    eventsUrl = json['events_url'];
    assigneesUrl = json['assignees_url'];
    branchesUrl = json['branches_url'];
    tagsUrl = json['tags_url'];
    blobsUrl = json['blobs_url'];
    gitTagsUrl = json['git_tags_url'];
    gitRefsUrl = json['git_refs_url'];
    treesUrl = json['trees_url'];
    statusesUrl = json['statuses_url'];
    languagesUrl = json['languages_url'];
    stargazersUrl = json['stargazers_url'];
    contributorsUrl = json['contributors_url'];
    subscribersUrl = json['subscribers_url'];
    subscriptionUrl = json['subscription_url'];
    commitsUrl = json['commits_url'];
    gitCommitsUrl = json['git_commits_url'];
    commentsUrl = json['comments_url'];
    issueCommentUrl = json['issue_comment_url'];
    contentsUrl = json['contents_url'];
    compareUrl = json['compare_url'];
    mergesUrl = json['merges_url'];
    archiveUrl = json['archive_url'];
    downloadsUrl = json['downloads_url'];
    issuesUrl = json['issues_url'];
    pullsUrl = json['pulls_url'];
    milestonesUrl = json['milestones_url'];
    notificationsUrl = json['notifications_url'];
    labelsUrl = json['labels_url'];
    releasesUrl = json['releases_url'];
    deploymentsUrl = json['deployments_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pushedAt = json['pushed_at'];
    gitUrl = json['git_url'];
    sshUrl = json['ssh_url'];
    cloneUrl = json['clone_url'];
    svnUrl = json['svn_url'];
    homepage = json['homepage'];
    size = json['size'];
    stargazersCount = json['stargazers_count'];
    watchersCount = json['watchers_count'];
    language = json['language'];
    hasIssues = json['has_issues'];
    hasProjects = json['has_projects'];
    hasDownloads = json['has_downloads'];
    hasWiki = json['has_wiki'];
    hasPages = json['has_pages'];
    forksCount = json['forks_count'];
    mirrorUrl = json['mirror_url'];
    archived = json['archived'];
    openIssuesCount = json['open_issues_count'];
    license =
        json['license'] != null ? new License.fromJson(json['license']) : null;
    forks = json['forks'];
    openIssues = json['open_issues'];
    watchers = json['watchers'];
    defaultBranch = json['default_branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['node_id'] = this.nodeId;
    data['name'] = this.name;
    data['full_name'] = this.fullName;
    data['private'] = this.private;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    data['html_url'] = this.htmlUrl;
    data['description'] = this.description;
    data['fork'] = this.fork;
    data['url'] = this.url;
    data['forks_url'] = this.forksUrl;
    data['keys_url'] = this.keysUrl;
    data['collaborators_url'] = this.collaboratorsUrl;
    data['teams_url'] = this.teamsUrl;
    data['hooks_url'] = this.hooksUrl;
    data['issue_events_url'] = this.issueEventsUrl;
    data['events_url'] = this.eventsUrl;
    data['assignees_url'] = this.assigneesUrl;
    data['branches_url'] = this.branchesUrl;
    data['tags_url'] = this.tagsUrl;
    data['blobs_url'] = this.blobsUrl;
    data['git_tags_url'] = this.gitTagsUrl;
    data['git_refs_url'] = this.gitRefsUrl;
    data['trees_url'] = this.treesUrl;
    data['statuses_url'] = this.statusesUrl;
    data['languages_url'] = this.languagesUrl;
    data['stargazers_url'] = this.stargazersUrl;
    data['contributors_url'] = this.contributorsUrl;
    data['subscribers_url'] = this.subscribersUrl;
    data['subscription_url'] = this.subscriptionUrl;
    data['commits_url'] = this.commitsUrl;
    data['git_commits_url'] = this.gitCommitsUrl;
    data['comments_url'] = this.commentsUrl;
    data['issue_comment_url'] = this.issueCommentUrl;
    data['contents_url'] = this.contentsUrl;
    data['compare_url'] = this.compareUrl;
    data['merges_url'] = this.mergesUrl;
    data['archive_url'] = this.archiveUrl;
    data['downloads_url'] = this.downloadsUrl;
    data['issues_url'] = this.issuesUrl;
    data['pulls_url'] = this.pullsUrl;
    data['milestones_url'] = this.milestonesUrl;
    data['notifications_url'] = this.notificationsUrl;
    data['labels_url'] = this.labelsUrl;
    data['releases_url'] = this.releasesUrl;
    data['deployments_url'] = this.deploymentsUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['pushed_at'] = this.pushedAt;
    data['git_url'] = this.gitUrl;
    data['ssh_url'] = this.sshUrl;
    data['clone_url'] = this.cloneUrl;
    data['svn_url'] = this.svnUrl;
    data['homepage'] = this.homepage;
    data['size'] = this.size;
    data['stargazers_count'] = this.stargazersCount;
    data['watchers_count'] = this.watchersCount;
    data['language'] = this.language;
    data['has_issues'] = this.hasIssues;
    data['has_projects'] = this.hasProjects;
    data['has_downloads'] = this.hasDownloads;
    data['has_wiki'] = this.hasWiki;
    data['has_pages'] = this.hasPages;
    data['forks_count'] = this.forksCount;
    data['mirror_url'] = this.mirrorUrl;
    data['archived'] = this.archived;
    data['open_issues_count'] = this.openIssuesCount;
    if (this.license != null) {
      data['license'] = this.license.toJson();
    }
    data['forks'] = this.forks;
    data['open_issues'] = this.openIssues;
    data['watchers'] = this.watchers;
    data['default_branch'] = this.defaultBranch;
    return data;
  }
}

class Owner {
  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String gravatarId;
  String url;
  String htmlUrl;
  String followersUrl;
  String followingUrl;
  String gistsUrl;
  String starredUrl;
  String subscriptionsUrl;
  String organizationsUrl;
  String reposUrl;
  String eventsUrl;
  String receivedEventsUrl;
  String type;
  bool siteAdmin;

  Owner(
      {this.login,
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
      this.siteAdmin});

  Owner.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    nodeId = json['node_id'];
    avatarUrl = json['avatar_url'];
    gravatarId = json['gravatar_id'];
    url = json['url'];
    htmlUrl = json['html_url'];
    followersUrl = json['followers_url'];
    followingUrl = json['following_url'];
    gistsUrl = json['gists_url'];
    starredUrl = json['starred_url'];
    subscriptionsUrl = json['subscriptions_url'];
    organizationsUrl = json['organizations_url'];
    reposUrl = json['repos_url'];
    eventsUrl = json['events_url'];
    receivedEventsUrl = json['received_events_url'];
    type = json['type'];
    siteAdmin = json['site_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['id'] = this.id;
    data['node_id'] = this.nodeId;
    data['avatar_url'] = this.avatarUrl;
    data['gravatar_id'] = this.gravatarId;
    data['url'] = this.url;
    data['html_url'] = this.htmlUrl;
    data['followers_url'] = this.followersUrl;
    data['following_url'] = this.followingUrl;
    data['gists_url'] = this.gistsUrl;
    data['starred_url'] = this.starredUrl;
    data['subscriptions_url'] = this.subscriptionsUrl;
    data['organizations_url'] = this.organizationsUrl;
    data['repos_url'] = this.reposUrl;
    data['events_url'] = this.eventsUrl;
    data['received_events_url'] = this.receivedEventsUrl;
    data['type'] = this.type;
    data['site_admin'] = this.siteAdmin;
    return data;
  }
}

class License {
  String key;
  String name;
  String spdxId;
  String url;
  String nodeId;

  License({this.key, this.name, this.spdxId, this.url, this.nodeId});

  License.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    spdxId = json['spdx_id'];
    url = json['url'];
    nodeId = json['node_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['spdx_id'] = this.spdxId;
    data['url'] = this.url;
    data['node_id'] = this.nodeId;
    return data;
  }
}

class Base {
  String label;
  String ref;
  String sha;
  User user;
  Repo repo;

  Base({this.label, this.ref, this.sha, this.user, this.repo});

  Base.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    ref = json['ref'];
    sha = json['sha'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    repo = json['repo'] != null ? new Repo.fromJson(json['repo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['ref'] = this.ref;
    data['sha'] = this.sha;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.repo != null) {
      data['repo'] = this.repo.toJson();
    }
    return data;
  }
}

class Links {
  Self self;
  Html html;
  Issue issue;
  Comments comments;
  ReviewComments reviewComments;
  ReviewComment reviewComment;
  Commits commits;
  Statuses statuses;

  Links(
      {this.self,
      this.html,
      this.issue,
      this.comments,
      this.reviewComments,
      this.reviewComment,
      this.commits,
      this.statuses});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? new Self.fromJson(json['self']) : null;
    html = json['html'] != null ? new Html.fromJson(json['html']) : null;
    issue = json['issue'] != null ? new Issue.fromJson(json['issue']) : null;
    comments = json['comments'] != null
        ? new Comments.fromJson(json['comments'])
        : null;
    reviewComments = json['review_comments'] != null
        ? new ReviewComments.fromJson(json['review_comments'])
        : null;
    reviewComment = json['review_comment'] != null
        ? new ReviewComment.fromJson(json['review_comment'])
        : null;
    commits =
        json['commits'] != null ? new Commits.fromJson(json['commits']) : null;
    statuses = json['statuses'] != null
        ? new Statuses.fromJson(json['statuses'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self.toJson();
    }
    if (this.html != null) {
      data['html'] = this.html.toJson();
    }
    if (this.issue != null) {
      data['issue'] = this.issue.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments.toJson();
    }
    if (this.reviewComments != null) {
      data['review_comments'] = this.reviewComments.toJson();
    }
    if (this.reviewComment != null) {
      data['review_comment'] = this.reviewComment.toJson();
    }
    if (this.commits != null) {
      data['commits'] = this.commits.toJson();
    }
    if (this.statuses != null) {
      data['statuses'] = this.statuses.toJson();
    }
    return data;
  }
}

class Self {
  String href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Html {
  String href;

  Html({this.href});

  Html.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Issue {
  String href;

  Issue({this.href});

  Issue.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Comments {
  String href;

  Comments({this.href});

  Comments.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class ReviewComments {
  String href;

  ReviewComments({this.href});

  ReviewComments.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class ReviewComment {
  String href;

  ReviewComment({this.href});

  ReviewComment.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Commits {
  String href;

  Commits({this.href});

  Commits.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Statuses {
  String href;

  Statuses({this.href});

  Statuses.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}
