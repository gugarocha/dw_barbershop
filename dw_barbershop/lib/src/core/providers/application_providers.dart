import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../restClient/rest_client.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();