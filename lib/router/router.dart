import 'package:crud_api/screens/company_screen.dart';
import 'package:crud_api/screens/create_company.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const CompanyScreen(),
    ),
    GoRoute(
      path: '/addCompany',
      builder: (context, state) => CreateCompany(),
    ),
  ],
);
