import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:myrewards_flutter/core/models/user_info_model.dart';
import 'package:myrewards_flutter/core/providers/auth_user_state_provider.dart';
import 'package:myrewards_flutter/core/services/db_services.dart';
import 'package:myrewards_flutter/ui/pages/sign_in_page/sign_in_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants.dart';

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
        title: Text(
          'New Account',
          style: titleTextStyle,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparentColor,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25.0.w),
          children: <Widget>[
            100.verticalSpace,
            TextFormField(
              onChanged: (value) {
                ref.read(nameProvider.notifier).state = value;
                setState(() {});
              },
              enabled: true,
              decoration: InputDecoration(
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.r),
                    ),
                    borderSide: const BorderSide(color: Colors.red)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.r),
                    ),
                    borderSide: const BorderSide(color: Colors.red)),
                fillColor: whiteColor,
                focusColor: primaryColor,
                label: const Text('User Name'),
                labelStyle: const TextStyle(color: blackColor),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.r),
                    ),
                    borderSide: const BorderSide(color: primaryColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.r),
                    ),
                    borderSide: const BorderSide(color: primaryColor)),
                prefixIcon: const Icon(
                  Icons.person,
                  color: greyColor,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.w),
                hintText: 'Ali Ahmed',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your full name';
                }
                ref.read(nameProvider.notifier).state = value;
                return null;
              },
            ),
            16.verticalSpace,
            TextFormField(
              onChanged: (value) {
                ref.read(emailProvider.notifier).state = value;
              },
              enabled: true,
              decoration: InputDecoration(
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.r),
                    ),
                    borderSide: const BorderSide(color: Colors.red)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.r),
                    ),
                    borderSide: const BorderSide(color: Colors.red)),
                fillColor: whiteColor,
                focusColor: primaryColor,
                label: const Text('Email'),
                labelStyle: const TextStyle(color: blackColor),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.r),
                    ),
                    borderSide: const BorderSide(color: primaryColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.r),
                    ),
                    borderSide: const BorderSide(color: primaryColor)),
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: greyColor,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.w),
                hintText: 'ali@gmail.com',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email address';
                }
                if (EmailValidator.validate(value) == false) {
                  return 'Please enter a valid email address';
                }
                ref.read(emailProvider.notifier).state = value;
                return null;
              },
            ),
            16.verticalSpace,
            FormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              builder: (FormFieldState state) {
                return InkWell(
                  onTap: () => _selectDate(context),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.r),
                          ),
                          borderSide: const BorderSide(color: Colors.red)),
                      fillColor: whiteColor,
                      focusColor: primaryColor,
                      label: const Text('Birth Date'),
                      labelStyle: const TextStyle(color: blackColor),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.r),
                          ),
                          borderSide: const BorderSide(color: primaryColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.r),
                          ),
                          borderSide: const BorderSide(color: primaryColor)),
                      prefixIcon: const Icon(
                        Icons.date_range_rounded,
                        color: greyColor,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 25.h, horizontal: 10.w),
                      hintText: 'ali@gmail.com',
                    ),
                    child: Text(ref.read(birthDateProvider)),
                  ),
                );
              },
              validator: (value) {
                if (ref.read(birthDateProvider).isEmpty) {
                  return 'Please select your birth date';
                }

                return null;
              },
            ),
            16.verticalSpace,
            DropdownButtonFormField<String>(
              onChanged: (value) {
                ref.read(genderProvider.notifier).state = value!;
              },
              decoration: InputDecoration(
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.r),
                    ),
                    borderSide: const BorderSide(color: Colors.red)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.r),
                    ),
                    borderSide: const BorderSide(color: Colors.red)),
                fillColor: whiteColor,
                focusColor: primaryColor,
                label: const Text('Gender'),
                labelStyle: const TextStyle(color: blackColor),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.r),
                    ),
                    borderSide: const BorderSide(color: primaryColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.r),
                    ),
                    borderSide: const BorderSide(color: primaryColor)),
                prefixIcon: Icon(
                  ref.watch(genderProvider) == ''
                      ? Icons.people_outline
                      : ref.watch(genderProvider) == 'Male'
                          ? Icons.male_rounded
                          : Icons.female_rounded,
                  color: ref.watch(genderProvider) == ''
                      ? greyColor
                      : ref.watch(genderProvider) == 'Male'
                          ? Colors.blue
                          : Colors.pinkAccent,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.w),
              ),
              items: <String>['Male', 'Female']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text(''),
              validator: (value) {
                if (value == null) {
                  return 'Please select your gender';
                }
                ref.read(genderProvider.notifier).state = value;
                return null;
              },
            ),
            32.verticalSpace,
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
                      createdAt:
                          DateFormat('DD EEE yyyy').format(DateTime.now()),
                      birthDate: _selectedDate,
                      gender: ref.read(genderProvider),
                      points: {},
                      totalPoints: 0));

                  final sharedPref = await SharedPreferences.getInstance();
                  sharedPref.setBool('isFirst', true);
                }
              },
              child: Container(
                height: 60.h,
                width: 318.w,
                decoration: signInButtonStyle,
                child: Center(
                  child: Text(
                    'CREATE ACCOUNT',
                    style: signInButtonTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
