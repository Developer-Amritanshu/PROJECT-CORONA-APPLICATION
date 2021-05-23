import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {

  var url2 = Uri.parse("https://corona.lmao.ninja/v3/covid-19/all");

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
        title: Text("Charts"),
      ),
      body: countryData == null
          ? Center(
              child: CircularProgressIndicator(),
            ): PieChart(dataMap: {
        "Confirmed": countryData["cases"].toDouble(),
        "Active": countryData["active"].toDouble(),
        "Recovered": countryData["recovered"].toDouble(),
        "Deaths": countryData["deaths"].toDouble(),
      },
      colorList: [
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.grey.shade800
      ],),
    );
  }
}

