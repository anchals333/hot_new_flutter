
class NewModel{
  final NewDataModel data;

  NewModel(this.data);


  factory NewModel.fromJson(dynamic json){
    var model = json['data'];
    NewDataModel dataModel = NewDataModel.fromJson(model);

    return NewModel(dataModel);
  }
}

class NewDataModel {
  final String thumbnail;
  final String title;
  final String name;
  final String subreddit;


  NewDataModel(this.thumbnail, this.title, this.name, this.subreddit);

  factory NewDataModel.fromJson(dynamic jsonReposne) {
    return NewDataModel(
        jsonReposne['thumbnail'],
        jsonReposne['title'],
        jsonReposne['name'],
        jsonReposne['subreddit']);
  }

  Map toJson() => {
        'thumbnail': thumbnail,
        'title': title,
        'name': name,
        'subreddit': subreddit
      };


  factory NewDataModel.fromMap(Map<String, dynamic> json) => new NewDataModel(
      json['thumbnail'],
      json['title'],
      json['name'],
      json['subreddit']
  );

  Map<String, dynamic> toMap() => {
    "thumbnail": thumbnail,
    "title": title,
    "name": name,
    "subreddit": subreddit
  };
}
