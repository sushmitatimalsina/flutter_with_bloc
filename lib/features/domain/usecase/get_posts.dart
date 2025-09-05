

import 'package:flutter_with_bloc/features/domain/repository/post_repository.dart';

import '../entities/post.dart';


class GetPosts {
  final PostRepository repository;

  GetPosts(this.repository);

  Future<List<Post>> call() async {
    return await repository.getPosts();
  }
}
