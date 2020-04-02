

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hot_new/home/hot_tab_bloc.dart';
import 'package:hot_new/home/hot_tab_model.dart';
import 'package:lottie/lottie.dart';


class HotTabRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HotTabRouteState();
  }
}

class _HotTabRouteState extends State<HotTabRoute> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc.getHotList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  bloc.filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            StreamBuilder<List<HotModel>>(
              stream: bloc.subject.stream,
              builder: (context, AsyncSnapshot<List<HotModel>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isEmpty){
                    return _buildErrorWidget("No data found!!!");
                  }
                  return _buildServicesHistoryRoute(snapshot.data);
                } else if (snapshot.hasError) {
                  return _buildErrorWidget("Error occured ${snapshot.error}");
                } else {
                  return _buildLoadingWidget();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  final topAppBar = AppBar(
    elevation: 1,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Color(0xFFda393a), //change your color here
    ),
    title: Text("A", style: TextStyle(color: Color(0xFFda393a))),
  );


  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Lottie.asset('assets/loader/apartment_loader.json')],
        ));
  }

  Widget _buildErrorWidget(String message) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
          ],
        ));
  }

  Widget _buildServicesHistoryRoute(List<HotModel> data) {
    return  Expanded(
      child: ListView.builder
        (
          itemCount: data.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return _buildListview(data[index]);
          }
      ),
    );
  }

  Widget _buildListview(HotModel data) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: listTile(data),
      ),
    );
  }

  Widget listTile(HotModel item) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 2),
            child: Text('Name : ${item.data.name}',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text('Title : ${item.data.title}',textAlign: TextAlign.left, style: TextStyle(color: Colors.black)),
          ),

          Padding(
            padding: EdgeInsets.only(top: 1, bottom: 1),
            child: Text('Type : ${item.data.subreddit}'.toString(),
                style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );

  }
  Widget _showStatus(String status){
    if(status.contains('Successfull')){
      return Text(status,
          style: TextStyle(color: Colors.green));
    } else {
     return Text(status,
          style: TextStyle(color: Color(0xFFda393a)));
    }
  }

  void showSnackBar(String message) {
    var snackbar = SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFFE13634));
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }


}