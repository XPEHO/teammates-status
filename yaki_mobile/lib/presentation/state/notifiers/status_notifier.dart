import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/presentation/displaydata/declaration_card_content.dart';

class StatusPageNotifier extends StateNotifier<StateStatus> {
  final DeclarationRepository declarationRepository;

  StatusPageNotifier(this.declarationRepository)
      : super(StateStatus(image: "", text: ""));

  void setState(String status) {
    state = StateStatus(
      image: '${statusImage[status]}',
      text: tr('${statusMessage[status]}'),
    );
  }

  void getSelectedStatus() {
    final String status = declarationRepository.status;
    print('in status notifier :  $status');
    if (status != "") {
      setState(status);
    }
  }
}

class StateStatus {
  String image;
  String text;

  StateStatus({
    required this.image,
    required this.text,
  });

  @override
  String toString() {
    return 'StateStatus{image: $image, text: $text}';
  }
}
