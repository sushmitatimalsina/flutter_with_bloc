// lib/features/presentation/bloc/post_event.dart

import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class FetchPosts extends PostEvent {}
