import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_services_state.dart';

class AuthServicesCubit extends Cubit<AuthServicesState> {
  AuthServicesCubit() : super(AuthServicesInitial());
}
