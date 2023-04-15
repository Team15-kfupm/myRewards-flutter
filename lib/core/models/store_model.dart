import 'offer_model.dart';

class StoreModel {
  final String id;
  final String name;
  final String location;
  final List<OfferModel> offers;
  final int points;

  StoreModel({
    required this.id,
    required this.name,
    required this.location,
    required this.offers,
    required this.points,
  });

  StoreModel.fromDocument(store)
      : id = store['id'] as String,
        name = store['store_name'] as String,
        location = store['location'] as String,
        offers = store['offers'] as List<OfferModel>,
        points = store['points'] as int;

  StoreModel.fromSnapshot(store)
      : id = store['id'] as String,
        name = store['name'] as String,
        location = store['location'] as String,
        offers = store['offers'] as List<OfferModel>,
        points = store['points'] as int;
}
