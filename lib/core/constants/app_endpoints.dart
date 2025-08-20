class API {
  static const String compound = '/pug/compound';

  static String details({required String cids, required String properties}) =>
      '/$compound/cid/$cids/property/$properties/JSON';

  static String synonyms({required int cid}) =>
      '/$compound/cid/$cid/synonyms/JSON';

  static String search({required String query}) =>
      '/autocomplete/compound/$query/json';

  static String getCID({required String compoundName}) =>
      '/$compound/name/$compoundName/cids/JSON';

  static String description({required int cid}) =>
      '/$compound/cid/$cid/description/JSON';

  static String image({required int cid}) => '$compound/cid/$cid/PNG';
}
