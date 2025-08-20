import 'package:chemical_compounds/features/home/data/repositories/home_repositoy_impl.dart';
import 'package:chemical_compounds/features/home/presentation/bloc/home_bloc.dart';
import 'package:chemical_compounds/features/home/presentation/bloc/home_event.dart';
import 'package:chemical_compounds/features/home/presentation/bloc/home_state.dart';
import 'package:chemical_compounds/features/home/presentation/pages/widgets/compound_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  //fetch compound from shared preferences
  final String compoundName = 'aspirin';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) =>
          HomeBloc(context.read<HomeRepository>())
            ..add(FetchCompoundEvent(cids: compoundName)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (BuildContext context, HomeState state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return ListView.builder(
                itemCount: state.items.length,
                //todo: initially shows from shared preferences
                itemBuilder: (context, index) {
                  return CompoundItem(compound: state.items[index]);
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
