import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/presentation/pages/day_log_write/day_log_view_model.dart';
import 'package:langlog/presentation/pages/day_log_write/widgets/correction_sentence_box.dart';

class CorrectionResultListView extends ConsumerWidget {
  const CorrectionResultListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dayLogViewModelProvider);

    return Expanded(
      child: ListView.builder(
        itemCount: state.correctionSentence?.length,
        itemBuilder: (context, index) {
          final item = state.correctionSentence![index];
          return CorrectionSentenceBox(item: item);
        },
      ),
    );
  }
}
