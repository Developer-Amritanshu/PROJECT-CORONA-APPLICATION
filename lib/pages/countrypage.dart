import 'dart:convert';
import 'package:corona_application/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  var url2 =
      Uri.parse("https://corona.lmao.ninja/v3/covid-19/countries?sort=cases");

  var countryData;

  fetchCountryData() async {
    var response = await http.get(url2);
    setState(() {
      countryData = jsonDecode(response.body);
      print(countryData);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Country Stats"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search(countryData));
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: countryData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
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
                                countryData[index]["country"],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Image.network(
                                countryData[index]["countryInfo"]["flag"],
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
                                    countryData[index]["cases"].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 16),
                              ),
                              Text(
                                "Recovered: " +
                                    countryData[index]["recovered"].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 16),
                              ),
                              Text(
                                "Active: " +
                                    countryData[index]["active"].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 16),
                              ),
                              Text(
                                "Deaths: " +
                                    countryData[index]["deaths"].toString(),
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
              },
              itemCount: countryData == null ? 0 : countryData.length,
            ),
    );
  }
}
