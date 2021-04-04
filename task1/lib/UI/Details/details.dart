import 'package:flutter/material.dart';
import 'package:task1/Model/person.dart';
import 'package:task1/UI/Data/data_Screen.dart';
import 'package:task1/UI/Image/image.dart';
import 'package:task1/UI/Data/dataProvider.dart';

class Details extends StatelessWidget {
  Result person;
  KnownFor _knownFor;
  ScrollController _scrollController = ScrollController();
  DataProvider dp = DataProvider();
  Details(this.person) {
    _knownFor = person.knownFor[0];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.black12,
                  width: double.infinity,
                  child: Text(
                    '${person.name}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImgUI(
                              "https://image.tmdb.org/t/p/w500${person.profilePath}",
                              person.id)));
                },
                child: Hero(
                  tag: person.id,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500${person.profilePath}",
                      height: 300,
                      width: 400,
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Expanded(child: Text("${_knownFor.overview}"))],
            ),
          ),
          Divider(
            color: Colors.black,
            height: 20,
            indent: 20,
            endIndent: 20,
          ),
          Container(
            height: 300,
            child: Data(),
          )
        ],
      ),
    );
  }
}
