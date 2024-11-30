// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StatusProductListModel {
  final String id;
  final String buyerFullName;
  final String supplierFullName;
  final String sectorName;
  final String requestedAt;
  final double? totalAmount;
  final String repaymentCycleDuration;
  final String status;
  final String? promiseToPurchaseDocument;
  StatusProductListModel({
    required this.id,
    required this.buyerFullName,
    required this.supplierFullName,
    required this.sectorName,
    required this.requestedAt,
    this.totalAmount,
    required this.repaymentCycleDuration,
    required this.status,
    this.promiseToPurchaseDocument,
  });

  StatusProductListModel copyWith({
    String? id,
    String? buyerFullName,
    String? supplierFullName,
    String? sectorName,
    String? requestedAt,
    double? totalAmount,
    String? repaymentCycleDuration,
    String? status,
    String? promiseToPurchaseDocument,
  }) {
    return StatusProductListModel(
      id: id ?? this.id,
      buyerFullName: buyerFullName ?? this.buyerFullName,
      supplierFullName: supplierFullName ?? this.supplierFullName,
      sectorName: sectorName ?? this.sectorName,
      requestedAt: requestedAt ?? this.requestedAt,
      totalAmount: totalAmount ?? this.totalAmount,
      repaymentCycleDuration:
          repaymentCycleDuration ?? this.repaymentCycleDuration,
      status: status ?? this.status,
      promiseToPurchaseDocument:
          promiseToPurchaseDocument ?? this.promiseToPurchaseDocument,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'buyerFullName': buyerFullName,
      'supplierFullName': supplierFullName,
      'sectorName': sectorName,
      'requestedAt': requestedAt,
      'totalAmount': totalAmount,
      'repaymentCycleDuration': repaymentCycleDuration,
      'status': status,
      'promiseToPurchaseDocument': promiseToPurchaseDocument,
    };
  }

  factory StatusProductListModel.fromMap(Map<String, dynamic> map) {
    return StatusProductListModel(
      id: map['id'] as String,
      buyerFullName: map['buyerFullName'] as String,
      supplierFullName: map['supplierFullName'] as String,
      sectorName: map['sectorName'] as String,
      requestedAt: map['requestedAt'] as String,
      totalAmount:
          map['totalAmount'] != null ? map['totalAmount'] as double : null,
      repaymentCycleDuration: map['repaymentCycleDuration'] as String,
      status: map['status'] as String,
      promiseToPurchaseDocument: map['promiseToPurchaseDocument'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusProductListModel.fromJson(String source) =>
      StatusProductListModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StatusProductListModel( id: $id, buyerFullName: $buyerFullName, supplierFullName: $supplierFullName, sectorName: $sectorName, requestedAt: $requestedAt, totalAmount: $totalAmount, repaymentCycleDuration: $repaymentCycleDuration, status: $status, promiseToPurchaseDocument: $promiseToPurchaseDocument)';
  }

  @override
  bool operator ==(covariant StatusProductListModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.buyerFullName == buyerFullName &&
        other.supplierFullName == supplierFullName &&
        other.sectorName == sectorName &&
        other.requestedAt == requestedAt &&
        other.totalAmount == totalAmount &&
        other.repaymentCycleDuration == repaymentCycleDuration &&
        other.status == status &&
        other.promiseToPurchaseDocument == promiseToPurchaseDocument;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        buyerFullName.hashCode ^
        supplierFullName.hashCode ^
        sectorName.hashCode ^
        requestedAt.hashCode ^
        totalAmount.hashCode ^
        repaymentCycleDuration.hashCode ^
        status.hashCode ^
        promiseToPurchaseDocument.hashCode;
  }
}