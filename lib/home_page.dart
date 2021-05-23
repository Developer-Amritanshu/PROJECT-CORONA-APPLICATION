import 'package:corona_application/datasource.dart';
import 'package:corona_application/pages/charts.dart';
import 'package:corona_application/pages/countrypage.dart';
import 'package:corona_application/panels/infopanel.dart';
import 'package:corona_application/panels/mosteffectedcountries.dart';
import 'package:corona_application/panels/worldwidepanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = Uri.parse("https://corona.lmao.ninja/v3/covid-19/all");
  var url2 =
      Uri.parse("https://corona.lmao.ninja/v3/covid-19/countries?sort=cases");

  var worldData;
  var countryData;

  fetchWorldWideData() async {
    http.Response response = await http.get(url);
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  fetchCountryData() async {
    var response = await http.get(url2);
    setState(() {
      countryData = jsonDecode(response.body);
      print(countryData);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("COVID-19 TRACKER"),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                color: Colors.orange[100],
                
                child: DefaultTextStyle(
                  style: const TextStyle(
                      color: Color.fromRGBO(255, 126, 0, 0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                                  child: AnimatedTextKit(
                    animatedTexts:[
                      TypewriterAnimatedText(DataSource.quote)
                    ],
                      totalRepeatCount: 1,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Worldwide",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountryPage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryBlack,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Regional",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              worldData == null
                  ? CircularProgressIndicator()
                  : WorldWidePanel(
                      worldData: worldData,
                    ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Most Affected Countries",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChartPage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryBlack,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Charts",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              countryData == null
                  ? Container()
                  : MostAffectedPanel(
                      countryData: countryData,
                    ),
                    
              InfoPanel(),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                "WE ARE TOGETHER IN THE FIGHT",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// var urlCountry = Uri.parse("https://corona.lmao.ninja/v3/covid-19/countries");

// var countryData;
// fetchCountryData() async {
//   http.Response response = await http.get(urlCountry);
//   setState(() {
//     countryData = json.decode(response.body);
//   });
// }
