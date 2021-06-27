/**
 * Created by HauTran on 22/06/2021.
 * hautv.fami@gmail.com
 */
enum Symbology {
  // ALL_FORMATS,

  // For bolt Scandit/Scanner
  DATA_MATRIX,
  AZTEC,
  PDF417,
  CODABAR,
  QR,
  EAN13,
  UPCE,
  UPCA,
  EAN8,
  CODE39,
  CODE93,
  CODE128,
  INTERLEAVED_TWO_OF_FIVE,

  // Just scandit
  CODE11,
  CODE25,
  MSI_PLESSEY,
  MAXI_CODE,
  DOT_CODE,
  KIX,
  RM4SCC,
  GS1_DATABAR,
  GS1_DATABAR_EXPANDED,
  GS1_DATABAR_LIMITED,
  MICRO_PDF417,
  MICRO_QR,
  CODE32,
  LAPA4SC,
}

extension Utils on Symbology {
  List<String> get all => Symbology.values.map((e) => e.stringify).toList();

  String get stringify => this.toString().split('.').last;

  Symbology parse(String s) => Symbology.values.singleWhere(
        (e) => e.stringify == s,
        orElse: () => Symbology.DATA_MATRIX,
      );
}
