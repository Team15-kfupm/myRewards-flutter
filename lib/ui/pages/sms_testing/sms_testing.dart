import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

    final date = DateTime.parse('2023-04-05 04:13:00').millisecondsSinceEpoch;
    Future<List<SmsMessage>> messages = telephony.getInboxSms(
      filter: SmsFilter.where(SmsColumn.DATE).greaterThan('1680084457646'),
    );

    return Scaffold(
        body: FutureBuilder(
      builder: (context, messages) {
        if (messages.hasData) {
          return ListView.builder(
              itemCount: messages.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages.data![index].date.toString()),
                  subtitle: Text(messages.data![index].body),
                );
              });
        } else {
          log('messages has no data');
          return const Center(child: CircularProgressIndicator());
        }
      },
      future: messages,
      initialData: [],
    ));
  }
}
