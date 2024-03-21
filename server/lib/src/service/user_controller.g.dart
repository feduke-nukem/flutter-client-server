// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$UserControllerRouter(UserController service) {
  final router = Router();
  router.add(
    'POST',
    r'/',
    service.post,
  );
  router.add(
    'GET',
    r'/',
    service.getAll,
  );
  router.add(
    'DELETE',
    r'/<id>',
    service.delete,
  );
  router.add(
    'GET',
    r'/<id>',
    service.get,
  );
  router.add(
    'PATCH',
    r'/<id>',
    service.patch,
  );
  return router;
}
