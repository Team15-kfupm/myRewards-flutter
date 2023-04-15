import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class OfferModel {
  final String id;
  final String title;
  final int worthPoints;
  final String startDate;
  final String endDate;

  OfferModel({
    required this.id,
    required this.title,
    required this.worthPoints,
    required this.startDate,
    required this.endDate,
  });

  OfferModel.fromDocument(offer)
      : id = offer['id'] as String,
        title = offer['title'] as String,
        worthPoints = offer['worth_points'] as int,
        startDate = _dateFormatted(offer['start_date']),
        endDate = _dateFormatted(offer['end_date']);
}

String _dateFormatted(String offerTimestamp) {
  log(offerTimestamp);
  var f = DateFormat('EEE MMM d yyyy');
  var date2 = f.parse(offerTimestamp);
  log(date2.toString());

  return DateFormat('yyyy-MM-dd').format(date2);
}

// String _dateFormatted(Timestamp offerTimestamp) {
//   final offerDate = DateTime.fromMillisecondsSinceEpoch(
//       offerTimestamp.millisecondsSinceEpoch.toInt());

//   return DateFormat('yyyy-MM-dd').format(offerDate);
// }
