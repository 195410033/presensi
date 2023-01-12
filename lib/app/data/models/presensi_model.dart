class Presensi {
  String? date;
  DataAbsen? masuk;
  DataAbsen? keluar;
  DataLain? cuti;
  DataLain? sakit;

  Presensi({this.date, this.masuk, this.keluar, this.cuti, this.sakit});

  Presensi.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    masuk = json['masuk'] != null ? DataAbsen?.fromJson(json['masuk']) : null;
    keluar =
        json['keluar'] != null ? DataAbsen?.fromJson(json['keluar']) : null;
    cuti = json['cuti'] != null ? DataLain?.fromJson(json['cuti']) : null;
    sakit = json['sakit'] != null ? DataLain?.fromJson(json['sakit']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    if (masuk != null) {
      data['masuk'] = masuk!.toJson();
    }
    if (keluar != null) {
      data['keluar'] = keluar!.toJson();
    }
    if (cuti != null) {
      data['cuti'] = cuti!.toJson();
    }
    if (sakit != null) {
      data['izin'] = sakit!.toJson();
    }
    return data;
  }

  static List<Presensi> fromJsonList(List? data) {
    if (data == null) {
      return [];
    } else {
      if (data.length == 0) {
        return [];
      } else {
        return data.map((e) => Presensi.fromJson(e)).toList();
      }
    }
  }
}

class DataAbsen {
  String? address;
  String? status;
  String? date;
  double? jarak;
  double? lat;
  double? long;

  DataAbsen(
      {this.address, this.status, this.date, this.jarak, this.lat, this.long});

  DataAbsen.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    status = json['status'];
    date = json['date'];
    jarak = json['jarak'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['address'] = address;
    data['status'] = status;
    data['date'] = date;
    data['jarak'] = jarak;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}

class DataLain {
  String? date;
  String? status;
  String? keterangan;

  DataLain({this.date, this.status, this.keterangan});

  DataLain.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status = json['status'];
    keterangan = json['keterangan'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['status'] = status;
    data['keterangan'] = keterangan;
    return data;
  }
}
