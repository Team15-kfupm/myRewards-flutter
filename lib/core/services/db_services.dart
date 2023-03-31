import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myrewards_flutter/core/models/store_model.dart';

import '../models/offer_model.dart';

class DB {
  final firebaseInstance = FirebaseFirestore.instance;

  Future<List<StoreModel>> getStoresWithOffers() async {
    final storesSnapshot =
        await FirebaseFirestore.instance.collection('stores').get();

    final stores = <StoreModel>[];
    for (final storeDoc in storesSnapshot.docs) {
      final store = StoreModel(
        id: storeDoc.id,
        name: storeDoc.data()['name'],
        location: storeDoc.data()['location'],
        offers: [],
      );

      final storeOffersSnapshot = await FirebaseFirestore.instance
          .collection('store_offers')
          .where('store', isEqualTo: storeDoc.reference)
          .get();

      for (final storeOfferDoc in storeOffersSnapshot.docs) {
        final offerDoc = await storeOfferDoc.data()['offer'].get();
        final offer = Offer(
          id: offerDoc.id,
          title: offerDoc.data()['title'],
          startDate: offerDoc.data()['start_date'].toDate(),
          endDate: offerDoc.data()['end_date'].toDate(),
          points: offerDoc.data()['points'],
        );
        store.offers.add(offer);
      }

      stores.add(store);
    }

    return stores;
  }

  final stores = [
    {
      'name': 'Store A',
      'location': 'Location A',
      'offers': [
        {
          'title': 'Offer 1',
          'start_date': DateTime(2022, 1, 1),
          'end_date': DateTime(2022, 1, 31),
          'points': 50,
        },
        {
          'title': 'Offer 2',
          'start_date': DateTime(2022, 2, 1),
          'end_date': DateTime(2022, 2, 28),
          'points': 100,
        },
      ],
    },
    {
      'name': 'Store B',
      'location': 'Location B',
      'offers': [
        {
          'title': 'Offer 3',
          'start_date': DateTime(2022, 3, 1),
          'end_date': DateTime(2022, 3, 31),
          'points': 75,
        },
      ],
    },
    {
      'name': 'Store C',
      'location': 'Location C',
      'offers': [],
    },
    {
      'name': 'Store D',
      'location': 'Location D',
      'offers': [
        {
          'title': 'Offer 4',
          'start_date': DateTime(2022, 4, 1),
          'end_date': DateTime(2022, 4, 30),
          'points': 150,
        },
        {
          'title': 'Offer 5',
          'start_date': DateTime(2022, 5, 1),
          'end_date': DateTime(2022, 5, 31),
          'points': 200,
        },
      ],
    },
    {
      'name': 'Store E',
      'location': 'Location E',
      'offers': [],
    },
    {
      'name': 'Store F',
      'location': 'Location F',
      'offers': [
        {
          'title': 'Offer 6',
          'start_date': DateTime(2022, 6, 1),
          'end_date': DateTime(2022, 6, 30),
          'points': 50,
        },
      ],
    },
    {
      'name': 'Store G',
      'location': 'Location G',
      'offers': [
        {
          'title': 'Offer 7',
          'start_date': DateTime(2022, 7, 1),
          'end_date': DateTime(2022, 7, 31),
          'points': 100,
        },
      ],
    },
    {
      'name': 'Store H',
      'location': 'Location H',
      'offers': [
        {
          'title': 'Offer 8',
          'start_date': DateTime(2022, 8, 1),
          'end_date': DateTime(2022, 8, 31),
          'points': 75,
        },
        {
          'title': 'Offer 9',
          'start_date': DateTime(2022, 9, 1),
          'end_date': DateTime(2022, 9, 30),
          'points': 150,
        },
      ],
    },
  ];

  Future<void> createStoreWithOffers(
      String name, String location, List<Map<String, dynamic>> offers) async {
    for (var store in stores) {
      try {
        // Create a new store document with the given name and location
        DocumentReference storeRef =
            await FirebaseFirestore.instance.collection('stores').add({
          'name': store['name'],
          'location': store['location'],
        });

        // Create a new offer subcollection for the store
        CollectionReference offerRef = storeRef.collection('offers');

        // Add each offer document to the offer subcollection
        for (final offer in store['offers'] as List) {
          await offerRef.add(offer);
        }
      } catch (e) {
        print('Error creating store with offers: $e');
        rethrow;
      }
    }
  }
}
