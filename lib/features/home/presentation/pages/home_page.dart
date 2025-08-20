import 'package:chemical_compounds/features/details/presentation/pages/details_page.dart';
import 'package:chemical_compounds/features/home/data/models/properties_model.dart';
import 'package:chemical_compounds/features/home/data/repositories/home_repositoy_impl.dart';
import 'package:chemical_compounds/features/home/presentation/bloc/home_bloc.dart';
import 'package:chemical_compounds/features/home/presentation/bloc/home_event.dart';
import 'package:chemical_compounds/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final String compoundName = 'aspirin';
  final String properties = 'MolecularFormula,MolecularWeight';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(context.read<HomeRepository>())
        ..add(
          FetchItemsEvent(compoundName: compoundName, properties: properties),
        ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (BuildContext context, HomeState state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (BuildContext context, int index) {
                  final Property item = state.items[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (_) => DetailsPage(cid: item.cid ?? 0),
                        ),
                      );
                    },
                    title: Text(item.molecularFormula ?? ''),
                    subtitle: Text('ID: ${item.molecularWeight ?? ''}'),
                  );
                },
              );
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            }
            // Initial state
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
