import 'package:acciojob/services/models/commandes/categorie.dart';
import 'package:acciojob/services/models/commandes/commune.dart';
import 'package:acciojob/services/models/commandes/linecommande.dart';
import 'package:acciojob/services/models/commandes/status.dart';

class CommandesModel {
  static List<Commandes> commandes = [];

  static Commandes getById(int id) =>
      commandes.firstWhere((element) => element.id == id);

  static Commandes getByPosition(int pos) => commandes[pos];
}

class Commandes {
  int? id;
  String? reference;
  int? total;
  int? priceTransportService;
  int? priceBase;
  String? adresse;
  String? others;
  String? dateHeure;
  String? longitude;
  String? latitude;
  bool? isAnnuler;
  bool? isFacture;
  bool? isAcceptCondition;
  Status? status;
  Categories? categories;
  List<Linecommandes>? linecommandes;
  Communes? communes;

  Commandes(
      {this.id,
      this.reference,
      this.total,
      this.priceTransportService,
      this.priceBase,
      this.adresse,
      this.others,
      this.dateHeure,
      this.longitude,
      this.latitude,
      this.isAnnuler,
      this.isFacture,
      this.isAcceptCondition,
      this.status,
      this.categories,
      this.linecommandes,
      this.communes});

  Commandes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    total = json['total'];
    priceTransportService = json['price_transport_service'];
    priceBase = json['price_base'];
    adresse = json['adresse'];
    others = json['others'];
    dateHeure = json['date_heure'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    isAnnuler = json['is_annuler'];
    isFacture = json['is_facture'];
    isAcceptCondition = json['is_accept_condition'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    categories = json['categories'] != null
        ? Categories.fromJson(json['categories'])
        : null;
    if (json['linecommandes'] != null) {
      linecommandes = <Linecommandes>[];
      json['linecommandes'].forEach((v) {
        linecommandes!.add(Linecommandes.fromJson(v));
      });
    }
    communes =
        json['communes'] != null ? Communes.fromJson(json['communes']) : null;
  }

  factory Commandes.fromMap(Map<String, dynamic> map) {
    return Commandes(
      id: map['id']?.toInt() ?? 0,
      reference: map['reference'] ?? '',
      total: map['total'] ?? 0,
      priceTransportService: map['price_transport_service'] ?? '',
      priceBase: map['price_base'] ?? '',
      adresse: map['adresse'] ?? '',
      others: map['others'] ?? '',
      dateHeure: map['date_heure'] ?? '',
      longitude: map['longitude'] ?? '',
      latitude: map['latitude'] ?? '',
      isAnnuler: map['is_annuler'] ?? '',
      isFacture: map['is_facture'] ?? '',
      isAcceptCondition: map['is_accept_condition'] ?? '',
      status: map['status'] != null ? Status.fromJson(map['status']) : null,
      categories: map['categories'] != null
          ? Categories.fromJson(map['categories'])
          : null,
      linecommandes: map['linecommandes'] != null
          ? List<Linecommandes>.from(
              map['linecommandes']?.map((x) => Linecommandes.fromMap(x)))
          : null,
      communes:
          map['communes'] != null ? Communes.fromJson(map['communes']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reference'] = reference;
    data['total'] = total;
    data['price_transport_service'] = priceTransportService;
    data['price_base'] = priceBase;
    data['adresse'] = adresse;
    data['others'] = others;
    data['date_heure'] = dateHeure;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['is_annuler'] = isAnnuler;
    data['is_facture'] = isFacture;
    data['is_accept_condition'] = isAcceptCondition;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (categories != null) {
      data['categories'] = categories!.toJson();
    }
    if (linecommandes != null) {
      data['linecommandes'] = linecommandes!.map((v) => v.toJson()).toList();
    }
    if (communes != null) {
      data['communes'] = communes!.toJson();
    }
    return data;
  }
}
