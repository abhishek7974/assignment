// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

class ProductModel {
  ProductModel({
    this.pName,
    this.pId,
    this.pCost,
    this.imageUrl,
    this.pAvailability,
    this.pDetails,
    this.pCategory,
  });

  final String? pName;
  final int? pId;
  final int? pCost;
  final String? imageUrl;
  final int? pAvailability;
  final String? pDetails;
  final String? pCategory;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        pName: json["p_name"],
        pId: json["p_id"],
        pCost: json["p_cost"],
        imageUrl: json["image_url"],
        pAvailability: json["p_availability"],
        pDetails: json["p_details"] == null ? null : json["p_details"],
        pCategory: json["p_category"] == null ? null : json["p_category"],
      );

  Map<String, dynamic> toJson() => {
        "p_name": pName,
        "p_id": pId,
        "p_cost": pCost,
        "image_url": imageUrl,
        "p_availability": pAvailability,
        "p_details": pDetails == null ? null : pDetails,
        "p_category": pCategory == null ? null : pCategory,
      };
}
