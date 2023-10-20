import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/domain/entities/logged_user.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki_ui/yaki_ui.dart';
import 'package:flutter_svg/svg.dart';

class AvatarModal extends ConsumerWidget {
  const AvatarModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoggedUser? user = ref.watch(loginRepositoryProvider).loggedUser;

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: SvgPicture.asset(
                              'assets/images/avatar-men2.svg',
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: SvgPicture.asset(
                              'assets/images/avatar-woman.svg',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: SvgPicture.asset(
                              'assets/images/avatar-men2.svg',
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: SvgPicture.asset(
                              'assets/images/avatar-woman.svg',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/avatar-damier.svg'),
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: const Color(0xFFFFD7C0),
                            child: Text(
                              '${user?.firstName?[0]}${user?.lastName?[0]}',
                              style: const TextStyle(
                                color: Color(0xFF7D818C),
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 4,
                            ),
                            child: Button.secondary(
                              text: tr('takePicture'),
                              onPressed: () {
                                // This is a modal bottom sheet. This need to be delete when the method will be implemented
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const SizedBox(
                                      height: 200,
                                      child: Center(
                                        child: Text('Coming soon'),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 4,
                            ),
                            child: Button.secondary(
                              text: tr('imgGallery'),
                              onPressed: () {
                                // This is a modal bottom sheet. This need to be delete when the method will be implemented
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const SizedBox(
                                      height: 200,
                                      child: Center(
                                        child: Text('Coming soon'),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: null,
        ),
      ],
    );
  }
}
