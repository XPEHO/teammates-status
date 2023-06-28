import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/domain/entities/logged_user.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki/presentation/ui/shared/pages_layout.dart';
import 'package:yaki/presentation/ui/shared/views/header.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoggedUser? user = ref.watch(loginRepositoryProvider).loggedUser;

    return Scaffold(
      body: PagesLayout(
        header: Header(
          pictoIcon: 'assets/images/dots.svg',
          pictoPath: 'assets/images/avatar1.svg',
          headerTitle: 'Profile',
          headerHint:
              user != null ? '${user.firstName} ${user.lastName}' : 'teamMate',
        ),
        bodyContent: const Text('Coming soon'),
      ),
    );
  }
}
