import 'package:chemical_compounds/core/constants/app_strings.dart';
import 'package:chemical_compounds/features/home/data/datasources/home_remote_data_source.dart';
import 'package:chemical_compounds/features/home/data/models/properties_model.dart';

class HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepository(this._remoteDataSource);

  Future<List<Property>> getItems({required String cids}) async {
    return await _remoteDataSource.fetchItems(
      cids: cids,
      properties: AppStrings.properties,
    );
  }

  Future<List<int>> getCID({required String compoundName}) async {
    return await _remoteDataSource.getCID(compoundName: compoundName);
  }

  Future<List<String>> searchCompound({required String query}) async {
    return await _remoteDataSource.searchCompound(query: query);
  }
}
