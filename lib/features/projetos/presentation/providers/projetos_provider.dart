import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/projetos/data/repository/projetos_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/projetos/domain/usecases/projetos_usecase.dart';
import '../../data/models/projetos_model.dart';

final projetosRepositoryProvider = Provider((ref) => ProjetosRepository());
final projetosUseCaseProvider =
    Provider((ref) => ProjetosUsecase(ref.read(projetosRepositoryProvider)));

final listProjetosProvider = FutureProvider<List<ProjetosModel>>((ref) {
  return ref.read(projetosUseCaseProvider).buscarProjeto();
});
