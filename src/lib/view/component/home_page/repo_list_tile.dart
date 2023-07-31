import 'package:flutter/material.dart';
import 'package:src/model/model.dart';
import 'package:src/view/page/page.dart';

class RepoListTile extends StatelessWidget {
  final Repository repository;
  final double imageSize = 50;

  const RepoListTile({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(imageSize / 2),
          child: Image.network(
            repository.ownerIconUrl,
            width: imageSize,
            height: imageSize,
          )),
      title: Text(
        repository.repoName,
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
      subtitle: Row(
        children: [
          const Icon(Icons.person),
          Text(repository.loginName),
        ],
      ),
      trailing: const Icon(Icons.arrow_right),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => RepoDetailPage(
                  repository: repository,
                )));
      },
    );
  }
}
