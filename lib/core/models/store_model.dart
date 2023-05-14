import 'offer_model.dart';

class StoreModel {
  final String id;
  final String name;
  final List<OfferModel> offers;
  final num points;

  StoreModel({
    required this.id,
    required this.name,
    required this.offers,
    required this.points,
  });

  StoreModel.fromDocument(store)
      : id = store['id'] as String,
        name = store['store_name'] as String,
        offers = store['offers'] as List<OfferModel>,
        points = store['points'] as num;

  StoreModel.fromSnapshot(store)
      : id = store['id'] as String,
        name = store['name'] as String,
        offers = store['offers'] as List<OfferModel>,
        points = store['points'] as double;
}
