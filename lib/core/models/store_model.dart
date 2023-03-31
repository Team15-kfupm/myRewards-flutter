import 'offer_model.dart';

class StoreModel {
  final String id;
  final String name;
  final String location;
  final List<Offer> offers;

  StoreModel({
    required this.id,
    required this.name,
    required this.location,
    required this.offers,
  });
}
