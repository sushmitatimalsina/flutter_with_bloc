import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_bloc/features/domain/usecase/get_posts.dart';
import 'package:flutter_with_bloc/features/presentation/bloc/post_state.dart';
import 'package:flutter_with_bloc/features/presentation/bloc/post_event.dart'; // Make sure you have PostEvent defined

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPosts getPosts;

  PostBloc(this.getPosts) : super(PostInitial()) {
    on<FetchPosts>((event, emit) async {
      emit(PostLoading()); 

      try {
        final posts = await getPosts();
        emit(PostLoaded(posts)); 
      } catch (e) {
        emit(PostError(e.toString())); // Emit error state
      }
    });
  }
}
