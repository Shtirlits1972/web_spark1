import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';
import 'package:web_spark_test1/Block/block_data.dart';
import 'package:web_spark_test1/constants.dart';
import 'package:web_spark_test1/models/Engine.dart';
import 'package:web_spark_test1/models/rawPost.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController(text: url);
  @override
  Widget build(BuildContext context) {
    bool showIndicator = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
      ),
      body: BlocBuilder<DataCubit, Keeper>(builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Set valid API base URL in order to continue',
              ),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  icon: Icon(Icons.cached),
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width - 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    disabledBackgroundColor: Colors.grey,
                  ),
                  onPressed: state.disabledBtn
                      ? null
                      : () async {
                          setState(() {
                            state.disabledBtn = true;
                          });

                          print(state.disabledBtn);

                          bool _validURL = isURL(controller.text,
                              protocols: ['http', 'https'], requireTld: false);

                          if (_validURL) {
                            print('Url is valid');
                            state.savedUrl = controller.text;
                            // List<rawPost> stepList =
                            //     await

                            Engine.getRawPostOb(controller.text)
                                .then((stepList) => {
                                      setState(() {
                                        state.disabledBtn = false;
                                        state.listRaw = stepList;

                                        Navigator.of(context)
                                            .pushNamed('/processScreen');
                                      })
                                    });
                          } else {
                            setState(() {
                              state.disabledBtn = false;
                              print(state.disabledBtn);
                            });
                            print(state.disabledBtn);
                            final snackBar = SnackBar(
                              content: const Text('Error Url is not valid!'),
                              action: SnackBarAction(
                                label: 'OK',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                  child: const Text(
                    'Start counting process',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      // ),
    );
  }
}
