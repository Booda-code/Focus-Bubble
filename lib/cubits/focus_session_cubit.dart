import 'package:flutter_bloc/flutter_bloc.dart';

import 'focus_session_states.dart';

class FocusSessionCubit extends Cubit<FocusSessionState>{
  FocusSessionCubit() : super(FocusSessionInitial());

}