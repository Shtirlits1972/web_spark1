import 'dart:io';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_spark_test1/Block/block_data.dart';
import 'package:web_spark_test1/models/Engine.dart';
import 'package:web_spark_test1/models/post_object.dart';
import 'package:web_spark_test1/models/rawPost.dart';

class ProcessScreen extends StatefulWidget {
  ProcessScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  @override
  Widget build(BuildContext context) {
    double donePercent = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Process Screen',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
      ),
      body: BlocBuilder<DataCubit, Keeper>(builder: (context, state) {
        double percentOfDone = 0;
        bool btnDisable = false;
        return Center(
          child: Column(
            children: [
              const Expanded(child: SizedBox()),
              getHead(),
              Text(
                '${context.read<DataCubit>().getPercent.toStringAsFixed(2)}% ',
                style: const TextStyle(fontSize: 25, color: Colors.black),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    backgroundColor: Colors.grey[400],
                    value: context.read<DataCubit>().getPercent,
                    //  semanticsValue: context.read<DataCubit>().getPercent.toString(),
                    semanticsLabel: 'Circular progress indicator',
                  ),
                ),
              ),
              //   setProgressIndic(context),
              const Expanded(child: SizedBox()),
              getButtonSend(btnDisable, context),
              // ElevatedButton(
              //   onPressed: () {
              //     _finfSolutions();
              //   },
              //   child: const Text(
              //     'TEST',
              //     style: TextStyle(fontSize: 25, color: Colors.black),
              //   ),
              // ),
            ],
          ),
        );
      }),
    );
  }

  Widget getHead() {
    if (context.read<DataCubit>().getPercent == 100) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'All calculation has finished, you can send',
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
          Text(
            'you results to server',
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        ],
      );
    } else {
      return Text(
        'please wait...',
        style: TextStyle(fontSize: 20, color: Colors.black),
      );
    }
  }

  Widget getButtonSend(bool btnDisable, BuildContext context) {
    if (context.read<DataCubit>().getPercent == 100) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          disabledBackgroundColor: Colors.grey,
        ),
        onPressed: btnDisable
            ? null
            : () {
                setState(() {
                  btnDisable = true;
                });

                List<post_object> lst = context.read<DataCubit>().getPostOb;

                Engine.sendPostOb(context.read<DataCubit>().getPostOb,
                        context.read<DataCubit>().getUrl)
                    .then(
                  (value) {
                    if (value['message'] == 'OK') {
                      print('OK');
                      Navigator.pushNamed(context, '/resultList');
                    } else {
                      SnackBar snackBar = SnackBar(
                        content: const Text('Error sending result!'),
                        action: SnackBarAction(label: 'ok', onPressed: () {}),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                );
              },
        child: const Text(
          'Send result to server',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
      );
    } else {
      return Container(
        child: null,
      );
    }
  }

  Future _findSolutions() async {
    print('_gotoHome ');

    double percentss = 0;

    for (int i = 0; i < context.read<DataCubit>().getRawOb.length; i++) {
      post_object po =
          Engine.getSolution(context.read<DataCubit>().getRawOb[i]);

      percentss =
          ((i + 1).toDouble() / context.read<DataCubit>().getRawOb.length) *
              100;

      //   if (context.read<DataCubit>().getPercent < 100) {
      setState(() {
        context.read<DataCubit>().addPostOb(po);
        context.read<DataCubit>().setPercent(percentss);
        // sleep(Duration(seconds: 2));
      });
      // }

      print('${percentss.toStringAsFixed(2)}% DONE');
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 100), () {
      _findSolutions();
    });
  }
}
