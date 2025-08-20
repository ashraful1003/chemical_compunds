import 'package:chemical_compounds/features/details/data/datasources/details_remote_data_source.dart';
import 'package:chemical_compounds/features/details/data/models/description_model.dart';
import 'package:chemical_compounds/features/details/data/models/synonyms_model.dart';

class DetailsRepository {
  final DetailsRemoteDataSource _remoteDataSource;

  DetailsRepository(this._remoteDataSource);

  Future<List<Description>> getDescription(int cid) async {
    return await _remoteDataSource.fetchDescription(cid);
  }

  Future<List<Synonym>> getSynonyms(int cid) async {
    return await _remoteDataSource.fetchSynonyms(cid);
  }
}
