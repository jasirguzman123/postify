import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PictureHolder extends StatelessWidget {
  CachedNetworkImage image;

  PictureHolder(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: GestureDetector(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: image,
            ),
          ),
          onVerticalDragUpdate: ((a){
            print(a);
            if (a.delta.dy > 0) {
              Navigator.of(context).pop();
            }
          }),
        ),
      ),
    );
  }
}