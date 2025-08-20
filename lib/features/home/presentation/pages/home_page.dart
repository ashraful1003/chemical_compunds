import 'dart:async';

import 'package:chemical_compounds/features/home/data/repositories/home_repositoy_impl.dart';
import 'package:chemical_compounds/features/home/presentation/bloc/home_bloc.dart';
import 'package:chemical_compounds/features/home/presentation/bloc/home_event.dart';
import 'package:chemical_compounds/features/home/presentation/bloc/home_state.dart';
import 'package:chemical_compounds/features/home/presentation/pages/widgets/compound_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //fetch compound from shared preferences
  final String compoundName = '2244';

  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  /// Handler for debounced searching.
  void _debounceSearch(BuildContext context, String value) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Dispatch search event
      context.read<HomeBloc>().add(FetchSearchApiEvent(query: value));
    });
  }

  void _getCompoundCIDByName(BuildContext context, String name) {
    context.read<HomeBloc>().add(FetchCIDApiEvent(compoundName: name));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) =>
          HomeBloc(context.read<HomeRepository>())
            ..add(FetchCompoundEvent(cids: compoundName)),
      child: Builder(
        builder: (BuildContext buildContext) {
          return Scaffold(
            appBar: _buildAppBar(buildContext),
            body: CustomScrollView(
              shrinkWrap: true,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: <Widget>[
                      _buildSuggestedKeyword(),
                      SizedBox(height: 10),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (BuildContext context, HomeState state) {
                          if (state is HomeLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is HomeLoaded) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.items.length,
                              //todo: initially shows from shared preferences
                              itemBuilder: (BuildContext context, int index) {
                                return CompoundItem(
                                  compound: state.items[index],
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
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Home'),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search Compound',
              hintText: 'Enter compound name...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {}); // update UI to hide suggestions
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
            keyboardType: TextInputType.text,
            onChanged: (String value) {
              setState(() {}); // refresh to update suggestions
              _debounceSearch(context, value);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestedKeyword() {
    if (_searchController.text.isEmpty) {
      return const SizedBox.shrink();
    }
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (HomeState previous, HomeState current) =>
          current is SearchApiLoading ||
          current is SearchApiLoaded ||
          current is SearchApiError,
      builder: (BuildContext context, HomeState state) {
        if (state is SearchApiLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchApiLoaded) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 6,
              runSpacing: 6,
              children: state.result.map((String keyword) {
                return GestureDetector(
                  onTap: () {
                    _getCompoundCIDByName(context, keyword);
                    setState(
                      () {},
                    ); // Refresh UI to hide suggestions if needed.
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      keyword,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        } else if (state is SearchApiError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
