import 'dart:developer';

import 'package:background_fetch/background_fetch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:myrewards_flutter/core/models/message_model.dart';
import 'package:myrewards_flutter/core/models/store_model.dart';
import 'package:myrewards_flutter/core/models/transaction_model.dart';
import 'package:myrewards_flutter/core/models/transactions_by_month.dart';
import 'package:myrewards_flutter/core/models/user_info_model.dart';
import 'package:myrewards_flutter/core/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';

import '../../utils/constants.dart';
import '../models/offer_model.dart';

class DB {
  final firebaseInstance = FirebaseFirestore.instance;

  void initBackgroundFetch() async {
    BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        enableHeadless: true,
        forceAlarmManager: false,
        startOnBoot: true,
      ),
      (taskId) async {
        log('background fetch started');
        try {
          await Firebase.initializeApp(
              options: const FirebaseOptions(
                  apiKey: apiKey,
                  appId: appId,
                  messagingSenderId: messagingSenderId,
                  projectId: projectId));
          Telephony telephony = Telephony.instance;
          final user = await AuthService().user.first;
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

          log('userId: ${user.uid.toString()}');
          final batch = FirebaseFirestore.instance.batch();
          final transactionsByMonthCollection = FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('transactions-by-month');

          final date = DateFormat('yyyy-MM').format(DateTime.now());

          await transactionsByMonthCollection
              .doc(date)
              .set({}, SetOptions(merge: true));

          await transactionsByMonthCollection
              .doc(date)
              .collection('transactions')
              .doc('0')
              .set({});

          final lastTransactionDateTimeInMilliSecond =
              userDoc.get('last_transaction_date');
          var lastTransactionDate = lastTransactionDateTimeInMilliSecond;

          List<SmsMessage> messages = await telephony.getInboxSms(
              filter: SmsFilter.where(SmsColumn.DATE).greaterThan(
                  lastTransactionDateTimeInMilliSecond.toString()));
          log('messages length: ${messages.length}');

          for (var message in messages.reversed) {
            lastTransactionDate = message.date ?? -1;
            if (message.address!.contains('+') ||
                message.address!.contains('0')) {
              continue;
            }
            final messageInfo = DB().extractPurchaseInfoFromMessage(message);
            log(messageInfo.amount.toString());
            if (messageInfo.amount != 0) {
              final monthRef = transactionsByMonthCollection
                  .doc(messageInfo.date.substring(0, 7));
              final transactionRef = monthRef.collection('transactions').doc();

              batch.set(transactionRef, {
                'store_name': messageInfo.storeName,
                'amount': messageInfo.amount,
                'date': messageInfo.date,
                'time': messageInfo.time,
                'bank_name': messageInfo.bankName,
                'category': '',
              });
            }
          }
          batch.update(userDoc.reference, {
            'last_transaction_date': lastTransactionDate,
          });
          await batch.commit();
          log('background fetch finished');
          BackgroundFetch.finish(taskId);
        } catch (e) {
          log('Error message: ${e.toString()}');
          BackgroundFetch.finish(taskId);
        }
      },
    );
    log('background fetch initialized');
  }

  // Define a top-level function to handle background messages
  static myBackgroundMessageHandler(SmsMessage message) async {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: apiKey,
            appId: appId,
            messagingSenderId: messagingSenderId,
            projectId: projectId));
    // Extract the SMS message from the map

    final user = await AuthService().user.first;
    log('back: ${message.body!}');
    // Handle the SMS message
    final messageInfo = DB().extractPurchaseInfoFromMessage(message);
    if (messageInfo.amount != 0) {
      DB().addTransaction(user.uid, messageInfo.storeName, messageInfo.amount,
          messageInfo.date, messageInfo.time, messageInfo.bankName);
    }
  }

  // initialize messages listener
  initMessagesListener() async {
    Telephony telephony = Telephony.instance;
    log('start initi messages listener');
    final user = await AuthService().user.first;

    telephony.listenIncomingSms(
        onBackgroundMessage: myBackgroundMessageHandler,
        onNewMessage: (message) async {
          log('front: ${message.body!}');
          final messageInfo = DB().extractPurchaseInfoFromMessage(message);
          if (messageInfo.amount != 0) {
            await DB().addTransaction(
                user.uid,
                messageInfo.storeName,
                messageInfo.amount,
                messageInfo.date,
                messageInfo.time,
                messageInfo.bankName);
          }
        });

    log('messages listener initialized');
  }

  Future<void> runOnceAfterInstallation() async {
    await isNewUser();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      Telephony telephony = Telephony.instance;
      final user = await AuthService().user.first;
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      log('userId: ${user.uid.toString()}');
      final batch = FirebaseFirestore.instance.batch();
      final transactionsByMonthCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('transactions-by-month');

      final currentMonth = DateFormat('yyyy-MM').format(DateTime.now());
      final lastMonth = DateFormat('yyyy-MM').format(DateTime.now().day == 31
          ? DateTime.now().subtract(const Duration(days: 31))
          : DateTime.now().subtract(const Duration(days: 30)));
      final lastMonth2 = DateFormat('yyyy-MM').format(DateTime.now().day == 31
          ? DateTime.now().subtract(const Duration(days: 62))
          : DateTime.now().subtract(const Duration(days: 60)));

      await transactionsByMonthCollection
          .doc(currentMonth)
          .set({'categories': {}}, SetOptions(merge: true));
      await transactionsByMonthCollection
          .doc(lastMonth)
          .set({'categories': {}}, SetOptions(merge: true));
      await transactionsByMonthCollection
          .doc(lastMonth2)
          .set({'categories': {}}, SetOptions(merge: true));

      var lastTransactionDate = -1;

      List<SmsMessage> messages = await telephony.getInboxSms(
          filter: SmsFilter.where(SmsColumn.DATE).greaterThan(
              DateFormat("yyyy-MM-dd")
                  .parse("$lastMonth2-01")
                  .millisecondsSinceEpoch
                  .toString()));
      for (var message in messages.reversed) {
        lastTransactionDate = message.date ?? -1;
        if (message.address!.contains('+') || message.address!.contains('0')) {
          continue;
        }
        final messageInfo = DB().extractPurchaseInfoFromMessage(message);

        if (messageInfo.amount != 0) {
          final monthRef = transactionsByMonthCollection
              .doc(messageInfo.date.substring(0, 7));
          final transactionRef = monthRef.collection('transactions').doc();

          batch.set(transactionRef, {
            'store_name': messageInfo.storeName,
            'amount': messageInfo.amount,
            'date': messageInfo.date,
            'time': messageInfo.time,
            'bank_name': messageInfo.bankName,
            'category': '',
          });
        }
      }
      batch.update(userDoc.reference, {
        'last_transaction_date': lastTransactionDate,
      });
      batch.delete(transactionsByMonthCollection
          .doc(currentMonth)
          .collection('transactions')
          .doc('0'));
      batch.delete(transactionsByMonthCollection
          .doc(lastMonth)
          .collection('transactions')
          .doc('0'));
      batch.delete(transactionsByMonthCollection
          .doc(lastMonth2)
          .collection('transactions')
          .doc('0'));
      await batch.commit();
      prefs.setBool('isFirstTime', false);
      log('initiate is finished');
    }
  }

  MessageModel extractPurchaseInfoFromMessage(SmsMessage sms) {
    // Check if text matches either pattern
    final enMatch = RegExp(enPattern).firstMatch(sms.body!);
    final arMatch = RegExp(arPattern).firstMatch(sms.body!);
    final MessageModel messageInfo;

    if (enMatch != null) {
      log('EN Match');
      final amount = double.parse(enMatch.group(1)!);
      final storeName = enMatch.group(3)!;
      final date = enMatch.group(4)!;
      final time = enMatch.group(5)!;
      // final time = enMatch.group(6);
      messageInfo = MessageModel(
        amount: amount,
        storeName: storeName,
        date: date,
        time: time,
        bankName: sms.address!,
      );
    } else if (arMatch != null) {
      log('AR Match');
      final amount = double.parse(arMatch.group(2)!);
      final storeName = arMatch.group(4);
      final date = arMatch.group(5)!;
      final time = arMatch.group(6) ?? '';
      messageInfo = MessageModel(
        amount: amount,
        storeName: storeName!,
        date: date,
        time: time,
        bankName: sms.address!,
      );
    } else {
      log('no match');
      return MessageModel(
        storeName: '',
        amount: 0,
        date: '',
        time: '',
        bankName: '',
      );
    }

    return messageInfo;
  }

  // Add a new transaction document to a user's "transactions" subcollection
  Future<void> addTransaction(String userId, String storeName, double amount,
      String date, String time, String bankName) async {
    final transactionData = {
      'store_name': storeName,
      'amount': amount,
      'date': date.toString().substring(0, 10),
      'time': time,
      'category': '',
      'bank_name': bankName,
    };
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('transactions-by-month')
        .doc(date.toString().substring(0, 7))
        .collection('transactions')
        .add(transactionData);
  }

// Get all transactions for a user
  Stream<List<TransactionsByMonthModel>> getTransactionsByMonth(String userId) {
    final transactionsByMonthSnapshot = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('transactions-by-month')
        .snapshots();

    return transactionsByMonthSnapshot.map((transactionsByMonthQuery) =>
        transactionsByMonthQuery.docs
            .map((transactionsByMonthDoc) =>
                TransactionsByMonthModel.fromDoc(transactionsByMonthDoc))
            .toList());
  }

  // Get transactions for a user for a specific month
  Future<List<TransactionModel>> getTransactionsForMonth(
      String userId, String docId) async {
    final transactionsQuery = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('transactions-by-month')
        .doc(docId)
        .collection('transactions')
        .get();

    return transactionsQuery.docs
        .map(
            (transactionsDoc) => TransactionModel.fromSnapshot(transactionsDoc))
        .toList();
  }

  Future<String> claimOffer(
      String userId, String offerId, String storeId) async {
    final HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('claimOffer');

    final result = await callable
        .call({'offer_id': offerId, 'user_id': userId, 'store_id': storeId});

    return result.data['code'];
  }

  Stream<String> isExpired(String offerId) async* {
    final tempClaimSnapshot =
        firebaseInstance.collection('temp-claim').snapshots();

    final user = await AuthService().user.first;

    yield* tempClaimSnapshot
        .map((snapShot) => _fetchCode(snapShot, offerId, user.uid));
  }

  String _fetchCode(QuerySnapshot<Map<String, dynamic>> snapshot,
      String offerId, String userId) {
    final tempClaimDoc = snapshot.docs;

    final codeDocs = tempClaimDoc.where((tempClaim) =>
        tempClaim.get('offer_id') == offerId && tempClaim.get('uid') == userId);
    final code = codeDocs.isNotEmpty ? codeDocs.first.get('code') : '';

    return code;
  }

  Stream<bool> hasOtherCode(String storeId) async* {
    final tempClaimSnapshot =
        firebaseInstance.collection('temp-claim').snapshots();

    final user = await AuthService().user.first;

    yield* tempClaimSnapshot.map((tempClaimSnapShot) =>
        _fetchHasOtherCode(tempClaimSnapShot, storeId, user.uid));
  }

  bool _fetchHasOtherCode(QuerySnapshot<Map<String, dynamic>> snapshot,
      String storeId, String userId) {
    final tempClaimDoc = snapshot.docs;
    final hasCode = tempClaimDoc
        .where((tempClaim) =>
            tempClaim.get('store_id') == storeId &&
            tempClaim.get('uid') == userId)
        .isNotEmpty;

    return hasCode;
  }

  Future<void> updateStorePoints(
      String userId, String storeId, int points) async {
    final userRef = firebaseInstance.collection('users').doc(userId);

    final userDoc = await userRef.get();

    final userPoints = userDoc.data()!['points'] as Map<String, dynamic>;

    userPoints.update(storeId, (vlaue) => vlaue - points);

    await userRef.update({'points': userPoints});
  }

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
        final offer = OfferModel.fromDocument(storeOfferDoc.data());

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
    final userData = store.data()! as Map<String, dynamic>;
    return userData['points'];
  }

  Stream<Map> getTopStoresPoints(String userId) async* {
// Get the user document
    final userSnapshot =
        FirebaseFirestore.instance.collection('users').doc(userId).snapshots();

// Return the top 5 stores
    yield* userSnapshot.map(_fetchTopStoresPoints);
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

// Update a specific key in the "points" field for a user
  Future<void> updatePoints(
      String userId, String storeId, double newPoints) async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    final pointsMap = (await userDoc.get())['points'] ?? {};
    pointsMap[storeId] = newPoints;
    await userDoc.update({'points': pointsMap});
  }

  Future<List<StoreModel>> getStoresWithOffers() async {
    final user = await AuthService().user.first;
    final storesRef = firebaseInstance
        .collection('stores')
        .where('num_of_offers', isGreaterThan: 0);
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
        final offer = OfferModel.fromDocument(storeOfferDoc.data());
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
        name: storeDoc.data()['store_name'],
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

  Future addNewUser(UserInfoModel userInfo) async {
    await firebaseInstance.collection('users').doc(userInfo.uid).set({
      'name': userInfo.name,
      'email': userInfo.email,
      'phone': userInfo.phone,
      'gender': userInfo.gender,
      'birth_date': userInfo.birthDate.toString(),
      'total_points': 0,
      'last_transaction_date': 0,
      'top_stores': {},
      'points': {},
    });
  }

  Future<void> isNewUser() async {
    final user = await AuthService().user.first;
    final userDoc = await firebaseInstance
        .collection('users')
        .doc(user.uid)
        .collection('transactions-by-month')
        .doc(DateFormat('yyyy-MM').format(DateTime.now()))
        .get();
    final sharedPref = await SharedPreferences.getInstance();
    if (userDoc.exists) {
      sharedPref.setBool('isFirst', false);
    } else {
      sharedPref.setBool('isFirst', false);
    }
  }

  Future<bool> updateUserName(String userName, String uid) async {
    final userDoc = await firebaseInstance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      await firebaseInstance.collection('users').doc(uid).update({
        'name': userName,
      });
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateEmail(String email, String uid) async {
    final userDoc = await firebaseInstance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      await firebaseInstance.collection('users').doc(uid).update({
        'email': email,
      });
      return true;
    } else {
      return false;
    }
  }

  Future<bool> upDateBirthDate(String birthDate, String uid) async {
    final userDoc = await firebaseInstance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      await firebaseInstance.collection('users').doc(uid).update({
        'birth_date': birthDate,
      });
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateGender(String gender, String uid) async {
    final userDoc = await firebaseInstance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      await firebaseInstance.collection('users').doc(uid).update({
        'gender': gender,
      });
      return true;
    } else {
      return false;
    }
  }
}
