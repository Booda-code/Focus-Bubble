import '../models/focus_session_model.dart';

class FocusSessionState {}

class FocusSessionInitial extends FocusSessionState {}

class FocusSessionLoading extends FocusSessionState {}

class FocusSessionSuccess extends FocusSessionState {
  final List<FocusSessionModel> sessions;

  FocusSessionSuccess(this.sessions);
}

class FocusSessionError extends FocusSessionState {
  final String errorMessage;

  FocusSessionError(this.errorMessage);
}