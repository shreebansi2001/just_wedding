import 'dart:convert';
import 'package:dio/dio.dart';

class EventEstimateRequestDto {
  final double? cashAmount;
  final double? cgst;
  final double? chequeAmount;
  final double? discount;
  final double? discountAmount;
  final String? estimateDate;
  final String? estimateType; // MAIN, OTHER
  final int? eventId;
  final List<EventEstimateFunctionRequestDto>? functions;
  final int? id;
  final double? igst;
  final String? notes;
  final List<EventEstimatePaymentRequestDto>? payments;
  final double? roundOff;
  final double? sgst;
  final String? statusType; // PENDING, INPROGRESS, COMPLETED, CANCEL
  final double? taxAmount;
  final int? userId;

  EventEstimateRequestDto({
    this.cashAmount,
    this.cgst,
    this.chequeAmount,
    this.discount,
    this.discountAmount,
    this.estimateDate,
    this.estimateType,
    this.eventId,
    this.functions,
    this.id,
    this.igst,
    this.notes,
    this.payments,
    this.roundOff,
    this.sgst,
    this.statusType,
    this.taxAmount,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      if (cashAmount != null) 'cashAmount': cashAmount,
      if (cgst != null) 'cgst': cgst,
      if (chequeAmount != null) 'chequeAmount': chequeAmount,
      if (discount != null) 'discount': discount,
      if (discountAmount != null) 'discountAmount': discountAmount,
      if (estimateDate != null) 'estimateDate': estimateDate,
      if (estimateType != null) 'estimateType': estimateType,
      if (eventId != null) 'eventId': eventId,
      if (functions != null) 'functions': functions!.map((x) => x.toJson()).toList(),
      if (id != null) 'id': id,
      if (igst != null) 'igst': igst,
      if (notes != null) 'notes': notes,
      if (payments != null) 'payments': payments!.map((x) => x.toJson()).toList(),
      if (roundOff != null) 'roundOff': roundOff,
      if (sgst != null) 'sgst': sgst,
      if (statusType != null) 'statusType': statusType,
      if (taxAmount != null) 'taxAmount': taxAmount,
      if (userId != null) 'userId': userId,
    };
  }

  FormData toFormData() {
    final Map<String, dynamic> data = toJson();
    
    // Passing the JSON string in 'data' field per instruction
    final formData = FormData.fromMap({
      'data': jsonEncode(data),
    });

    // Note: If 'images' in items are MultipartFile objects, 
    // they should be extracted here and added to formData.files.
    // e.g., formData.files.add(MapEntry('images', await MultipartFile.fromFile(path)));
    
    return formData;
  }
}

class EventEstimateFunctionRequestDto {
  final int? eventFunctionId;
  final int? id;
  final List<EventEstimateItemRequestDto>? items;

  EventEstimateFunctionRequestDto({
    this.eventFunctionId,
    this.id,
    this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      if (eventFunctionId != null) 'eventFunctionId': eventFunctionId,
      if (id != null) 'id': id,
      if (items != null) 'items': items!.map((x) => x.toJson()).toList(),
    };
  }
}

class EventEstimateItemRequestDto {
  final String? description;
  final double? discount;
  final double? discountRate;
  final int? id;
  final List<dynamic>? images; // Can be updated to correct type when image upload is implemented
  final int? menuItemId;
  final int? qty;
  final double? rate;
  final String? size;
  final String? sqFt;

  EventEstimateItemRequestDto({
    this.description,
    this.discount,
    this.discountRate,
    this.id,
    this.images,
    this.menuItemId,
    this.qty,
    this.rate,
    this.size,
    this.sqFt,
  });

  Map<String, dynamic> toJson() {
    return {
      if (description != null) 'description': description,
      if (discount != null) 'discount': discount,
      if (discountRate != null) 'discountRate': discountRate,
      if (id != null) 'id': id,
      if (images != null) 'images': images,
      if (menuItemId != null) 'menuItemId': menuItemId,
      if (qty != null) 'qty': qty,
      if (rate != null) 'rate': rate,
      if (size != null) 'size': size,
      if (sqFt != null) 'sqFt': sqFt,
    };
  }
}

class EventEstimatePaymentRequestDto {
  final double? amount;
  final int? bankId;
  final int? cashAccountId;
  final String? description;
  final int? id;
  final String? mode; // BANK_TRANSFER, UPI, CASH, CHEQUE
  final String? paymentDate;

  EventEstimatePaymentRequestDto({
    this.amount,
    this.bankId,
    this.cashAccountId,
    this.description,
    this.id,
    this.mode,
    this.paymentDate,
  });

  Map<String, dynamic> toJson() {
    return {
      if (amount != null) 'amount': amount,
      if (bankId != null) 'bankId': bankId,
      if (cashAccountId != null) 'cashAccountId': cashAccountId,
      if (description != null) 'description': description,
      if (id != null) 'id': id,
      if (mode != null) 'mode': mode,
      if (paymentDate != null) 'paymentDate': paymentDate,
    };
  }
}
