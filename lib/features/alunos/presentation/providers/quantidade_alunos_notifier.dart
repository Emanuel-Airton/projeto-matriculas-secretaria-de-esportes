import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/aluno_provider.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';

class QuantidadeAlunosNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>?>> {
  QuantidadeAlunosNotifier(this.ref) : super(const AsyncLoading()) {
    _init();
  }

  final Ref ref;

  Future<void> _init() async {
    state = const AsyncLoading();
    final recuperaListAlunos = ref.watch(listAlunosProvider);
    // ... sua lógica

    Result result = ref
        .read(alunoRepositoryProvider)
        .quantidadeAlunoPorGenero(recuperaListAlunos!);

    if (result is Ok) {
      state = AsyncValue.data(result.value);
    } else if (result is Error) {
      state = AsyncValue.error(result.error, StackTrace.current);
    } else {
      state =
          AsyncValue.error(Exception('erro desconhecido'), StackTrace.current);
    }
  }
}

// No provider:
final quantidadeAlunosNotifierProvider = StateNotifierProvider<
    QuantidadeAlunosNotifier, AsyncValue<Map<String, dynamic>?>>((ref) {
  return QuantidadeAlunosNotifier(ref);
});
