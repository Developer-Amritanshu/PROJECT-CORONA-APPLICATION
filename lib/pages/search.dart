
import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  final List countryList;

  Search(this.countryList);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where((element) =>
                element["country"].toString().toLowerCase().startsWith(query))
            .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
      return Card(
                                  child: Container(
                    height: 130,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade100,
                            blurRadius: 10,
                            offset: Offset(0, 10)),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 200,
                          margin: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                suggestionList[index]["country"],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Image.network(
                                suggestionList[index]["countryInfo"]["flag"],
                                height: 50,
                                width: 60,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Confirmed: " +
                                    suggestionList[index]["cases"].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 16),
                              ),
                              Text(
                                "Recovered: " +
                                    suggestionList[index]["recovered"].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 16),
                              ),
                              Text(
                                "Active: " +
                                    suggestionList[index]["active"].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 16),
                              ),
                              Text(
                                "Deaths: " +
                                    suggestionList[index]["deaths"].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                );
    });
  }
}
