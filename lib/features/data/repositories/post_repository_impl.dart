
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/post.dart';
import '../../domain/repository/post_repository.dart';
import '../model/post_model.dart';
import 'package:flutter_with_bloc/core/utils/api_const.dart';
import 'package:flutter_with_bloc/core/utils/string_const.dart';

class PostRepositoryImpl implements PostRepository {
  @override
  Future<List<Post>> getPosts() async {
    try {
      final response = await http.get(Uri.parse(Api.url));

      print('Response status: ${response.statusCode}'); // Debug
      print('Response body: ${response.body}'); // Debug

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List posts = data['posts']; // DummyJSON wraps posts in 'posts'
        return posts.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception(failedToFetchPosts);
      }
    } catch (e) {
      print('Error fetching posts: $e');
      throw Exception(failedToFetchPosts);
    }
  }
}
