import 'dart:convert';

import 'package:src/mock_server/mock_server.dart';

/// GitHub Searchi APIを用いてキーワード検索を行う
Future<List<dynamic>> searchRepositoryByKeyword(
    {required String keyword}) async {
  final jsonString = await MockServer.searchByKeyword("");
  final jsonMap = jsonDecode(jsonString);
  final List<dynamic> foundItems = jsonMap["items"];

  await Future.delayed(const Duration(seconds: 3));

  return foundItems;
}
