import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Ambient extends Equatable {
  const Ambient({
    required this.title,
    required this.artist,
    required this.duration,
    required this.url,
    required this.image,
    required this.category,
  });

  final String title;
  final String artist;
  final num duration;
  final String url;
  final String image;
  final String category;

  factory Ambient.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Ambient(
      title: data?['title'],
      artist: data?['artist'],
      duration: data?['duration'],
      url: data?['url'],
      image: data?['image'],
      category: data?['category'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'artist': artist,
      'duration': duration,
      'url': url,
      'image': image,
      'category': category,
    };
  }

  @override
  List<Object> get props => [title, artist];
}
