import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MostAffectedPanel extends StatelessWidget {
  final countryData;

  const MostAffectedPanel({Key? key, this.countryData}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Container(
      child: GridView.builder(
        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 1),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.network(countryData[index]["countryInfo"]["flag"],height: 50,)),
                    SizedBox(height: 15,),
                    Text(countryData[index]["country"],style: TextStyle(fontWeight: FontWeight.bold,),),
                    SizedBox(height: 10,),
                    Text(countryData[index]["deaths"] > 100000 ? countryData[index]["deaths"].toString().substring(0,countryData[index]["deaths"].toString().length-5)+" lakhs":countryData[index]["deaths"].toString(),style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                    Text("Deaths",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                  ],
                ),
                ],
            ),
          );
        },
        itemCount: 9,
      ),
    );
  }
}
