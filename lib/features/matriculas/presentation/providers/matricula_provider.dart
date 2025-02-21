import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/data/models/matricula_model.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/data/repositories/matricula_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/domain/usecases/matricula_usecase.dart';

final matriculaRepositoryProvider = Provider((ref) => MatriculaRepository());
final matriculaUseCaseProvider =
    Provider((ref) => MatriculaUsecase(ref.read(matriculaRepositoryProvider)));

final listMatriculaListProvider = FutureProvider<List<MatriculaModel>>((ref) {
  return ref.read(matriculaUseCaseProvider).buscarMatriculas();
});
