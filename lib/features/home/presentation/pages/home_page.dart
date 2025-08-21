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
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
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
            ..add(FetchCompoundEvent(cids: '', compoundName: '')),
      child: Builder(
        builder: (BuildContext buildContext) {
          return Scaffold(
            appBar: _buildAppBar(buildContext),
            body: CustomScrollView(
              shrinkWrap: true,
              controller: _scrollController,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: <Widget>[
                      _buildSuggestedKeyword(),
                      SizedBox(height: 10),
                      _buildCompoundList(),
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

  Widget _buildCompoundList() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
        if (state.error != null) {
          return Center(child: Text(state.error ?? ''));
        } else if (state.compounds.isEmpty) {
          return const Center(
            child: Text(
              'No compounds found. Search for a compound name.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.compounds.length,
            itemBuilder: (BuildContext context, int index) {
              return CompoundItem(compound: state.compounds[index]);
            },
          );
        }
      },
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
              hintText: 'Enter compound name...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? BlocBuilder<HomeBloc, HomeState>(
                      builder: (BuildContext context, HomeState state) {
                        if (state.isCompoundLoading) {
                          return Container(
                            margin: EdgeInsets.only(right: 10),
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {}); // update UI to hide suggestions
                            },
                          );
                        }
                      },
                    )
                  : null,
              suffixIconConstraints: const BoxConstraints(
                minWidth: 15,
                minHeight: 15,
              ),

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
      builder: (BuildContext context, HomeState state) {
        if (state.isSearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.error != null) {
          return Center(child: Text(state.error ?? ''));
        } else if (state.searchResults.isNotEmpty) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 6,
              runSpacing: 6,
              children: state.searchResults.map((String keyword) {
                return GestureDetector(
                  onTap: () {
                    _getCompoundCIDByName(context, keyword);
                    setState(
                      () {},
                    ); // Refresh UI to hide suggestions if needed.
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      keyword,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
