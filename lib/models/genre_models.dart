class Genres {
  List<Genres>? genres;

  Genres({this.genres});

  Genres.fromJson(Map<String, dynamic> json) {
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(Genres.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Genres1 {
  int? id;
  String? name;

  Genres1({this.id, this.name});

  Genres1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
