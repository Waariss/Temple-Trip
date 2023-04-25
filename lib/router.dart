import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/model/region.dart';
import 'package:project/model/region_data.dart';
import 'package:project/pages/explore_temple.dart';
import 'package:project/pages/explore_province.dart';
import 'package:project/pages/home.dart';
import 'package:project/pages/temple_details.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
      routes: [
        GoRoute(
          name: 'home_router',
          path: ':index',
          pageBuilder: (context, state) {
            final index = state.params['index']!;
            return MaterialPage(
              key: state.pageKey,
              child: HomeScreen(
                selectedIndex: int.tryParse(index) ?? 0,
              ),
            );
          },
        ),
      ],
    ),
    GoRoute(
      name: 'explore',
      path: '/explore',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const Text('Explore'),
      ),
      routes: [
        GoRoute(
          name: 'region',
          path: ':regionSlug',
          pageBuilder: (context, state) {
            final regionSlug = state.params['regionSlug']!;
            Region region = regions.firstWhere(
              (r) => r.slug == regionSlug,
            );
            return MaterialPage(
              key: state.pageKey,
              child: ExploreProvinceScreen(
                region: region,
              ),
            );
          },
          routes: [
            GoRoute(
              name: 'province',
              path: ':provinceSlug',
              pageBuilder: (context, state) {
                final regionSlug = state.params['regionSlug']!;
                final Region region = regions.firstWhere(
                  (r) => r.slug == regionSlug,
                );

                final province = region.provinces.firstWhere(
                  (p) => p.slug == state.params['provinceSlug']!,
                );
                return MaterialPage(
                  key: state.pageKey,
                  child: ExploreTempleScreen(province: province),
                );
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: 'temple',
      path: '/temple',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const Text('Temple'),
      ),
      routes: [
        GoRoute(
          name: 'temple_detail',
          path: ':id',
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: TempleDetailScreen(
                hId: state.params['id']!,
              ),
            );
          },
        ),
      ],
    ),
  ],
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  ),
);
