import 'package:chemical_compounds/features/details/data/datasources/details_remote_data_source.dart';
import 'package:chemical_compounds/features/details/data/repositories/details_repository_impl.dart';
import 'package:chemical_compounds/features/home/data/datasources/home_remote_data_source.dart';
import 'package:chemical_compounds/features/home/data/repositories/home_repositoy_impl.dart';
import 'package:chemical_compounds/routes/app_router.dart';
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

        /// Data Sources
        RepositoryProvider<HomeRemoteDataSource>(
          create: (BuildContext context) =>
              HomeRemoteDataSource(context.read<Dio>()),
        ),
        RepositoryProvider<DetailsRemoteDataSource>(
          create: (BuildContext context) =>
              DetailsRemoteDataSource(context.read<Dio>()),
        ),

        /// Repositories
        RepositoryProvider<HomeRepository>(
          create: (BuildContext context) =>
              HomeRepository(context.read<HomeRemoteDataSource>()),
        ),
        RepositoryProvider<DetailsRepository>(
          create: (BuildContext context) =>
              DetailsRepository(context.read<DetailsRemoteDataSource>()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Chemical Compounds',
        routerConfig: appRouter,
      ),
    );
  }
}
