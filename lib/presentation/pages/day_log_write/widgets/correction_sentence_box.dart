import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/constant/custom_style.dart';
import 'package:langlog/core/correction_diff_check.dart';
import 'package:langlog/domain/entity/correction_sentence.dart';
import 'package:langlog/presentation/pages/day_log_write/day_log_view_model.dart';

class CorrectionSentenceBox extends ConsumerStatefulWidget {
  final CorrectionSentence item;

  const CorrectionSentenceBox({super.key, required this.item});

  @override
  ConsumerState<CorrectionSentenceBox> createState() =>
      _CorrectionSentenceBoxState();
}

class _CorrectionSentenceBoxState extends ConsumerState<CorrectionSentenceBox> {
  bool isOpened = false;

  @override
  Widget build(BuildContext contexy) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.grey_300),
          borderRadius: BorderRadius.circular(20),
          color: CustomColors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 교정 문장 표시
          correctionSentence(widget.item),

          // 교정 사유 표시
          correctionReason(),
        ],
      ),
    );
  }

  // 교정 사유
  Container correctionReason() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: isOpened
          ? EdgeInsets.symmetric(horizontal: 15, vertical: 10)
          : EdgeInsets.only(top: 0, bottom: 0, left: 15, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: CustomColors.grey_100,
      ),
      child: isOpened ? correctionReasonText() : reasonNotOpened(),
    );
  }

  // 교정 사유 요청
  Widget reasonNotOpened() {
    return Row(
      children: [
        Expanded(
          child: Text(
            "AI 문장 교정 사유 보기",
            style:
                CustomText.caption_01_M.copyWith(color: CustomColors.grey_600),
          ),
        ),
        IconButton(
          onPressed: () async {
            final vm = ref.read(dayLogViewModelProvider.notifier);
            final sentence = CorrectionSentence(
              originSentence: widget.item.originSentence,
              correctSentence: widget.item.correctSentence,
            );

            final response = await vm.getCorrectionReason(sentence);

            if (response.isNotEmpty) {
              widget.item.correctionReason = response;
              setState(() {
                isOpened = true;
              });
            }
            print("isOpened click!");

            // ai에게 교정 사유 요청
          },
          icon: Icon(Icons.keyboard_arrow_down),
          padding: EdgeInsets.zero, // 패딩 설정
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }

  // 교정 사유 표시
  Widget correctionReasonText() {
    return SizedBox(
      width: double.infinity,
      child: Text(
        widget.item.correctionReason!,
        style: CustomText.caption_01_M.copyWith(color: CustomColors.grey_600),
      ),
    );
  }

  // 교정 문장 표시
  Padding correctionSentence(CorrectionSentence item) {
    List<List<TextSpan>> highlightedText =
        correctionDiffCheck(item.originSentence, item.correctSentence);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 틀린 문장
          RichText(text: TextSpan(children: highlightedText.first)),
          SizedBox(height: 8),
          // 옳은 문장
          RichText(text: TextSpan(children: highlightedText.last)),
          SizedBox(height: 3),
          // 한글해석
          // Text(
          //   "Is correct sentence.",
          //   style:
          //       CustomText.caption_01_M.copyWith(color: CustomColors.grey_500),
          // ),
        ],
      ),
    );
  }
}
