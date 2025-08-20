import 'package:chemical_compounds/features/details/data/repositories/details_repository_impl.dart';
import 'package:chemical_compounds/features/details/presentation/bloc/details_bloc.dart';
import 'package:chemical_compounds/features/details/presentation/bloc/details_event.dart';
import 'package:chemical_compounds/features/details/presentation/bloc/details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({required this.cid, required this.iupacName, super.key});

  final int cid;
  final String iupacName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailsBloc>(
      create: (BuildContext context) =>
          DetailsBloc(context.read<DetailsRepository>())
            ..add(FetchDetailsEvent(cid)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Compound Details')),
        body: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (BuildContext context, DetailsState state) {
            if (state is DetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DetailLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      state.listOfDescription[0].title ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(state.listOfSynonyms[0].listOfSynonym.toString()),
                  ],
                ),
              );
            } else if (state is DetailError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
