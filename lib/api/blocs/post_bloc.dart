import 'dart:async';

import 'package:postify/api/provider/post_provider.dart';
import 'package:postify/models/post.dart';

class PostBloc {
  final PostProvider _postProvider = PostProvider();
  final _postController = StreamController<List>.broadcast();

  void getPosts() async {
    List<Post> posts = await _postProvider.getPosts();
    print('hey');
    print(posts);
    _postController.sink.add(posts);
  }

  Stream<List> get posts => _postController.stream;
}