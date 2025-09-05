
import '../../domain/entities/post.dart';

class PostModel extends Post {
  PostModel({required int id, required String title})
      : super(id: id, title: title);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
    );
  }
}
