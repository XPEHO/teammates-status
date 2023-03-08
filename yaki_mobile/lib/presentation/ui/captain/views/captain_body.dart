import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/ui/captain/views/team_mate_card.dart';
import 'package:yaki/presentation/ui/shared/views/InputApp.dart';

import 'package:yaki/presentation/state/providers/team_mate_provider.dart';


class CaptainBody extends ConsumerStatefulWidget {

  CaptainBody({super.key});

  @override
  ConsumerState<CaptainBody> createState() => _CaptainBodyState();
}

class _CaptainBodyState extends ConsumerState<CaptainBody> {
  final captainInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(TeamMateProvider.notifier).fetchTeamMates();
  }



  @override
  Widget build(BuildContext context) {
    final listTeamMate = ref.watch(TeamMateProvider);

    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: InputApp(
            // Field for search by name or status
            inputText: tr('inputCaptain'),
            inputHint: tr('hintCaptain'),
            password: false,
            controller: captainInputController,
          ),
        ),
        SizedBox(
          // Cards of the Team Mate
          width: size.width * 0.95,
          height: size.height * 0.14,
          child: const Text('dkdufg')
        ),
      ],
    );
  }
}
