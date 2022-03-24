import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/presenter/post/bloc/post_bloc.dart';
import 'package:flutter_bloc_app/presenter/post/view/task_view_bloc.dart';
import 'package:dio/dio.dart';

import 'data/rest_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => RestClient(
            dio..interceptors.add(LogInterceptor(requestBody: true, responseBody: true)),
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PostBloc(RepositoryProvider.of<RestClient>(context))),
        ],
        child: MaterialApp(
          title: 'Flutter (Bloc && Cubit) with Freezed',
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          home: const TaskViewBloc(),
        ),
      ),
    );
  }
}
