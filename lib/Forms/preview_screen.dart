import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_spark_test1/models/post_object.dart';
import 'package:web_spark_test1/models/rawPost.dart';

class PreviewScreen extends StatelessWidget {
  PreviewScreen(this.postOb, this.rawP);
  final rawPost rawP;

  final post_object postOb;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Screen'),
      ),
      body: Column(
        children: [
          getCenterColumn(width),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              postOb.res.path,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget getCenterColumn(double widthM) {
    List<Row> lstRow = [];
    List<String> lst = rawP.tetxField.trim().split('\n');

    double long = widthM / lst.length;

    for (int i = 0; i < lst.length; i++) {
      List<Widget> lv = [];

      for (int j = 0; j < lst[i].length; j++) {
        String strText = '($j,$i)';
        Color color = Color(int.parse("0xffFFFFFF"));
        Color textColor = Color(int.parse("0xff000000"));

        if (lst[i][j] == 's') {
          color = Color(int.parse("0xff64FFDA"));
        } else if (lst[i][j] == 'g') {
          color = Color(int.parse("0xff009688"));
        } else if (lst[i][j] == 'X') {
          color = Color(int.parse("0xff000000"));
          textColor = Color(int.parse("0xffFFFFFF"));
        } else if (lst[i][j] == '.') {
          color = Color(int.parse("0xffFFFFFF"));
        }

        for (int k = 0; k < postOb.res.steps.length; k++) {
          if (postOb.res.steps[k].x == j && postOb.res.steps[k].y == i) {
            if (k > 0 && k < postOb.res.steps.length - 1) {
              color = Color(int.parse("0xff4CAF50"));
            }
          }
        }

        Container container = Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            color: color,
          ),
          width: long,
          height: long,
          child: Center(
            child: Text(
              strText,
              style: TextStyle(color: textColor, fontSize: 20),
            ),
          ),
        );

        lv.add(container);
      }
      Row rw = Row(
        children: lv,
      );
      lstRow.add(rw);
    }
    Column column = Column(
      children: lstRow,
    );
    return column;
  }
}
