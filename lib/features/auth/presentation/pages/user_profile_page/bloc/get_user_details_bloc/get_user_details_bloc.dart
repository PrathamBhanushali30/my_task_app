import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:my_task_app/shared/utils/app_component.dart';

import '../../../../../../../data/models/user_model.dart';

part 'get_user_details_event.dart';

part 'get_user_details_state.dart';

class GetUserDetailsBloc extends Bloc<GetUserDetailsEvent, GetUserDetailsState> {
  GetUserDetailsBloc() : super(GetUserDetailsInitial()) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    on<GetUserDetails>((event, emit) async {
      AppComponentBase.instance.showProgressDialog();
      final result = await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
      final UserModel user = UserModel(email: result.get('email'), name: result.get('name'), uid: result.get('uid'));
      emit(GetUserDetailsLoaded(user: user));
      AppComponentBase.instance.hideProgressDialog();
    });
  }
}
