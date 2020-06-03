class Movie{
  int id;
  String image;
  String title;
  String date;
  String overview;
  String mediaType;

  Movie({this.id,this.image,this.title,this.date, this.overview, this.mediaType});

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json["id"],
    image: json["backdrop_path"],
    title: json["title"]!=null ? json["title"] : json["name"],
    date: json["release_date"],
    overview: json["overview"],
    mediaType: json["media_type"]
  );
  
  Map<String, dynamic> toJson() =>{
    "id": id,
    "backdrop_path": image,
    "title": title,
    "release_date": date,
    "overview": overview,
    "media_type": mediaType
  };
}