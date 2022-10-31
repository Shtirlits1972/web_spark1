import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_spark_test1/models/post_object.dart';
import 'package:web_spark_test1/models/rawPost.dart';

class Keeper {
  String savedUrl = '';
  bool disabledBtn = false;
  List<rawPost> listRaw = [];
  List<post_object> listPostOb = [];
  double percentOfDone = 0;
}

class DataCubit extends Cubit<Keeper> {
  double get getPercent => state.percentOfDone;

  Future setPercent(double NewPercent) async {
    state.percentOfDone = NewPercent;
  }

  List<post_object> get getPostOb => state.listPostOb;

  Future addPostOb(post_object pob) async {
    state.listPostOb.add(pob);
  }

  setPostOb(List<post_object> NewlistPostOb) {
    state.listPostOb = NewlistPostOb;
  }

  List<rawPost> get getRawOb => state.listRaw;

  setListRaw(List<rawPost> NewlistRaw) {
    state.listRaw = NewlistRaw;
  }

  String get getUrl => state.savedUrl;

  setUrl(String newUrl) {
    state.savedUrl = newUrl;
  }

  DataCubit(Keeper initState) : super(initState);
}
