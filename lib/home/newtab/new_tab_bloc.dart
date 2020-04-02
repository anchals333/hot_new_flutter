
import 'package:flutter/cupertino.dart';
import 'package:hot_new/home/newtab/new_tab_repo.dart';
import 'package:hot_new/home/newtab/newtab_model.dart';
import 'package:rxdart/rxdart.dart';

class NewTabBloc {
  final duplicateItems = List<NewModel>();
  final NewTabRepo _repository = NewTabRepo();
  final BehaviorSubject<List<NewModel>> _subject = BehaviorSubject<List<NewModel>>();

  getNewList(BuildContext context) async {
   List<NewModel> response = await _repository.getNewList(context);
   duplicateItems.addAll(response);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<List<NewModel>> get subject => _subject;

  void filterSearchResults(String query) {
    List<NewModel> dummySearchList = List<NewModel>();
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<NewModel> dummyListData = List<NewModel>();
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
final bloc = NewTabBloc();