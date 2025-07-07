import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/aluno_provider.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/repositories/modalidades_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/services/matricula_modalidade_sevices.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/domain/usecases/modalidades_usecase.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';

final matriculaModalidadeSevices =
    Provider((ref) => MatriculaModalidadeSevices());
final modalidadeRepository = Provider((ref) => ModalidadesRepository(
    ref.read(matriculaModalidadeSevices), ref.read(alunoRepositoryProvider)));
final modalidadeUsecaseProvider =
    Provider((ref) => ModalidadesUsecase(ref.read(modalidadeRepository)));

final listModalidadeProvider = FutureProvider<List<ModalidadesModel>>(
  (ref) async {
    Result result =
        await ref.read(modalidadeUsecaseProvider).buscarListaModalidade();
    if (result is Ok<List<ModalidadesModel>>) {
      return result.value;
    } else if (result is Error) {
      throw result.error; // Isso aciona o .error na UI
    } else {
      throw Exception('Erro desconhecido ao buscar modalidades');
    }
  },
);
final selectedModalidadeProvider =
    StateProvider<ModalidadesModel?>((ref) => null);
//busca uma unica modalidade de acordo com o id passado
final buscarModalidade = FutureProvider<ModalidadesModel?>((ref) {
  final modalidadesModel = ref.watch(selectedModalidadeProvider);
  if (modalidadesModel != null) return modalidadesModel;
  return null;
});
