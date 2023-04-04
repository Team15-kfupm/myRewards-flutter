import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myrewards_flutter/core/models/store_model.dart';
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

// // Get the user points map
//     Map<String, dynamic> userPointsMap = store.get('points');

// // Create a list to hold the store IDs and points
//     var storesPoints = userPointsMap.entries.toList();

// // sort the stores by points in descending order
//     storesPoints.sort((a, b) => b.value.compareTo(a.value));

// // Get the top 5 stores
//     var top5Stores = storesPoints.sublist(
//         0, storesPoints.length >= 5 ? 5 : storesPoints.length);

// // Create an array to hold the top 5 store documents
//     List<Map<String, dynamic>> top5StoresDocs = [];
//     List<OfferModel> offers = [];

// Iterate through each top 5 store and retrieve the store document
//     for (var store in top5Stores) {
//       final storeRef =
//           FirebaseFirestore.instance.collection('stores').doc(store.key);
//       final storeDoc = await storeRef.get();

// // get offers for each store
//       final storeOffersSnapshot = await storeRef.collection('offers').get();

//       for (final storeOfferDoc in storeOffersSnapshot.docs) {
//         final offer = OfferModel(
//           id: storeOfferDoc.id,
//           title: storeOfferDoc.data()['title'],
//           startDate: DateTime.parse(storeOfferDoc.data()['start_date']),
//           endDate: DateTime.parse(storeOfferDoc.data()['end_date']),
//           points: storeOfferDoc.data()['points'],
//         );

//         offers.add(offer);
//       }

//       // Add the store document to the top5StoresDocs list with updated points
//       var storeData = storeDoc.data() ?? {};
//       var updatedStoreData = {
//         ...storeData,
//         'points': store.value,
//         'offers': offers
//       };
//       top5StoresDocs.add(updatedStoreData);
//     }
// return top5StoresDocs
//         .map<StoreModel>((store) => StoreModel.fromSnapshot(store))
//         .toList();
  }

  Stream<Map> getTopStoresPoints(String userId) async* {
// Get the user document
    final userSnapshot =
        FirebaseFirestore.instance.collection('users').doc(userId).snapshots();

// // Get the user points map
//     Map<String, dynamic> userPointsMap = store.get('points');

// // Create a list to hold the store IDs and points
//     var storesPoints = userPointsMap.entries.toList();

// // sort the stores by points in descending order
//     storesPoints.sort((a, b) => b.value.compareTo(a.value));

// // Get the top 5 stores
//     var top5Stores = storesPoints.sublist(
//         0, storesPoints.length >= 5 ? 5 : storesPoints.length);

// // Create an array to hold the top 5 store documents
//     List<Map<String, dynamic>> top5StoresDocs = [];
//     List<OfferModel> offers = [];

// Iterate through each top 5 store and retrieve the store document
//     for (var store in top5Stores) {
//       final storeRef =
//           FirebaseFirestore.instance.collection('stores').doc(store.key);
//       final storeDoc = await storeRef.get();

// // get offers for each store
//       final storeOffersSnapshot = await storeRef.collection('offers').get();

//       for (final storeOfferDoc in storeOffersSnapshot.docs) {
//         final offer = OfferModel(
//           id: storeOfferDoc.id,
//           title: storeOfferDoc.data()['title'],
//           startDate: DateTime.parse(storeOfferDoc.data()['start_date']),
//           endDate: DateTime.parse(storeOfferDoc.data()['end_date']),
//           points: storeOfferDoc.data()['points'],
//         );

//         offers.add(offer);
//       }

//       // Add the store document to the top5StoresDocs list with updated points
//       var storeData = storeDoc.data() ?? {};
//       var updatedStoreData = {
//         ...storeData,
//         'points': store.value,
//         'offers': offers
//       };
//       top5StoresDocs.add(updatedStoreData);
//     }
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
      'date': Timestamp.fromDate(date),
      'bank_name': bankName,
    };
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .add(transactionData);
  }

// Get all transactions for a user
  Stream<QuerySnapshot> getTransactions(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .orderBy('date', descending: true)
        .snapshots();
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

//   Future<void> initiateHomePage(String userId) async {
//     final storesRef = firebaseInstance.collection('stores');
//     final pointsRef =
//         firebaseInstance.collection('users').doc(userId).collection('points');

//     final storesSnapshot = await storesRef.get();
//     final pointsSnapshot = await pointsRef.get();

//     final storesPointsMap = {};

// // Iterate through the stores to initialize the storesPointsMap with the points for each store
//     storesSnapshot.docs.forEach((storeDoc) {
//       final storeId = storeDoc.id;
//       storesPointsMap[storeId] = 0;
//     });

// // Iterate through the points to update the storesPointsMap with the total points for each store
//     pointsSnapshot.docs.forEach((pointDoc) {
//       final storeId = pointDoc.id;
//       final points = pointDoc.data()['value'];
//       storesPointsMap[storeId] += points;
//     });

// // Sort the storesPointsMap in descending order by points
//     final sortedStoresPointsList = storesPointsMap.entries.toList()
//       ..sort((a, b) => b.value.compareTo(a.value));

// // Get the top 5 stores with the highest points
//     final top5Stores = sortedStoresPointsList.take(5);

// // Get the store details for the top 5 stores
//     final top5StoresDetails = await Future.wait(
//         top5Stores.map((storeEntry) => storesRef.doc(storeEntry.key).get()));

// // Print the details of the top 5 stores
//     top5StoresDetails.forEach((storeDoc) {
//       print(
//           'Store name: ${storeDoc.data()!['name']}, Points: ${storesPointsMap[storeDoc.id]}');
//     });
//   }

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
