import 'package:chemical_compounds/features/home/data/datasources/home_remote_data_source.dart';
import 'package:chemical_compounds/features/home/data/repositories/home_repositoy_impl.dart';
import 'package:chemical_compounds/features/home/presentation/pages/home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: <SingleChildWidget>[
        RepositoryProvider<Dio>(create: (_) => Dio()),
        RepositoryProvider<HomeRemoteDataSource>(
          create: (BuildContext context) =>
              HomeRemoteDataSource(context.read<Dio>()),
        ),
        RepositoryProvider<HomeRepository>(
          create: (BuildContext context) =>
              HomeRepository(context.read<HomeRemoteDataSource>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chemical Compounds',
        home: const HomePage(),
      ),
    );
  }
}
