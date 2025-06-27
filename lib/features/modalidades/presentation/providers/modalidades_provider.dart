import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/aluno_provider.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/repositories/modalidades_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/services/matricula_modalidade_sevices.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/domain/usecases/modalidades_usecase.dart';

final matriculaModalidadeSevices =
    Provider((ref) => MatriculaModalidadeSevices());

final modalidadeRepository = Provider((ref) => ModalidadesRepository(
    ref.read(matriculaModalidadeSevices), ref.read(alunoRepositoryProvider)));
final modalidadeUsecaseProvider =
    Provider((ref) => ModalidadesUsecase(ref.read(modalidadeRepository)));

final listModalidadeProvider = FutureProvider<List<ModalidadesModel>>(
  (ref) {
    return ref.read(modalidadeUsecaseProvider).buscarListaModalidade();
  },
);
final selectedModalidadeProvider =
    StateProvider<ModalidadesModel?>((ref) => null);
//busca uma unica modalidade de acordo com o id passado
final buscarModalidade = FutureProvider<ModalidadesModel?>((ref) {
  final idModalidade = ref.watch(selectedModalidadeProvider);
  if (idModalidade != null) {
    return ref.watch(selectedModalidadeProvider);
  }
  return null;
});
