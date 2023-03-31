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
}
