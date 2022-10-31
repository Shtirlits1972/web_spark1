import 'package:web_spark_test1/models/step.dart';

class result {
  List<step> steps = [];
  String path = '';

  result(this.steps, this.path);

  Map toJson() => {'steps': steps, 'path': path};

  @override
  String toString() {
    return 'steps = $steps , path = $path';
  }
}
