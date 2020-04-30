//// Copyright 2019 The Flutter Authors. All rights reserved.
//// Use of this source code is governed by a BSD-style license that can be
//// found in the LICENSE file.
//
//// ignore_for_file: public_member_api_docs
//
//import 'dart:async';
//import 'dart:convert' show json;
//
//import "package:http/http.dart" as http;
//import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//
//class SignInDemo extends StatefulWidget {
//  @override
//  State createState() => SignInDemoState();
//}
//
//class SignInDemoState extends State<SignInDemo> {
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: const Text('Google Sign In'),
//        ),
//        body: ConstrainedBox(
//          constraints: const BoxConstraints.expand(),
//          child: _buildBody(),
//        ));
//  }
//}
