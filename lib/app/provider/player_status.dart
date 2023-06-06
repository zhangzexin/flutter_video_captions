import 'package:flutter_riverpod/flutter_riverpod.dart';

final playerUiControllerProvider = Provider((ref) => PlayerStatus());

class PlayerStatus {
  bool isPlay = false;
  bool isShowUi = false;
}