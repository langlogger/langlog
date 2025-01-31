import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/constant/custom_style.dart';
import 'package:langlog/presentation/pages/login/login_page.dart';
import 'package:langlog/presentation/pages/login/login_view_model.dart';
import 'package:langlog/presentation/widgets/custom_app_bar.dart';
import 'package:langlog/presentation/widgets/custom_dialog.dart';

class DeleteAccountPage extends StatefulWidget {
  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final List<Map<String, dynamic>> checkboxItems = [
    {'title': '사용하기 어렵고 서비스가 불안정해요', 'isChecked': false},
    {'title': '영어 실력을 키우는데 효과가 없어요', 'isChecked': false},
    {'title': '앱 사용 빈도가 낮아요', 'isChecked': false},
    {'title': '기타', 'isChecked': false},
  ];
  bool isCheckedOther = false;
  final TextEditingController textController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> feedbackList = [];

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: '탈퇴하기',
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '일기 내용이 삭제 되는데 정말 떠나시나요?',
                    style: CustomText.header_01_SB,
                  ),
                  SizedBox(height: 20),
                  Text('그렇다면 계정을 삭제하는 이유를 선택해주세요.\n향후 서비스 개선에 참고하겠습니다.',
                      style: CustomText.body_01_M),
                  SizedBox(height: 15),
                  Expanded(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: checkboxItems.length,
                      itemBuilder: (context, index) {
                        final item = checkboxItems[index];
                        return CheckboxListTile(
                          value: item["isChecked"],
                          controlAffinity: ListTileControlAffinity.trailing,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          title:
                              Text(item["title"], style: CustomText.body_01_M),
                          onChanged: (value) {
                            setState(() {
                              checkboxItems[index]["isChecked"] = value!;
                              if (item['title'] == '기타') {
                                isCheckedOther = value;
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                  isCheckedOther == true
                      ? Column(
                          children: [
                            TextFormField(
                              controller: textController,
                              decoration: InputDecoration(
                                hintText:
                                    '이유를 구체적으로 적어주실수록 langlog가 성장하는데 큰 도움이 돼요',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[300],
                              ),
                              maxLength: 100,
                              maxLines: 5,
                              validator: (value) {
                                // 이유를 입력하지 않으면 오류 표시
                                if (value == null || value.isEmpty) {
                                  return '기타 사유를 입력해주세요.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 160,
                            )
                          ],
                        )
                      : Spacer(),
                  // Spacer(),
                  SafeArea(
                    child: SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () async {
                          final feedback = checkboxItems
                              .where((item) => item["isChecked"])
                              .map((item) => item["title"] as String)
                              .toList();

                          final isAnyChecked =
                              checkboxItems.any((item) => item["isChecked"]);

                          //하나 이상의 항목이 작성되었다면 파이어 베이스에 피드백 올리기
                          if ((formKey.currentState?.validate() ?? false) &&
                              isAnyChecked) {
                            if (textController.text.trim() != '') {
                              feedback.add(textController.text.trim());
                            }
                            if (feedback.isNotEmpty) {
                              final feedbackText = feedback.join(', ');
                              await ref
                                  .read(loginViewModel.notifier)
                                  .sendUserOpinion(feedbackText);
                            }

                            //유저 데이터 삭제
                            final result = await ref
                                .read(loginViewModel.notifier)
                                .deleteUser();

                            if (context.mounted) {
                              //데이터 삭제 성공시 스낵바, 페이지 이동
                              if (result == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("탈퇴되었습니다. 다음에 또 만나요.",
                                        style: CustomText.body_01_M),
                                    duration: Duration(seconds: 2),
                                  ),
                                );

                                await Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (route) => false,
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialog(
                                      title: "탈퇴에 실패하였습니다.",
                                      content: "잠시후에 다시 시도해주세요.",
                                      cancleLabel: "취소",
                                      onCancle: () {
                                        // Navigator.of(context).pop();
                                      },
                                      confirmLabel: "확인",
                                      onConfirm: () async {
                                        // Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                );
                              }
                            }
                          } else if (!isAnyChecked) {
                            // 최소 하나의 체크박스 항목이 선택되지 않았을 경우
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  title: "하나 이상의 항목을 선택해주세요",
                                  content: "소중한 의견이 langlog가 성장하는데 큰 도움이 돼요.",
                                  cancleLabel: "취소",
                                  onCancle: () {
                                    // Navigator.of(context).pop();
                                  },
                                  confirmLabel: "확인",
                                  onConfirm: () async {
                                    // Navigator.of(context).pop();
                                  },
                                );
                              },
                            );
                          }
                        },
                        child: const Text('탈퇴하기'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
