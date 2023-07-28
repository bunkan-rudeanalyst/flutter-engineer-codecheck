import 'package:flutter/material.dart';
import 'package:src/mock_server/mock_server.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Server', () {
    test('id', () async {
      final jsonString = await MockServer.searchByKeyword("");
      expect(jsonString["items"][0]["id"], 3081286);
    });
  });
}
