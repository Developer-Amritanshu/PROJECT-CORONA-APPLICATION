import 'package:flutter/material.dart';

class WorldWidePanel extends StatelessWidget {
  final Map worldData;

  const WorldWidePanel({Key? key, required this.worldData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        children: [
          StatusPanel(
            title: "Confirmed",
            panelColor: Colors.red.shade100,
            textColor: Colors.red,
            count: worldData["cases"] > 100000 ? worldData["cases"].toString().substring(0,worldData["cases"].toString().length-5)+" lakhs":worldData["cases"].toString(),
          ),
          StatusPanel(
            title: "Active",
            panelColor: Colors.blue.shade100,
            textColor: Colors.blue.shade900,
            count: worldData["active"] > 100000 ? worldData["active"].toString().substring(0,worldData["active"].toString().length-5)+" lakhs":worldData["active"].toString(),
          ),
          StatusPanel(
            title: "Recovered",
            panelColor: Colors.green.shade100,
            textColor: Colors.green,
            count: worldData["recovered"] > 100000 ? worldData["recovered"].toString().substring(0,worldData["recovered"].toString().length-5)+" lakhs":worldData["recovered"].toString(),
          ),
          StatusPanel(
            title: "Deaths",
            panelColor: Colors.grey.shade500,
            textColor: Colors.grey.shade900,
            count: worldData["deaths"] > 100000 ? worldData["deaths"].toString().substring(0,worldData["deaths"].toString().length-5)+" lakhs":worldData["deaths"].toString(),
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel(
      {Key? key,
      required this.panelColor,
      required this.textColor,
      required this.title,
      required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: panelColor,

      ),
      margin: EdgeInsets.all(10),
      height: 80,
      width: width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
          ),
          Text(
            count,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
          ),
        ],
      ),
    );
  }
}
