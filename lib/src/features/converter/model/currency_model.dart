class Currency {
  int? id;
  String? code;
  String? ccy;
  String? ccyNmRu;
  String? ccyNmUz;
  String? ccyNmUzc;
  String? ccyNmEn;
  String? nominal;
  String? rate;
  String? diff;
  String? date;

  Currency({
    this.id,
    this.code,
    this.ccy,
    this.ccyNmRu,
    this.ccyNmUz,
    this.ccyNmUzc,
    this.ccyNmEn,
    this.nominal,
    this.rate,
    this.diff,
    this.date,
  });

  factory Currency.fromJson(Map<String, Object?> json) {
    return Currency(
      id: json['id'] as int?,
      code: json['Code'] as String?,
      ccy: json['Ccy'] as String?,
      ccyNmRu: json['CcyNm_RU'] as String?,
      ccyNmUz: json['CcyNm_UZ'] as String?,
      ccyNmUzc: json['CcyNm_UZC'] as String?,
      ccyNmEn: json['CcyNm_EN'] as String?,
      nominal: json['Nominal'] as String?,
      rate: json['Rate'] as String?,
      diff: json['Diff'] as String?,
      date: json['Date'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'Code': code,
      'Ccy': ccy,
      'CcyNm_RU': ccyNmRu,
      'CcyNm_UZ': ccyNmUz,
      'CcyNm_UZC': ccyNmUzc,
      'CcyNm_EN': ccyNmEn,
      'Nominal': nominal,
      'Rate': rate,
      'Diff': diff,
      'Date': date,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Currency &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          code == other.code &&
          ccy == other.ccy &&
          ccyNmRu == other.ccyNmRu &&
          ccyNmUz == other.ccyNmUz &&
          ccyNmUzc == other.ccyNmUzc &&
          ccyNmEn == other.ccyNmEn &&
          nominal == other.nominal &&
          rate == other.rate &&
          diff == other.diff &&
          date == other.date;

  @override
  int get hashCode =>
      id.hashCode ^
      code.hashCode ^
      ccy.hashCode ^
      ccyNmRu.hashCode ^
      ccyNmUz.hashCode ^
      ccyNmUzc.hashCode ^
      ccyNmEn.hashCode ^
      nominal.hashCode ^
      rate.hashCode ^
      diff.hashCode ^
      date.hashCode;

  @override
  String toString() {
    return 'Currency(id: $id;  code: $code; ccy: $ccy; ccyNmRu: $ccyNmRu; ccyNmUz: $ccyNmUz; ccyNmUzc: $ccyNmUzc; ccyNmEn: $ccyNmEn; nominal: $nominal; rate: $rate; diff: $diff; date: $date)';
  }
}
