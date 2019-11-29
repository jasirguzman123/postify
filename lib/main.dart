import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:postify/api/blocs/post_bloc.dart';
import 'package:postify/models/post.dart';
import 'package:postify/services/preferencer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'api/provider/post_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Postify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Postify'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RefreshController _refreshController;
  List<Post> posts = List();
  PostProvider _postsProvider = PostProvider();
  PostBloc _postBloc = PostBloc();
  bool firstLoad = true;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    Preferencer.getUsersData().then((data){
      print(data);
    }); 
    _getPosts();
  }
  void _onRefresh() async {
    _getPosts();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  _getPosts() {
    _postBloc.getPosts();
  }
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Center(
        child: StreamBuilder<List>(
          stream: _postBloc.posts,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error while loading data, please try again later');
            }else if (snapshot.hasData) {
              return _mainContent(snapshot.data);
            }else {
              return LoadingBouncingGrid.square();
            }
          },
        ),
      )
    );
  }

  Widget _mainContent(content){
    return SmartRefresher(
      child: ListView(
          scrollDirection: Axis.vertical,
          children: content,
      ),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      controller: _refreshController,
      enablePullDown: true,
    );
  }
}
