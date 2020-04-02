
import 'package:flutter/cupertino.dart';
import 'package:hot_new/home/hot_tab_model.dart';
import 'package:hot_new/home/hot_tab_repo.dart';
import 'package:rxdart/rxdart.dart';

class HotTabBloc {
  final duplicateItems = List<HotModel>();
  final HotTabRepo _repository = HotTabRepo();
  final BehaviorSubject<List<HotModel>> _subject =
  BehaviorSubject<List<HotModel>>();

  getHotList(BuildContext context) async {
   List<HotModel> response = await _repository.getHotList(context);
   duplicateItems.addAll(response);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<List<HotModel>> get subject => _subject;

  void filterSearchResults(String query) {
    List<HotModel> dummySearchList = List<HotModel>();
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<HotModel> dummyListData = List<HotModel>();
      dummySearchList.forEach((item) {
        if(item.data.name.contains(query) ||
            item.data.title.contains(query)
            || item.data.subreddit.contains(query)) {
          dummyListData.add(item);
        }
      });
      _subject.sink.add(dummyListData);
      return;
    } else {
      _subject.sink.add(duplicateItems);
    }

  }

}
final bloc = HotTabBloc();