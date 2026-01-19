import 'package:go_router/go_router.dart';
import '../data/UserModel.dart';

void redirectAfterLogin(context, UserModel user) {
  switch (user.role) {
    case 'ORGANIZATION':
      context.go('/customer/home');
      break;
    case 'PROVIDER':
      context.go('/provider/home');
      break;
    case 'SUPER_ADMIN':
      context.go('/admin/home');
      break;
    default:
      context.go('/login');
  }
}
