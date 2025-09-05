import 'package:flutter_with_bloc/features/domain/entities/post.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}  // No posts needed here

class PostLoaded extends PostState {  // This holds the fetched posts
  final List<Post> posts;
  PostLoaded(this.posts);
}

class PostError extends PostState {
  final String message;
  PostError(this.message);
}
