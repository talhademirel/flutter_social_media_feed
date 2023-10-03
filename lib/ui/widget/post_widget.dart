import 'package:flutter/material.dart';
import 'package:flutter_social_media_feed_case_study/model/post_model.dart';

class PostWidget extends StatelessWidget {
  Post post;
  PostWidget({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              title: Text(post.title),
              trailing: Text(post.dateTime),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  post.body,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ),
            post.url == ""
                ? Container()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: SizedBox(child: Image.network(post.url!)),
                  ),
          ],
        ),
      ),
    );
  }
}
