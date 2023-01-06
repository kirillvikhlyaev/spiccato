// ignore_for_file: public_member_api_docs, sort_constructors_first
class Track {
  final String name;
  final String author;
  final Duration time;
  final String path;

  Track({
    required this.name,
    required this.author,
    required this.time,
    required this.path,
  });

  Track.temp({this.name = 'God`s Plan', this.author = 'Drake', this.time = Duration.zero, this.path = ''});

  @override
  String toString() => 'Track(name: $name, author: $author, time: $time)';
}
