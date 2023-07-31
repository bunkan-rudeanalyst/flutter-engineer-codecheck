import 'package:flutter/material.dart';

/// GitHubリポジトリ
class Repository {
  int id;
  String repoName;
  String ownerIconUrl;
  String loginName;
  List<String> projectLanguages;
  int starNum;
  int watcherNum;
  int forkNum;
  int issuesNum;

  Repository(
      {required this.id,
      required this.repoName,
      required this.ownerIconUrl,
      required this.loginName,
      required this.projectLanguages,
      required this.starNum,
      required this.watcherNum,
      required this.forkNum,
      required this.issuesNum});

  /// GitHub Search APIにて取得したjsonからRepositoryインスタンスを作成する
  ///
  /// projectLanguagesは別途APIで取得する必要があるので、
  /// インスタンス生成前に非同期で取得する。
  factory Repository.fromJson(
      Map<String, dynamic> json, List<String> projectLanguages) {
    return Repository(
        id: json["id"],
        repoName: json["name"],
        loginName: json["owner"]["login"],
        ownerIconUrl: json["owner"]["avatar_url"],
        projectLanguages: projectLanguages,
        starNum: json["stargazers_count"],
        watcherNum: json["watchers_count"],
        forkNum: json["forks_count"],
        issuesNum: json["open_issues_count"]);
  }
}
