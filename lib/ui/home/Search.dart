import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/viewModel.dart';

import 'order/bottle/BottleView.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchText;
  @override
  Widget build(BuildContext context) {
    ViewModel viewModel = Provider.of<ViewModel>(context);
    List<Combined> list = (searchText != null)? viewModel.combinedList.where((element) =>
        element.bottle.bottleName.contains(searchText)).toList() : viewModel.combinedList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        bottom: PreferredSize(child: Container(
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.search)
            ),
            onChanged: (text) {
              setState(() {
                searchText = text;
              });
            },
          ),
        ), preferredSize: null),
      ),
      body: ListView.builder(itemBuilder: (context, index) {

        return FlatButton(onPressed: () => Consumer<ViewModel>(builder: (a,b,c) => BottleView(combined: list.elementAt(index)),), child: Text(index.toString()));
      }, itemCount: list.length,),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    //Add the search term to the searchBloc.
    //The Bloc will then handle the searching and add the results to the searchResults stream.
    //This is the equivalent of submitting the search term to whatever search service you are using
    ViewModel viewModel = Provider.of(context);
    List<Combined> list = viewModel.combinedList.where((element) => element.bottle.bottleName.contains(query));

    return Column(
      children: <Widget>[
        //Build the results based on the searchResults stream in the searchBloc
        ListView.builder(itemBuilder: (context, index) {

          return FlatButton(onPressed: () => Consumer<ViewModel>(builder: (a,b,c) => BottleView(combined: list.elementAt(index)),), child: Text(index.toString()));
        }, itemCount: list.length,),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}

