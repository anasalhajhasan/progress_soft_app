import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/application_layer/bloc/home_bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:progress_soft_app/application_layer/bloc/home_bloc/home_bloc.dart';
import 'package:progress_soft_app/application_layer/bloc/login_bloc/login_bloc.dart';
import 'package:progress_soft_app/application_layer/bloc/register_bloc/age_bloc/age_bloc.dart';
import 'package:progress_soft_app/application_layer/bloc/register_bloc/gender_bloc/gender_bloc.dart';
import 'package:progress_soft_app/application_layer/bloc/register_bloc/register_bloc.dart';
import 'package:progress_soft_app/application_layer/bloc/system_config_bloc/system_config_bloc.dart';

class BlocProviders {
  static var blocProvidersList = [
    BlocProvider<SystemConfigBloc>(
      create: (context) => SystemConfigBloc(),
    ),
    BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(FirebaseFirestore.instance),
    ),
    BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(FirebaseFirestore.instance),
    ),
    BlocProvider<GenderBloc>(
      create: (context) => GenderBloc(),
    ),
    BlocProvider<AgeBloc>(
      create: (context) => AgeBloc(),
    ),
    BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(),
    ),
    BlocProvider<BottomNavBloc>(
      create: (context) => BottomNavBloc(),
    )
  ];
}
