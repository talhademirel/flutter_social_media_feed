import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_media_feed_case_study/model/post_model.dart';
import 'package:flutter_social_media_feed_case_study/ui/screen/new_post_page.dart';
import 'package:flutter_social_media_feed_case_study/ui/screen/post_detail_page.dart';
import 'package:flutter_social_media_feed_case_study/ui/widget/post_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SafeArea(child: Image.asset('assets/images/X.png')),
      ),
      body: FirebaseAnimatedList(
        reverse: true,
        query: FirebaseDatabase.instance.ref().child('posts'),
        shrinkWrap: true,
        itemBuilder: ((context, snapshot, animation, index) {
          Map postData = snapshot.value as Map;
          postData['key'] = snapshot.key;
          Post postObj = Post(postData['date'], postData['title'],
              postData['body'], postData['url']);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostDetailPage(
                            post: postObj,
                          )));
            },
            child: PostWidget(
              post: postObj,
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 15, 15, 15),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewPostPage()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
