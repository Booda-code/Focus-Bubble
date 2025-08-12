import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/focus_session_model.dart';
import 'focus_session_states.dart';

class FocusSessionCubit extends Cubit<FocusSessionState> {
  late Box<FocusSessionModel> _sessionBox;

  FocusSessionCubit() : super(FocusSessionInitial());

  void init(Box<FocusSessionModel> box) {
    _sessionBox = box;
    getSessions();
  }

  void getSessions() {
    try {
      emit(FocusSessionLoading());
      final sessions = _sessionBox.values.toList();
      emit(FocusSessionSuccess(sessions));
    } catch (e) {
      emit(FocusSessionError("Failed to load sessions"));
    }
  }

  Future<void> addSession(FocusSessionModel session) async {
    try {
      await _sessionBox.add(session);
      getSessions();
    } catch (e) {
      emit(FocusSessionError("Failed to add session"));
    }
  }

  Future<void> deleteSession(int index) async {
    try {
      await _sessionBox.deleteAt(index);
      getSessions();
    } catch (e) {
      emit(FocusSessionError("Failed to delete session"));
    }
  }

  Future<void> updateSession(int index, FocusSessionModel session) async {
    try {
      await _sessionBox.putAt(index, session);
      getSessions();
    } catch (e) {
      emit(FocusSessionError("Failed to update session"));
    }
  }
}
