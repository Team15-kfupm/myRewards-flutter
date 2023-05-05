import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myrewards_flutter/core/models/message_model.dart';
import 'package:myrewards_flutter/core/services/db_services.dart';
import 'package:telephony/telephony.dart';

class SmsTesting extends StatefulWidget {
  const SmsTesting({super.key});

  @override
  State<SmsTesting> createState() => _SmsTestingState();
}

class _SmsTestingState extends State<SmsTesting> {
  @override
  Widget build(BuildContext context) {
    Telephony telephony = Telephony.instance;

    Future<List<SmsMessage>> messages = telephony.getInboxSms(
      filter:
          SmsFilter.where(SmsColumn.DATE).greaterThanOrEqualTo('1680084457646'),
    );
    List<MessageModel> messagesModel = [];
    return Scaffold(
        body: FutureBuilder(
      builder: (context, messages) {
        if (messages.connectionState == ConnectionState.done) {
          for (SmsMessage element in messages.data!) {
            final sms = DB().extractPurchaseInfoFromMessage(element);
            if (sms.amount != 0) messagesModel.add(sms);

            // log(sms.amount.toString());
            // log(sms.storeName);
            // log(sms.bankName);
            // log(sms.date.toString());
            // log(sms.time.toString());
            // log('-----------------');
          }

          log('length: ${messagesModel.length.toString()}');
          return ListView.builder(
              itemCount: messagesModel.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messagesModel[index].storeName.toString().trim()),
                  subtitle:
                      Text(messagesModel[index].bankName.toString().trim()),
                  isThreeLine: true,
                  trailing: Text(messagesModel[index].date.toString()),
                );
              });
        } else {
          log('messages has no data');
          return const Center(child: CircularProgressIndicator());
        }
      },
      future: messages,
      initialData: const [],
    ));
  }
}
