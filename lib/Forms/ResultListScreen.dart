import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_spark_test1/Block/block_data.dart';
import 'package:web_spark_test1/Forms/preview_screen.dart';
import 'package:web_spark_test1/models/post_object.dart';
import 'package:web_spark_test1/models/rawPost.dart';

class ResultListScreen extends StatelessWidget {
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result list screen'),
      ),
      body: BlocBuilder<DataCubit, Keeper>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            itemCount: context.read<DataCubit>().getPostOb.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  print(context.read<DataCubit>().getPostOb[index].res.steps);
                  post_object po = context.read<DataCubit>().getPostOb[index];
                  rawPost Rp = context.read<DataCubit>().getRawOb[index];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PreviewScreen(po, Rp)),
                  );
                  //  Navigator.push(context, MaterialPageRoute(builder: PreviewScreen(context.read<DataCubit>().getPostOb[index])));
                },
                child: Text(
                  context.read<DataCubit>().getPostOb[index].res.path,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              );
            },
            // ),
          ),
        );
      }),
    );
  }
}
