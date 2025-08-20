class API {
  static String details({required String cids, required String properties}) =>
      '/cid/$cids/property/$properties/JSON';

  static String synonyms({required int cid}) => '/cid/$cid/synonyms/JSON';

  static String description({required int cid}) => '/cid/$cid/description/JSON';

  static String image({required int cid}) => '/cid/$cid/PNG';
}
