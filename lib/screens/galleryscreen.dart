import 'dart:io';
import 'package:camera_app/db/functions/db_functions.dart';
import 'package:camera_app/db/model/db_model.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getImage();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PHOTOS',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: SafeArea(
          child: Container(
        child: ValueListenableBuilder(
            valueListenable: imageNotifier,
            builder: (context, showimage, child) {
              return Padding(
                padding: const EdgeInsets.all(7),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, mainAxisSpacing: 7),
                  itemBuilder: (ctx, index) {
                    final data = showimage[index];
                    return GestureDetector(
                      onLongPress: () {
                        onLongpressImage(context, data.id);
                      },
                      child: Image(
                          width: 30,
                          height: 50,
                          image: FileImage(File(data.image))),
                    );
                  },
                  itemCount: showimage.length,
                ),
              );
            }),
      )),
    );
  }

  onLongpressImage(context, id) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: Text("Do you want to delete? "),
            actions: [
              TextButton(
                  onPressed: () {
                    deletePhoto(id);
                    deleteButtonClickedYes(ctx);
                    Navigator.of(context).pop();
                  },
                  child: Text("yes")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No"))
            ],
          );
        });
  }

  deleteButtonClickedYes(ctx) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: Text("Successfully Deleted"),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(15 ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    ));
  }
}
