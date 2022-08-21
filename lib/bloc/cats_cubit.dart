import 'package:bloc_patern/bloc/cats_repository.dart';
import 'package:bloc_patern/bloc/cats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatsCubit extends Cubit<CatsState> {
  final CatsRepository _catsRepository;
  CatsCubit(this._catsRepository) : super(CatsInitial());
  Future<void> getCats() async {
    try {
      emit(CatsLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      final response = await _catsRepository.getCats();
      emit(CatsCompleted(response));
    } on NetworkException catch (e) {
      emit(CatsError(e.message));
    }
  }
}
