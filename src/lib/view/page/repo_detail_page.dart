import 'package:flutter/material.dart';

import 'package:src/model/model.dart';

class RepoDetailPage extends StatelessWidget {
  RepoDetailPage({super.key, required this.repository});

  final double imageSize = 50;
  final TextStyle titleStyle =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 24);
  final TextStyle ownerNameStyle =
      TextStyle(fontWeight: FontWeight.w600, fontSize: 24);

  Repository repository;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repository.repoName),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            Text(
              "Owner",
              style: titleStyle,
            ),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(imageSize / 2),
                  child: Image.network(
                    repository.ownerIconUrl,
                    height: imageSize,
                    width: imageSize,
                  ),
                ),
                Text(
                  repository.loginName,
                  style: ownerNameStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "repository info",
              style: titleStyle,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("star: ${repository.starNum}"),
                Text("watcher: ${repository.watcherNum}"),
                Text("fork: ${repository.forkNum}"),
                Text("issue: ${repository.issuesNum}")
              ],
            )
          ],
        ),
      ),
    );
  }
}
