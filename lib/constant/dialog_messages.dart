class DialogMessage {
  String title;
  String content;
  String cancleLabel;
  String confirmLabel;

  DialogMessage({
    required this.title,
    required this.content,
    required this.cancleLabel,
    required this.confirmLabel,
  });
}

final DialogMessage DAY_LOG_CONFIRM_DIALOG = DialogMessage(
  title: "AI 튜터에게 교정을 받아보시겠어요?",
  content: "하루에 한 번 교정을 받아볼 수 있어요.",
  cancleLabel: "작성 완료하기",
  confirmLabel: "문장 교정받기",
);

final DialogMessage DAY_LOG_FINISH_DIALOG = DialogMessage(
  title: "저장한 뒤에는 수정할 수 없어요.",
  content: "일기 작성을 완료하면 수정이 불가합니다.\n저장하시겠어요?",
  cancleLabel: "다시보기",
  confirmLabel: "저장하기",
);

final DialogMessage DAY_LOG_DELETE_DIALOG = DialogMessage(
  title: '정말 삭제하시겠어요?',
  content: '일기를 삭제하면 다시 볼 수 없고,\n교정도 다시 받을 수 없어요!',
  cancleLabel: '아니요',
  confirmLabel: '네',
);

final DialogMessage LOGOUT_DIALOG = DialogMessage(
  title: "로그아웃 하시겠습니까?",
  content: "로그아웃을 원하실 경우 확인을 눌러주세요.",
  cancleLabel: "취소",
  confirmLabel: "확인",
);
