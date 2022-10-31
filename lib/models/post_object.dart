import 'package:web_spark_test1/models/resultPost.dart';
import 'package:web_spark_test1/models/step.dart';

import 'resultPost.dart';

class post_object {
  String id = '';
  result res;

  post_object(this.id, this.res);

  @override
  String toString() {
    return 'id = $id, result = $res';
  }

  Map toJson() => {'id': id, 'result': res};
}
