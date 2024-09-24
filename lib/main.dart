import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_pitfall_example/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {

  Bloc.transformer = sequential();

  
  runApp(const MyApp());
}

