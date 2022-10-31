import 'dart:collection';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';
import 'package:web_spark_test1/constants.dart';
import 'package:web_spark_test1/models/a_star_2d.dart';
import 'package:web_spark_test1/models/post_object.dart';
import 'package:web_spark_test1/models/rawPost.dart';
import 'package:web_spark_test1/models/resultPost.dart';
import 'step.dart';

class Engine {
  static Future<dynamic> sendPostOb(
      List<post_object> list, String inputUrl) async {
    dynamic dyn = {};
    var headers = {'Content-Type': 'application/json'};
    Request request = http.Request('POST', Uri.parse(inputUrl));

    request.headers.addAll(headers);
    request.body = json.encode(list);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String result = await response.stream.bytesToString();

      dyn = (json.decode(result) as dynamic);
      print(dyn);
    } else {
      print(response.statusCode);
      int u = 0;
    }
    return dyn;
  }

  static post_object getSolution(rawPost rPs) {
    Maze maze = new Maze.parse(rPs.tetxField);
    Queue<Tile> solution = aStar2D(maze);
    print(solution);

    List<step> listStep = [];

    String path = '';

    solution.forEach((element) {
      step st = step(element.x, element.y);
      listStep.add(st);
      path += '(${st.x}.${st.y})->';
    });

    result rz = result(listStep, path.substring(0, path.length - 2));

    post_object postO = post_object(rPs.id, rz);

    return postO;
  }

  static Future<List<rawPost>> getRawPostOb(String inputUrl) async {
    List<rawPost> rawPostList = [];

    Request request = http.Request('GET', Uri.parse(inputUrl));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String result = await response.stream.bytesToString();

      dynamic responseObj = (json.decode(result) as dynamic);

      print(responseObj);

      if (responseObj != null) {
        if (responseObj['error'] == false && responseObj['message'] == "OK") {
          List<dynamic> data = responseObj['data'];

          for (int i = 0; i < data.length; i++) {
            String id = data[i]['id'];
            List<String> field = [];

            dynamic start = data[i]['start'];
            dynamic goal = data[i]['end'];

            List<dynamic> dynField = data[i]["field"];

            for (int j = 0; j < dynField.length; j++) {
              field.add(dynField[j].toString());
            }

            int p = 0;

            for (int i = 0; i < field.length; i++) {
              if (i == start['y']) {
                List<String> strTmp = field[i].split('');

                field[i] = '';

                for (int j = 0; j < strTmp.length; j++) {
                  if (j == start['x']) {
                    strTmp[j] = 's';
                  }
                  field[i] += strTmp[j];
                }
              }

              if (i == goal['y']) {
                List<String> strTmp = field[i].split('');

                field[i] = '';

                for (int j = 0; j < strTmp.length; j++) {
                  if (j == goal['x']) {
                    strTmp[j] = 'g';
                  }
                  field[i] += strTmp[j];
                }
              }
            }

            String textMap = '';

            for (int i = 0; i < field.length; i++) {
              textMap += field[i] + "\n";
            }

            rawPost rp = rawPost(id, textMap);
            rawPostList.add(rp);
          }
        }
      } else {
        print('Error');
      }
    }
    return rawPostList;
  }
}
