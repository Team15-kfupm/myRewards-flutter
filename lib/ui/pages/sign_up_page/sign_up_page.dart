import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myrewards_flutter/core/models/user_info_model.dart';
import 'package:myrewards_flutter/core/providers/auth_user_state_provider.dart';
import 'package:myrewards_flutter/core/services/db_services.dart';
import 'package:myrewards_flutter/ui/pages/sign_in_page/sign_in_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final nameProvider = StateProvider<String>((ref) => '');
  final emailProvider = StateProvider<String>((ref) => '');
  final birthDateProvider = StateProvider<String>((ref) => '');
  final genderProvider = StateProvider<String>((ref) => '');

  DateTime _selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        initialDate: _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        context: context);
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        ref.read(birthDateProvider.notifier).state =
            DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Full Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your full name';
                }
                ref.read(nameProvider.notifier).state = value;
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email address';
                }
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                ref.read(emailProvider.notifier).state = value;
                return null;
              },
            ),
            SizedBox(height: 16.0),
            FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                builder: (FormFieldState state) {
                  return InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Birth Date',
                      ),
                      child: Text(ref.read(birthDateProvider)),
                    ),
                  );
                }

                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please select your birth date';
                //   }
                //   ref.read(birthDateProvider.notifier).state = value;
                //   return null;
                // },
                ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              onChanged: (value) {
                ref.read(genderProvider.notifier).state = value!;
              },
              decoration: InputDecoration(
                labelText: 'Gender',
              ),
              items: <String>['Male', 'Female', 'Other']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select your gender';
                }
                ref.read(genderProvider.notifier).state = value;
                return null;
              },
            ),
            SizedBox(height: 32.0),
            InkWell(
              onTap: () async {
                final phoneNumber = ref.read(phoneProvider);
                final user = ref.read(authUserProvider);
                if (_formKey.currentState!.validate()) {
                  await DB().addNewUser(UserInfoModel(
                      uid: user.value!.uid,
                      name: ref.read(nameProvider),
                      email: ref.read(emailProvider),
                      phone: phoneNumber,
                      birthDate: _selectedDate,
                      gender: ref.read(genderProvider),
                      points: {},
                      totalPoints: 0));

                  final sharedPref = await SharedPreferences.getInstance();
                  sharedPref.setBool('isFirst', true);
                }
              },
              child: Container(child: Text('Create Account')),
            )
          ],
        ),
      ),
    );
  }
}
