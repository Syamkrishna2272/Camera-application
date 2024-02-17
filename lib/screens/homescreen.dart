import 'dart:io';

import 'package:camera_app/db/functions/db_functions.dart';
import 'package:camera_app/db/model/db_model.dart';
import 'package:camera_app/screens/galleryscreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

File? image1;
String? image;

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    getImage();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Camera App'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 100,
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center ,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) {
                              return GalleryScreen();
                            },
                          ));
                        },
                        icon: Icon(Icons.filter),
                        iconSize: 50,
                        color: Colors.red,
                      ),
                      Text(
                        "Gallery ",
                        style: TextStyle(
                            fontSize: 18 ,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Column(
                children: [
                  Center(
                    child: IconButton(
                      onPressed: () {
                        fromCamera();
                      },
                      icon: Icon(Icons.camera_alt_outlined),
                      iconSize: 75,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fromCamera() async {
    final img1 = await ImagePicker().pickImage(source: ImageSource.camera);
    if (img1 != null) {
      setState(() {
        image1 = File(img1.path);
        image = image1!.path;
      });
    }
    final _imageValues = Imagemodel(image: image!);
    await addImage(_imageValues);
  }
}
