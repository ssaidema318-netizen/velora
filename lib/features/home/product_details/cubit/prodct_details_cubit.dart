import 'package:bloc/bloc.dart';

part 'prodct_details_state.dart';

class ProdctDetailsCubit extends Cubit<ProdctDetailsState> {
  ProdctDetailsCubit() : super(ProdctDetailsInitial());
}
