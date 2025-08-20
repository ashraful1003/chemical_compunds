import 'package:chemical_compounds/core/constants/app_endpoints.dart';
import 'package:chemical_compounds/features/details/data/models/description_model.dart';
import 'package:chemical_compounds/features/details/data/repositories/details_repository_impl.dart';
import 'package:chemical_compounds/features/details/presentation/bloc/details_bloc.dart';
import 'package:chemical_compounds/features/details/presentation/bloc/details_event.dart';
import 'package:chemical_compounds/features/details/presentation/bloc/details_state.dart';
import 'package:chemical_compounds/features/details/presentation/pages/widgets/folding_card.dart';
import 'package:chemical_compounds/features/details/presentation/pages/widgets/normal_card.dart';
import 'package:chemical_compounds/features/widgets/network_image_view.dart';
import 'package:chemical_compounds/flavors/configure/build_config.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({required this.cid, required this.iupacName, super.key});

  final int cid;
  final String iupacName;

  static final String baseUrl = BuildConfig.instance.config.baseUrl;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailsBloc>(
      create: (BuildContext context) =>
          DetailsBloc(context.read<DetailsRepository>())
            ..add(FetchDetailsEvent(cid)),
      child: Scaffold(
        appBar: AppBar(title: Text('Details Page')),
        body: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (BuildContext context, DetailsState state) {
            if (state is DetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DetailLoaded) {
              final List<String> descriptions = state.listOfDescription
                  .where(
                    (Description des) => des.description?.isNotEmpty ?? false,
                  )
                  .mapIndexed(
                    (int index, Description e) =>
                        '${index + 1}. ${e.description}',
                  )
                  .toList();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Text(
                              state.listOfDescription[0].title ?? '',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          NormalCard(
                            title: 'IUPAC Name: ',
                            description: iupacName,
                          ),
                          const SizedBox(height: 8),
                          _buildCompoundImage(context),
                          const SizedBox(height: 8),
                          if (state.listOfSynonyms[0].casNumber.isNotEmpty)
                            _buildCASNumber(state),
                          FoldingCard(
                            title: 'Synonyms',
                            description: state.listOfSynonyms[0].listOfSynonym
                                .join(', '),
                          ),
                          const SizedBox(height: 8),
                          FoldingCard(
                            title: 'Description',
                            description: descriptions
                                .where((String des) => des.isNotEmpty)
                                .join('\n'),
                          ),
                        ],
                      ),
                    ),
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

  Widget _buildCASNumber(DetailLoaded state) {
    return Column(
      children: <Widget>[
        NormalCard(
          title: 'CAS Number: ',
          description: state.listOfSynonyms[0].casNumber,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildCompoundImage(BuildContext context) {
    return NetworkImageView(
      '$baseUrl/${API.image(cid: cid)}',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
    );
  }
}
