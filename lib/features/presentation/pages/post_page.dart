import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_bloc/core/utils/color_const.dart';
import '../../domain/usecase/get_posts.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';
import 'package:flutter_with_bloc/core/utils/string_const.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PostBloc(GetPosts(PostRepositoryImpl()))..add(FetchPosts()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Posts'),
        ),
        body:
         BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {

            if (state is PostLoading) {
              return const Center(
                child: CircularProgressIndicator()
                );
            } else if (
              state is PostLoaded
              ) {
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 4,
                    shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${post.id}'),
                        backgroundColor:  ColorConst.blueColor,
                        foregroundColor: ColorConst.whiteColor,
                      ),
                      title: Text(
                        post.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('Post ID: ${post.id}'),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                  );
                },
              );
            } else if (state is PostError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text(noData));
          },
        ),
      ),
    );
  }
}
