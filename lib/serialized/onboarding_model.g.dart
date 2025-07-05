// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnBoardingModel _$OnBoardingModelFromJson(Map<String, dynamic> json) =>
    OnBoardingModel(
      image: json['image'] as String?,
      headerLine: json['headerLine'] as String?,
      subHeaderLine: json['subHeaderLine'] as String?,
      isShow: json['isShow'] as bool? ?? false,
    );

Map<String, dynamic> _$OnBoardingModelToJson(OnBoardingModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'headerLine': instance.headerLine,
      'subHeaderLine': instance.subHeaderLine,
      'isShow': instance.isShow,
    };
