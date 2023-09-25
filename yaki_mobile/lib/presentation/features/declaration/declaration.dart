import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki_ui/yaki_ui.dart';

class Declaration extends StatelessWidget {
  final Color backgroundColor;
  final String timeOfDay;
  final String thisMorningOrAfternoon;
  final String imageSrc;

  const Declaration({
    Key? key,
    required this.backgroundColor,
    required this.timeOfDay,
    required this.thisMorningOrAfternoon,
    required this.imageSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    tr('whereworking'),
                    style: textStyleDeclaration(),
                  ),
                  IconChip(
                    label: 'Team',
                    backgroundColor: Colors.blue,
                    image: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://picsum.photos/200',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  Text(
                    '${tr(thisMorningOrAfternoon)} ${tr(timeOfDay)}',
                    style: textStyleDeclaration(),
                  ),
                  IconChip(
                    label: tr(timeOfDay),
                    backgroundColor: Colors.blue,
                    image: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        imageSrc,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  const Text('?'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    LocationSelectionCard(
                      picture: Image.network('Work-Office.svg'),
                      title: tr('Iam'),
                      subtitle: tr('office'),
                      onSelectionChanged: (selected) {
                  
                      },
                    ),
                    LocationSelectionCard(
                      picture: Image.network('Work-Home.svg'),
                      title: tr('Iam'),
                      subtitle: tr('remote'),
                      onSelectionChanged: (selected) {
                    
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
