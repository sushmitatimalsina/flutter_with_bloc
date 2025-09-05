import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_bloc/features/presentation/bloc/post_state.dart';
import '../../domain/usecase/get_posts.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../bloc/post_bloc.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostBloc(GetPosts(PostRepositoryImpl()))..add(FetchPosts()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Posts")),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostLoaded) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.posts[index].title),
                  );
                },
              );
            } else if (state is PostError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text("No data"));
          },
        ),
      ),
    );
  }
}
