// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListResponse<T> _$ListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ListResponse<T>(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>).map(fromJsonT).toList(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
    );
