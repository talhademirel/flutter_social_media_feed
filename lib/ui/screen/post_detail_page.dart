import 'package:flutter/material.dart';
import 'package:flutter_social_media_feed_case_study/model/post_model.dart';
import 'package:flutter_social_media_feed_case_study/ui/widget/post_widget.dart';

class PostDetailPage extends StatelessWidget {
  Post post;
  PostDetailPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: Column(
        children: [
          PostWidget(
            post: Post(post.dateTime, post.title, post.body, post.url),
          )
        ],
      ),
    );
  }
}
