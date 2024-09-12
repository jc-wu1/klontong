import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:klontong/src/features/add_product/presentation/add_product_page.dart';

import '../../features/authentication/bloc/authentication_cubit.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/login/presentation/login_page.dart';
import '../../features/product_detail/presentation/product_detail_page.dart';
import '../../features/products/presentation/flash_sale_page.dart';
import '../../features/products/presentation/products_page.dart';
import '../../features/profile/profile_page.dart';
import '../../features/splash_page.dart';

const String homePath = '/home';
const String flashSalePath = '/flash_sale';
const String productsPath = '/products';
const String wishlistsPath = '/wishlists';
const String transactionsPath = '/transactions';
const String loginPath = '/login';
const String profilePath = '/profile';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/splash',
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: 'splash',
      path: '/splash',
      builder: (BuildContext context, GoRouterState state) {
        return SplashPage(
          key: state.pageKey,
        );
      },
      redirect: (context, state) {
        final authStatus = context.read<AuthenticationCubit>().state;

        if (authStatus.status == AuthStatus.waiting) {
          return null;
        }

        if (authStatus.status == AuthStatus.unauthenticated) {
          return homePath;
        }

        if (authStatus.status == AuthStatus.authenticated) {
          return homePath;
        }

        return null;
      },
    ),
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) => AppScaffold(
        child: child,
      ),
      routes: [
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: homePath,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: wishlistsPath,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: transactionsPath,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
            );
          },
        ),
        GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: profilePath,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: const ProfilePage(),
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: shellNavigatorKey,
                name: 'addProduct',
                path: "add_product",
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: const AddProductPage(),
                  );
                },
              ),
            ]),
      ],
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: 'login',
      path: loginPath,
      builder: (BuildContext context, GoRouterState state) {
        return LoginPage(
          key: state.pageKey,
        );
      },
      redirect: (context, state) {
        final loggedIn = context.read<AuthenticationCubit>().state.status ==
            AuthStatus.authenticated;

        final bool loggingIn = state.matchedLocation == loginPath;

        if (!loggedIn) {
          return loggingIn ? null : loginPath;
        }

        if (loggingIn) {
          return profilePath;
        }

        return null;
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: 'products',
      path: "/products",
      builder: (BuildContext context, GoRouterState state) {
        return ProductsPage(
          key: state.pageKey,
        );
      },
      routes: [
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          name: 'productFlashSale',
          path: "flash-sale",
          builder: (BuildContext context, GoRouterState state) {
            return FlashSalePage(
              key: state.pageKey,
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          name: 'productDetail',
          path: ":productId",
          builder: (BuildContext context, GoRouterState state) {
            final productId = state.pathParameters["productId"];
            return ProductDetailPage(
              key: state.pageKey,
              productId: productId!,
            );
          },
        ),
      ],
    ),
  ],
);

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key, required this.child});
  final Widget child;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      primary: true,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _calculateSelectedIndex(context),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "Transaksi",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final GoRouterState route = GoRouterState.of(context);
    final String location = route.uri.toString();
    if (location.startsWith(homePath)) {
      return 0;
    }
    if (location.startsWith(wishlistsPath)) {
      return 1;
    }
    if (location.startsWith(transactionsPath)) {
      return 2;
    }
    if (location.startsWith(profilePath)) {
      return 3;
    }
    return 0;
  }

  void onTap(int value) {
    final authCubit = context.read<AuthenticationCubit>();

    final bool loggedIn = authCubit.state.status == AuthStatus.authenticated;

    switch (value) {
      case 0:
        context.go(homePath);
      case 1:
        context.go(wishlistsPath);
      case 2:
        if (loggedIn) {
          context.go('/cart', extra: 2);
        } else {
          context.push(loginPath);
        }
      case 3:
        if (loggedIn) {
          context.go(profilePath);
        } else {
          context.push(loginPath);
        }
      default:
        context.go(homePath);
    }
  }
}
