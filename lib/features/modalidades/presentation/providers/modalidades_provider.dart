import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/repositories/modalidades_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/domain/usecases/modalidades_usecase.dart';

final modalidadeRepository = Provider((ref) => ModalidadesRepository());
final modalidadeUsecaseProvider =
    Provider((ref) => ModalidadesUsecase(ref.read(modalidadeRepository)));

final listModalidadeProvider = FutureProvider<List<ModalidadesModel>>(
  (ref) {
    return ref.read(modalidadeUsecaseProvider).buscarListaModalidade();
  },
);
final selectedModalidadeIdProvider =
    StateProvider<ModalidadesModel?>((ref) => null);
//busca uma unica modalidade de acordo com o id passado
final buscarModalidade = FutureProvider<ModalidadesModel?>((ref) {
  final idModalidade = ref.watch(selectedModalidadeIdProvider);
  if (idModalidade != null) {
    return ref.watch(selectedModalidadeIdProvider);
  }
  return null;
});

final listMatriculaModalidadeProvider =
    FutureProvider<List<MatriculaModalidadesModel>>(
  (ref) {
    final modalidadeId = ref.watch(selectedModalidadeIdProvider);
    final repository = ref.watch(modalidadeUsecaseProvider);
    if (modalidadeId == null) {
      return repository
          .buscarMatriculaModalidade(); // Retorna todas as matrículas se nenhum ID for selecionado
    } else {
      return repository.buscarMatriculaModalidadeFiltro(
          modalidadeId.id!); // Retorna filtrado por ID
    }
  },
);

final selectMatriculaModalidadeId = StateProvider<int?>((ref) => null);
final deletarMatriculaModalidade = Provider((ref) {
  final idAluno = ref.read(selectMatriculaModalidadeId);
  if (idAluno != null) {
    return ref
        .read(modalidadeUsecaseProvider)
        .deletarMatriculaModalidade(idAluno);
  }
});
