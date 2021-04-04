import 'package:flutter/material.dart';
import 'package:task1/UI/Data/dataProvider.dart';
import 'package:task1/UI/Details/details.dart';
import 'package:task1/services/repo.dart';
import 'package:provider/provider.dart';

class Data extends StatelessWidget {
  Repository r = new Repository();
  DataProvider dp = DataProvider();
  ScrollController _scrollController = ScrollController();
  Data() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        dp.getData();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataProvider>(
      create: (context) => dp,
      child: Consumer<DataProvider>(
        builder: (buildContext, dataProv, _) {
          return (dataProv.result != null)
              ? ListView.builder(
                  controller: _scrollController,
                  itemCount: dataProv.result.length,
                  itemBuilder: (context, index) {
                    final person = dataProv.result[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(person)));
                      },
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Hero(
                              tag: person.id,
                              child: Image.network(
                                (person.profilePath != null)
                                    ? "https://image.tmdb.org/t/p/w500${person.profilePath}"
                                    : "https://kubalubra.is/wp-content/uploads/2017/11/default-thumbnail.jpg",
                                height: 100,
                                width: 100,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${person.name}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 20),
                                      maxLines: 2,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              2, 0, 2, 0),
                                          child: Chip(
                                            label: Text((person.gender == 1)
                                                ? 'female'
                                                : "male"),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              2, 0, 2, 0),
                                          child: Chip(
                                              label:
                                                  Icon(Icons.remove_red_eye)),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                        Text(
                                          '${person.popularity}',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () {})
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
