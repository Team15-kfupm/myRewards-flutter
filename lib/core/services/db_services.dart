import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myrewards_flutter/core/models/store_model.dart';
import 'package:myrewards_flutter/core/models/transaction_model.dart';
import 'package:myrewards_flutter/core/services/auth_services.dart';

import '../models/offer_model.dart';

class DB {
  final firebaseInstance = FirebaseFirestore.instance;

  Future<List<StoreModel>> getTopStores(Map storesPointsMap) async {
// Create a list to hold the store IDs and points
    final storesPoints = storesPointsMap.entries.toList();

// sort the stores by points in descending order
    storesPoints.sort((a, b) => b.value.compareTo(a.value));

// Get the top 5 stores
    var top5Stores = storesPoints.sublist(
        0, storesPoints.length >= 5 ? 5 : storesPoints.length);

// Create an array to hold the top 5 store documents
    List<Map<String, dynamic>> top5StoresDocs = [];

    for (var store in top5Stores) {
      final storeRef = firebaseInstance.collection('stores').doc(store.key);
      final storeDoc = await storeRef.get();
      List<OfferModel> offers = [];

// get offers for each store
      final storeOffersSnapshot = await storeRef.collection('offers').get();

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

      // Add the store document to the top5StoresDocs list with updated points
      var storeData = storeDoc.data() ?? {};
      var updatedStoreData = {
        ...storeData,
        'points': store.value,
        'offers': offers,
        'id': storeDoc.id,
      };
      top5StoresDocs.add(updatedStoreData);
    }

    // Create a list of StoreModel objects from the top5StoresDocs list
    return top5StoresDocs
        .map((store) => StoreModel.fromDocument(store))
        .toList();
  }

  Map _fetchTopStoresPoints(DocumentSnapshot store) {
    final storeData = store.data()! as Map<String, dynamic>;
    return storeData['points'];
  }

  Stream<Map> getTopStoresPoints(String userId) async* {
// Get the user document
    final userSnapshot =
        FirebaseFirestore.instance.collection('users').doc(userId).snapshots();

// Return the top 5 stores
    yield* userSnapshot.map(_fetchTopStoresPoints);

    // final HttpsCallable callable =
    //     FirebaseFunctions.instance.httpsCallable('getTopStores');

    // final result = await callable.call({'userId': userId});

    // final topStores = List<Map<Object?, Object?>>.from(result.data);
    // print(topStores);

    // yield topStores
    //     .map<StoreModel>((store) => StoreModel.fromSnapshot(store))
    //     .toList();
  }

  Future<String?> getStoreIdByName(String storeName) async {
    final storeQuery = await FirebaseFirestore.instance
        .collection('stores')
        .where('name', isEqualTo: storeName)
        .get();

    if (storeQuery.docs.isEmpty) {
      return null; // no store with the given name was found
    }

    final storeDoc = storeQuery.docs.first;
    return storeDoc.id;
  }

// Add a new transaction document to a user's "transactions" subcollection
  Future<void> addTransaction(String userId, String storeName, double amount,
      String type, DateTime date, String bankName) async {
    final transactionData = {
      'store_name': storeName,
      'amount': amount,
      'type': type,
      'date': date.toString().substring(0, 10).replaceAll('/', '-'),
      'bank_name': bankName,
    };
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .add(transactionData);
  }

// Get all transactions for a user
  Stream<List<TransactionModel>> getTransactions(String userId) {
    final transactionsQuery = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .orderBy('date', descending: true)
        .snapshots();

    return transactionsQuery.map((transactionSnapshot) => transactionSnapshot
        .docs
        .map((transactionDoc) => TransactionModel.fromSnapshot(transactionDoc))
        .toList());
  }

// Update a specific key in the "points" field for a user
  Future<void> updatePoints(
      String userId, String storeId, double newPoints) async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    final pointsMap = (await userDoc.get())['points'] ?? {};
    pointsMap[storeId] = newPoints;
    await userDoc.update({'points': pointsMap});
  }

  Future<void> updateUserPoints(
      String storeId, String userId, int points) async {
    final batch = firebaseInstance.batch();

// Update points in the store collection
    final storeRef = firebaseInstance.collection('stores').doc(storeId);
    final storePointsRef = storeRef.collection('points').doc(userId);
    batch.set(storePointsRef, {'value': points});

// Update points in the user collection
    final userRef = firebaseInstance.collection('users').doc(userId);
    final userPointsRef = userRef.collection('points').doc(storeId);
    batch.set(userPointsRef, {'value': points});

    await batch.commit();
  }

  Future<List<StoreModel>> getStoresWithOffers() async {
    final user = await AuthService().user.first;
    final storesRef = firebaseInstance.collection('stores');
    final storesSnapshot = await storesRef.get();
    final userDoc =
        await firebaseInstance.collection('users').doc(user.uid).get();

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
      // get points for each store for the current user
      final userSnapshot = userDoc.get('points') as Map<String, dynamic>;
      final userPoints = userSnapshot[storeDoc.id];

      if (userPoints != null) {
        points = userPoints;
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
