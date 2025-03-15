import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/repositories/aluno_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/aluno_model.dart';
import '../../domain/usecases/aluno_usecase.dart';

class AlunoNotifier extends StateNotifier<List<AlunoModel>> {
  final SupabaseClient _supabase;
  final AlunoUseCase _alunoUseCase;

  AlunoNotifier(this._supabase, this._alunoUseCase) : super([]) {
    _setupRealTime();
    _fetchAlunos();
  }

  _fetchAlunos() async {
    state = await _alunoUseCase.buscarAlunos();
  }

  buscarAlunoNome(String nome) async {
    state = await _alunoUseCase.buscarAlunoNome(nome);
  }

  void _setupRealTime() {
    state = _alunoUseCase.setupRealTime();
  }

  /// Escuta eventos do Supabase em tempo real
/* void _setupRealTime() {
    _supabase
        .channel('alunos')
        .onPostgresChanges(
            event: PostgresChangeEvent.all,
            table: 'alunos',
            schema: 'public',
            callback: (payload) {
              if (payload.eventType == PostgresChangeEvent.insert) {
                state = [...state, AlunoModel.fromJson(payload.newRecord)];
              } else if (payload.eventType == PostgresChangeEvent.update) {
                state = state.map((aluno) {
                  return aluno.id == payload.newRecord['id']
                      ? AlunoModel.fromJson(payload.newRecord)
                      : aluno;
                }).toList();
              } else if (payload.eventType == PostgresChangeEvent.delete) {
                state = state
                    .where((aluno) => aluno.id != payload.oldRecord['id'])
                    .toList();
              }
            })
        .subscribe();
  }*/
}

final alunoNotifierProvider =
    StateNotifierProvider<AlunoNotifier, List<AlunoModel>>((ref) {
  final supabase = Supabase.instance.client;
  final alunoRepository = AlunoRepository();
  final alunoUseCase = AlunoUseCase(alunoRepository);
  return AlunoNotifier(supabase, alunoUseCase);
});
final nomeAlunoProvider = StateProvider<String>((ref) => '');
