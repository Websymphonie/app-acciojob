import 'dart:convert';

import 'package:acciojob/services/models/checkbox.dart';
import 'package:acciojob/services/models/quantitie.dart';
import 'package:acciojob/services/models/radio.dart';

Order orderModelFromJson(String str) => Order.fromJson(json.decode(str));

String orderModelToJson(Order data) => json.encode(data.toJson());

class OrderModel {
  static List<Order> orders = [];

  static Order getByPosition(int pos) => orders[pos];
}

class Order {
  int? priceTransportService;
  int? priceBase;
  String? dateHeure;
  String? adresse;
  String? longitude;
  String? latitude;
  String? others;
  bool? isAcceptCondition;
  int? clients;
  int? categories;
  int? communes;
  Checkboxs? checkboxs;
  Quantities? quantities;
  Radios? radios;
  Order({
    this.priceTransportService,
    this.priceBase,
    this.dateHeure,
    this.adresse,
    this.longitude,
    this.latitude,
    this.others,
    this.isAcceptCondition,
    this.clients,
    this.categories,
    this.communes,
    this.checkboxs,
    this.quantities,
    this.radios,
  });

  Order copyWith({
    int? priceTransportService,
    int? priceBase,
    String? dateHeure,
    String? adresse,
    String? longitude,
    String? latitude,
    String? others,
    bool? isAcceptCondition,
    int? clients,
    int? categories,
    int? communes,
    Checkboxs? checkboxs,
    Quantities? quantities,
    Radios? radios,
  }) {
    return Order(
      priceTransportService:
          priceTransportService ?? this.priceTransportService,
      priceBase: priceBase ?? this.priceBase,
      dateHeure: dateHeure ?? this.dateHeure,
      adresse: adresse ?? this.adresse,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      others: others ?? this.others,
      isAcceptCondition: isAcceptCondition ?? this.isAcceptCondition,
      clients: clients ?? this.clients,
      categories: categories ?? this.categories,
      communes: communes ?? this.communes,
      checkboxs: checkboxs ?? this.checkboxs,
      quantities: quantities ?? this.quantities,
      radios: radios ?? this.radios,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'priceTransportService': priceTransportService,
      'priceBase': priceBase,
      'dateHeure': dateHeure,
      'adresse': adresse,
      'longitude': longitude,
      'latitude': latitude,
      'others': others,
      'isAcceptCondition': isAcceptCondition,
      'clients': clients,
      'categories': categories,
      'communes': communes,
      'checkboxs': checkboxs?.toMap(),
      'quantities': quantities?.toMap(),
      'radios': radios?.toMap(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      priceTransportService: map['priceTransportService']?.toInt(),
      priceBase: map['priceBase']?.toInt(),
      dateHeure: map['dateHeure'],
      adresse: map['adresse'],
      longitude: map['longitude'],
      latitude: map['latitude'],
      others: map['others'],
      isAcceptCondition: map['isAcceptCondition'],
      clients: map['clients']?.toInt(),
      categories: map['categories']?.toInt(),
      communes: map['communes']?.toInt(),
      checkboxs:
          map['checkboxs'] != null ? Checkboxs.fromMap(map['checkboxs']) : null,
      quantities: map['quantities'] != null
          ? Quantities.fromMap(map['quantities'])
          : null,
      radios: map['radios'] != null ? Radios.fromMap(map['radios']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(priceTransportService: $priceTransportService, priceBase: $priceBase, dateHeure: $dateHeure, adresse: $adresse, longitude: $longitude, latitude: $latitude, others:$others, isAcceptCondition: $isAcceptCondition, clients: $clients, categories: $categories, communes: $communes, checkboxs: $checkboxs, quantities: $quantities, radios: $radios)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.priceTransportService == priceTransportService &&
        other.priceBase == priceBase &&
        other.dateHeure == dateHeure &&
        other.adresse == adresse &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.others == others &&
        other.isAcceptCondition == isAcceptCondition &&
        other.clients == clients &&
        other.categories == categories &&
        other.communes == communes &&
        other.checkboxs == checkboxs &&
        other.quantities == quantities &&
        other.radios == radios;
  }

  @override
  int get hashCode {
    return priceTransportService.hashCode ^
        priceBase.hashCode ^
        dateHeure.hashCode ^
        adresse.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        others.hashCode ^
        isAcceptCondition.hashCode ^
        clients.hashCode ^
        categories.hashCode ^
        communes.hashCode ^
        checkboxs.hashCode ^
        quantities.hashCode ^
        radios.hashCode;
  }
}
