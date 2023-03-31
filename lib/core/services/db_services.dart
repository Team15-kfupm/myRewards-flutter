import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myrewards_flutter/core/models/store_model.dart';
import 'package:myrewards_flutter/core/services/auth_services.dart';

import '../models/offer_model.dart';

class DB {
  final firebaseInstance = FirebaseFirestore.instance;

  Future<List<StoreModel>> getStoresWithOffers() async {
    final storesRef = firebaseInstance.collection('stores');
    final storesSnapshot = await storesRef.get();

    final stores = <StoreModel>[];
    for (final storeDoc in storesSnapshot.docs) {
      List<OfferModel> offers = [];
      int points = 0;

// get offers for each store
      final storeOffersSnapshot =
          await storeDoc.reference.collection('offers').get();

      for (final storeOfferDoc in storeOffersSnapshot.docs) {
        final offer = OfferModel(
          id: storeOfferDoc.id,
          title: storeOfferDoc.data()['title'],
          startDate: DateTime.parse(storeOfferDoc.data()['start_date']),
          endDate: DateTime.parse(storeOfferDoc.data()['end_date']),
          points: storeOfferDoc.data()['points'],
        );
        offers.add(offer);
      }
      final user = await AuthService().user.first;
      final userPoints = await storeDoc.reference
          .collection('points')
          .where('user_id', isEqualTo: user.uid)
          .get();

      if (userPoints.docs.isNotEmpty) {
        points = userPoints.docs.first.data()['value'];
      }
      final store = StoreModel(
        id: storeDoc.id,
        name: storeDoc.data()['name'],
        location: storeDoc.data()['location'],
        offers: offers,
        points: points,
      );

      stores.add(store);
    }
    return stores;
  }
  // Future<void> createStoreWithOffers(
  //     String name, String location, List<Map<String, dynamic>> offers) async {
  //   for (var store in stores) {
  //     try {
  //       // Create a new store document with the given name and location
  //       DocumentReference storeRef =
  //           await FirebaseFirestore.instance.collection('stores').add({
  //         'name': store['name'],
  //         'location': store['location'],
  //       });

  //       // Create a new offer subcollection for the store
  //       CollectionReference offerRef = storeRef.collection('offers');

  //       // Add each offer document to the offer subcollection
  //       for (final offer in store['offers'] as List) {
  //         await offerRef.add(offer);
  //       }
  //     } catch (e) {
  //       print('Error creating store with offers: $e');
  //       rethrow;
  //     }
  //   }
  // }
}
