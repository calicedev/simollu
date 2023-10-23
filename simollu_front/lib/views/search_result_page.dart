import 'package:flutter/material.dart';
import 'package:simollu_front/models/searchModel.dart';
import 'package:simollu_front/views/search_result_widget.dart';

class SearchResultPage extends StatefulWidget {
  final List<SearchModel> searchResults;

  List<SearchModel> get result => searchResults;

  SearchResultPage({Key? key, required List<SearchModel> searchResults})
      : this.searchResults = searchResults,
        super(key: key);

  SearchResultPage.withResult({Key? key, required List<SearchModel> result})
      : this.searchResults = result,
        super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  void initState() {
    super.initState();
  }

  int _numberOfPeople = 1;

  void _incrementNumberOfPeople() {
    setState(() {
      _numberOfPeople++;
    });
  }

  void _decrementNumberOfPeople() {
    if (_numberOfPeople > 1) {
      setState(() {
        _numberOfPeople--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      // padding: EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Container(
            height: 7,
            width: double.infinity,
            margin: EdgeInsets.only(top: 10),
            color: Colors.grey.withOpacity(0.2),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.result.length,
              itemBuilder: (context, index) {
                final searchResult = widget.result[index];

                return SearchResultWidget(
                  name: searchResult.restaurantName,
                  imageUrl: searchResult.restaurantImg,
                  waitingTime: searchResult.restaurantWaitingTime,
                  queueSize: searchResult.restaurantWaitingTeam,
                  numberOfPeople: 1,
                  onWait: () {},
                  restaurantSeq: searchResult.restaurantSeq,
                  distance: searchResult.distance,
                  restaurantRating: searchResult.restaurantRating,
                  latitude: searchResult.restaurantY,
                  longitude: searchResult.restaurantX,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
