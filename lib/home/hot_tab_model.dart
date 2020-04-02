
class HotModel{
  final DataModel data;

  HotModel(this.data);


  factory HotModel.fromJson(dynamic json){
    var model = json['data'];
    DataModel dataModel = DataModel.fromJson(model);

    return HotModel(dataModel);
  }
}

class DataModel {
  final String thumbnail;
  final String title;
  final String name;
  final String subreddit;


  DataModel(this.thumbnail, this.title, this.name, this.subreddit);

  factory DataModel.fromJson(dynamic jsonReposne) {
    return DataModel(
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
}
