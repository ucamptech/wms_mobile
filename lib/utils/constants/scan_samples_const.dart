class ScanSample {
  const ScanSample({
    required this.code,
    required this.operation,
    required this.detail,
    this.defaultQty = '1',
    this.isBin = false,
  });

  final String code;
  final String operation;
  final String detail;
  final String defaultQty;
  final bool isBin;
}

class ScanSamplesConst {
  static const all = <ScanSample>[
    ScanSample(
      code: 'PO-2024-0889',
      operation: 'receive',
      detail: 'Global Hardware Co. · 12 line items',
      defaultQty: '24',
    ),
    ScanSample(
      code: 'SKU-10042',
      operation: 'putaway',
      detail: 'Industrial Motor 5HP · 24 units awaiting',
      defaultQty: '10',
    ),
    ScanSample(
      code: 'SO-2024-1198',
      operation: 'pick',
      detail: 'BrightBuild Ltd. · 3 items to pick',
      defaultQty: '10',
    ),
    ScanSample(
      code: 'BIN CODE',
      operation: 'putaway',
      detail: 'Bin location A1-03',
      defaultQty: '0',
      isBin: true,
    ),
  ];

  static ScanSample? lookup(
    String operation,
    String barcode, {
    bool bin = false,
  }) {
    final code = barcode.trim();
    if (code.isEmpty) return null;

    for (final sample in all) {
      if (sample.operation == operation &&
          sample.isBin == bin &&
          sample.code.toUpperCase() == code.toUpperCase()) {
        return sample;
      }
    }
    return null;
  }
}
