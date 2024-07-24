import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/data_layer/models/config_model/config_model.dart';

part 'system_config_event.dart';
part 'system_config_state.dart';

class SystemConfigBloc extends Bloc<SystemConfigEvent, SystemConfigBlocState> {
  SystemConfigBloc() : super(NavigationsBlocInitial()) {
    on<SystemConfigEvent>((event, emit) async {
      if (event is SystemConfigLoadEvent) {
        emit(ConfigLoading());
        try {
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          DocumentSnapshot config =
              await firestore.collection('config').doc('settings').get();

          if (config.exists) {
            Config.mobileRegex = config['mobile_regex'];
            Config.passwordRegex = config['password_regex'];
            Config.incorrectPasswordMessage =
                config['incorrect_password_message'];
            Config.countryCode = config['country_code'];
            Config.fieldRequired = config['field_required'];

            emit(
              ConfigSuccess(
                mobileRegex: config['mobile_regex'],
                passwordRegex: config['password_regex'],
                incorrectPasswordMessage: config['incorrect_password_message'],
                countryCode: config['country_code'],
              ),
            );
          } else {
            emit(ConfigError(message: 'Configuration document does not exist'));
          }
        } catch (e) {
          emit(ConfigError(message: e.toString()));
        }
      }
    });
  }
}
