import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_spark_test1/Block/block_data.dart';
import 'package:web_spark_test1/Forms/MyHomePage.dart';
import 'package:web_spark_test1/Forms/ProcessScreen.dart';
import 'package:web_spark_test1/Forms/ResultListScreen.dart';

class AppRouter {
  final DataCubit _dataBlock = DataCubit(Keeper());

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _dataBlock,
            child: const MyHomePage(),
          ),
        );
      case '/processScreen':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _dataBlock,
            child: ProcessScreen(),
          ),
        );
      case '/resultList':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _dataBlock,
            child: ResultListScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _dataBlock,
            child: const MyHomePage(),
          ),
        );
    }
  }
}
