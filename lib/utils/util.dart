import 'package:capstone_final/models/model.dart';
import 'package:capstone_final/services/service.dart';
import 'package:capstone_final/shared/shared.dart';
import 'package:capstone_final/ui/ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io' show Platform;
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

part 'auth_util.dart';
part 'enum_util.dart';
part 'calendar_client.dart';
