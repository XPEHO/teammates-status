import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/displaydata/declaration_summary_enum.dart';
import 'package:yaki/presentation/features/authentication/authentication.dart';
import 'package:yaki/presentation/features/declaration/declaration_page.dart';
import 'package:yaki/presentation/features/splash_screen/splash_screen.dart';
import 'package:yaki/presentation/features/teams_declarations_summary/teams_declarations_summary.dart';
import 'package:yaki/presentation/features/user_declaration_summary/user_declaration_summary.dart';
import 'package:yaki/presentation/features/team_selection/team_selection.dart';
import 'package:yaki/presentation/features/user_declaration_summary/user_declaration_summary_absence.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/token_provider.dart';
import 'package:yaki/presentation/ui/default/user_default_redirection.dart';
import 'package:yaki/presentation/features/password/forgot_password.dart';
import 'package:yaki/presentation/features/password/change_password.dart';
import 'package:yaki/presentation/features/profile/profile.dart';
import 'package:yaki/presentation/features/registration/registration.dart';

/// router set as provider.
final goRouterProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          redirect: (BuildContext context, GoRouterState state) async {
            // only redirect if we are on the Splash Screen
            if (state.fullPath == '/') {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              final isJWTValid =
                  await ref.read(tokenRepositoryProvider).verifyTokenValidity();

              if (!isJWTValid) {
                prefs.remove('token');
                return '/authentication';
              }

              final declaration = ref.watch(declarationProvider);

              bool isLoggedIn = prefs.containsKey('token');
              final latestDeclarationStatus =
                  declaration.latestDeclarationStatus;

              if (latestDeclarationStatus == LatestDeclarationStatus.unknown) {
                return null;
              }

              if (isLoggedIn &&
                  latestDeclarationStatus == LatestDeclarationStatus.declared) {
                return '/teams-declaration-summary';
              } else if (isLoggedIn &&
                  latestDeclarationStatus ==
                      LatestDeclarationStatus.notDeclared) {
                return '/team-selection';
              } else {
                return '/authentication';
              }
            }
            return null;
          },
          builder: (context, state) => const PopScope(
            canPop: false,
            child: SplashScreen(),
          ),
          routes: [
            GoRoute(
              path: 'authentication',
              builder: (context, state) => const PopScope(
                canPop: false,
                child: Authentication(),
              ),
              redirect: (BuildContext context, GoRouterState state) async {
                final isTokenSaves = await SharedPref.isTokenPresent();

                if (isTokenSaves) {
                  return '/teams-declaration-summary';
                } else {
                  return '/authentication';
                }
              },
            ),
            GoRoute(
              path: 'userDefaultRedirection',
              builder: (context, state) => const PopScope(
                canPop: false,
                child: UserDefaultRedirection(),
              ),
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/userDefaultRedirection';
                } else {
                  return '/authentication';
                }
              },
            ),
            GoRoute(
              path: 'profile',
              builder: (context, state) => const PopScope(
                canPop: false,
                child: Profile(),
              ),
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/profile';
                } else {
                  return '/authentication';
                }
              },
            ),
            GoRoute(
              path: 'changePassword',
              builder: (context, state) => const PopScope(
                canPop: false,
                child: ChangePassword(),
              ),
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/changePassword';
                } else {
                  return '/authentication';
                }
              },
            ),
            GoRoute(
              path: 'team-selection',
              builder: (context, state) => const PopScope(
                canPop: false,
                child: TeamSelection(),
              ),
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/team-selection';
                } else {
                  return '/authentication';
                }
              },
            ),
            GoRoute(
              path: 'declaration/half-day-start',
              builder: (context, state) => const PopScope(
                canPop: false,
                child: DeclarationPage(
                  declarationMode: "half-day-start",
                ),
              ),
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/declaration/half-day-start';
                }
                return '/authentication';
              },
            ),
            GoRoute(
              path: 'declaration/half-day-end',
              builder: (context, state) => const PopScope(
                canPop: false,
                child: DeclarationPage(
                  declarationMode: "half-day-end",
                ),
              ),
              redirect: (BuildContext context, GoRouterState state) async {
                // null check

                if (await SharedPref.isTokenPresent()) {
                  return '/declaration/half-day-end';
                }
                return '/authentication';
              },
            ),
            GoRoute(
              path: 'declaration/:mode',
              builder: (context, state) => PopScope(
                canPop: false,
                child: DeclarationPage(
                  declarationMode: state.pathParameters['mode']!,
                ),
              ),
              redirect: (BuildContext context, GoRouterState state) async {
                // null check
                final String pathParam = state.pathParameters['mode'] ?? '';
                // check if the path parameter is valid
                final bool isValidPath =
                    DeclarationPaths.isValidPath(value: pathParam);

                if (await SharedPref.isTokenPresent() && isValidPath) {
                  return '/declaration/${state.pathParameters['mode']!}';
                }
                return '/authentication';
              },
            ),
            GoRoute(
              path: 'summary/absence',
              builder: (context, state) => const PopScope(
                canPop: false,
                child: UserDeclarationSummaryAbsence(
                  summaryMode: "absence",
                ),
              ),
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/summary/absence';
                } else {
                  return '/team-selection';
                }
              },
            ),
            GoRoute(
              path: 'summary/:mode',
              builder: (context, state) => PopScope(
                canPop: false,
                child: UserDeclarationSummary(
                  summaryMode: state.pathParameters['mode']!,
                ),
              ),
              redirect: (BuildContext context, GoRouterState state) async {
                final String pathParam = state.pathParameters['mode'] ?? '';

                final bool isValidPath =
                    DeclarationSummaryPaths.isValidPath(value: pathParam);

                if (await SharedPref.isTokenPresent() && isValidPath) {
                  return '/summary/${state.pathParameters['mode']!}';
                } else {
                  return '/team-selection';
                }
              },
            ),
            GoRoute(
              path: 'teams-declaration-summary',
              builder: (context, state) => const PopScope(
                canPop: false,
                child: TeamsDeclarationSummary(),
              ),
              redirect: (BuildContext context, GoRouterState state) async {
                // null check

                if (await SharedPref.isTokenPresent()) {
                  return '/teams-declaration-summary';
                }
                return '/authentication';
              },
            ),
          ],
        ),
        GoRoute(
          path: '/registration',
          builder: (context, state) => const PopScope(
            canPop: false,
            child: Registration(),
          ),
        ),
        GoRoute(
          path: '/forgotPassword',
          builder: (context, state) => const PopScope(
            canPop: false,
            child: ForgotPassword(),
          ),
        ),
      ],
    );
  },
);
