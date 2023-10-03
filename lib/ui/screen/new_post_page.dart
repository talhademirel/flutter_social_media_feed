import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_media_feed_case_study/ui/screen/home_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NewPostPage extends StatefulWidget {
  @override
  State<NewPostPage> createState() => NewPostPageState();
}

class NewPostPageState extends State<NewPostPage> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  File? file;
  XFile? img;
  String? url;
  ImagePicker image = ImagePicker();
  late String currentDate;
  DatabaseReference? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('posts');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Post',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                    height: 200,
                    width: 200,
                    child: file == null
                        ? IconButton(
                            icon: const Icon(
                              Icons.add_a_photo,
                              size: 90,
                            ),
                            onPressed: () {
                              getImage();
                            },
                          )
                        : MaterialButton(
                            height: 100,
                            child: Image.file(
                              file!,
                              fit: BoxFit.fill,
                            ),
                            onPressed: () {
                              getImage();
                            },
                          )),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: title,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Title',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: body,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Write something..',
                ),
                maxLines: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  currentDate =
                      DateFormat('dd-MM-yyyy H:m').format(DateTime.now());
                  uploadPost();
                },
                child: const Text(
                  "Add",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 15, 15, 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getImage() async {
    img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      if (img != null) {
        file = File(img!.path);
      }
    });
  }

  uploadPost() async {
    try {
      if (img != null) {
        var imagefile = FirebaseStorage.instance
            .ref()
            .child("post_image")
            .child("/${title.text}.jpg");
        UploadTask task = imagefile.putFile(file!);
        TaskSnapshot snapshot = await task;
        url = await snapshot.ref.getDownloadURL();
        setState(() {
          url = url;
        });
      }

      url ??= "";

      Map<String, String> post = {
        'title': title.text,
        'body': body.text,
        'date': currentDate,
        'url': url!,
      };

      dbRef!.push().set(post).whenComplete(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomePage(),
          ),
        );
      });
    } on Exception catch (e) {
      print(e);
    }
  }
}
