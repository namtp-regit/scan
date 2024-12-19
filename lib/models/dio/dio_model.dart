import 'package:json_annotation/json_annotation.dart';

part 'dio_model.g.dart';

@JsonSerializable(
    createToJson: false,
    genericArgumentFactories: true,
    fieldRename: FieldRename.snake)
class ListResponse<T> {
  final int page;
  final List<T> results;
  final int totalPages;
  final int totalResults;

  ListResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  @override
  String toString() {
    return 'ListResponse<$T>{page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults}';
  }

  @override
  factory ListResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return _$ListResponseFromJson(json, fromJsonT);
  }
}
