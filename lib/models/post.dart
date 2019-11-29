import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:postify/models/user.dart';
import 'package:postify/picture_holder.dart';

class Post extends StatefulWidget {
  List imagePaths;
  User user;

  Post({ this.imagePaths, this.user });

  factory Post.fromJson(json) { 
    return Post(
      imagePaths: json['posts'],
      user: User.fromJson(json),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Post();
  }
  
}

class _Post extends State<Post> {

  double currentImagePosition = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Column(
        children: <Widget>[
          widget.user,
          _buildPosts(context)
        ],
      ),
    );
  }

  _goToPictureHolder(context, image){
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, _, __){
        return PictureHolder(image);
      },
      transitionDuration: Duration(milliseconds: 500),
      fullscreenDialog: true
    ));
  }

  Widget _buildPosts(context) {
    List images = _buildImages();
    Widget container;
    if (widget.imagePaths.length <= 2){
      container = Row(
        children: images.map((image) {
          return Expanded(child: image,);
        }).toList(),
      );
    }else if (widget.imagePaths.length == 3){
      container = Column(
        children: <Widget>[
          images.first,
          Row(children: <Widget>[
            Expanded(
              child: images[1],
            ),
            Expanded(
              child: images[2],
            )
          ],)
        ],
      );
    }else {
      container = _multipleElementsView(images, context);
    }
    return container;
  }

  List _buildImages() {
    return widget.imagePaths.map((image){

      CachedNetworkImage cacheImage = CachedNetworkImage(
        imageUrl: image,
        placeholder: (context, url) => LoadingBouncingLine.square(),
        errorWidget: (context, url, error) => Image.asset('assets/error.png'),
      );

      return GestureDetector(
        child: Container(
          child: cacheImage,
          margin: EdgeInsets.all(5),
        ),
        onTap: () {
          _goToPictureHolder(context, cacheImage);
        },
      );
    }).toList();

  }

  Widget _multipleElementsView(images, context) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width,
          child: images.first,
        ),
        SizedBox(
          height: 200,
          child: Stack(
            children: <Widget>[
              CarouselSlider(
                items: images.sublist(1, images.length),
                autoPlay: true,
                aspectRatio: 2.0,
                onPageChanged: (index) {
                  setState(() {
                    currentImagePosition = index.floor().toDouble();
                  });
                },
                enlargeCenterPage: true,
                viewportFraction: 0.5,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                alignment: Alignment.bottomCenter,
                child: DotsIndicator(
                  dotsCount: images.length - 1,
                  position: currentImagePosition.floor().toDouble(),
                  decorator: DotsDecorator(
                    activeColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}