import 'package:talker/talker.dart';

final Talker talker = Talker();

void talkerLog(String fileName, String message) {
  // Talker 로그 남기기
  talker.log(message);
}

void talkerInfo(String fileName, String message) {
  // Talker 인포 남기기
  talker.info('화면: $fileName, 메시지: $message');
}

void talkerError(String fileName, String message, Object error) {
  // Talker 에러 남기기
  talker.error('화면: $fileName, 메시지: $message, 에러: $error');
}
