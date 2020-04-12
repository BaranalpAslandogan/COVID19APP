import 'package:flutter/material.dart';

class UlkeTablar extends StatelessWidget {

  final String ulkeBaslik;
  final int ulkeVaka;
  final int ulkeOlum;
  final int ulkeIyilesen;
  const UlkeTablar({Key key, this.ulkeBaslik, this.ulkeVaka, this.ulkeOlum, this.ulkeIyilesen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height:20),
            Text(ulkeBaslik),
            SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Toplam Vaka"),
                    ulkeVaka!=null ? Text("$ulkeVaka",style: TextStyle(color: Colors.orange),) : Text("---"),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Ölüm"),
                    ulkeOlum!=null ? Text("$ulkeOlum",style: TextStyle(color: Colors.red),) : Text("---"),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("İyileşen"),
                    ulkeIyilesen!=null ? Text("$ulkeIyilesen",style: TextStyle(color: Colors.green),) : Text("---"),
                  ],
                ),
              ],
            ),
          ], 
        ),
      ),
    );
  }
}