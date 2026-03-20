import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget child;
  final EdgeInsets? padding;

  const SectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.iconColor = const Color(0xFF1A3A5C),
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1A3A5C),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          // 내용
          Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }
}

class StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color bgColor;
  final Color textColor;

  const StatChip({
    super.key,
    required this.label,
    required this.value,
    this.bgColor = const Color(0xFFE8F0FE),
    this.textColor = const Color(0xFF1A3A5C),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: textColor.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}

class DataTable2 extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> rows;
  final List<int>? highlightRows;
  final Color headerColor;
  final double fontSize;

  const DataTable2({
    super.key,
    required this.headers,
    required this.rows,
    this.highlightRows,
    this.headerColor = const Color(0xFF1A3A5C),
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Table(
        border: TableBorder.all(
          color: Colors.grey.shade200,
          width: 0.5,
        ),
        columnWidths: _generateColumnWidths(),
        children: [
          // 헤더 행
          TableRow(
            decoration: BoxDecoration(color: headerColor),
            children: headers
                .map((h) => TableCell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                        child: Text(
                          h,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ))
                .toList(),
          ),
          // 데이터 행
          ...rows.asMap().entries.map((entry) {
            final idx = entry.key;
            final row = entry.value;
            final isHighlight = highlightRows?.contains(idx) ?? false;
            final isEven = idx % 2 == 0;
            return TableRow(
              decoration: BoxDecoration(
                color: isHighlight
                    ? const Color(0xFFE3F2FD)
                    : isEven
                        ? Colors.white
                        : const Color(0xFFF9FAFB),
              ),
              children: row.asMap().entries.map((cellEntry) {
                final isFirst = cellEntry.key == 0;
                return TableCell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Text(
                      cellEntry.value,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: (isHighlight || isFirst)
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: isHighlight
                            ? const Color(0xFF1A3A5C)
                            : Colors.black87,
                      ),
                      textAlign: isFirst ? TextAlign.left : TextAlign.right,
                    ),
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Map<int, TableColumnWidth> _generateColumnWidths() {
    final widths = <int, TableColumnWidth>{};
    if (headers.isEmpty) return widths;
    // 첫 번째 열은 넓게, 나머지는 고정 너비로 설정 (가로 스크롤 대응)
    widths[0] = const FixedColumnWidth(110);
    for (int i = 1; i < headers.length; i++) {
      widths[i] = const FixedColumnWidth(80);
    }
    return widths;
  }
}

class RatioBar extends StatelessWidget {
  final String label;
  final double ratio;
  final int value;
  final Color color;
  final String unit;

  const RatioBar({
    super.key,
    required this.label,
    required this.ratio,
    required this.value,
    required this.color,
    this.unit = '백만원',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                '${_formatNumber(value)} $unit',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 38,
                child: Text(
                  '${ratio.toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: ratio / 100,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int n) {
    final s = n.toString();
    final result = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) result.write(',');
      result.write(s[i]);
    }
    return result.toString();
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 4,
            margin: const EdgeInsets.only(top: 7, right: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF2E86AB),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
                color: highlight ? const Color(0xFF1A3A5C) : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrendIndicator extends StatelessWidget {
  final double change;
  final String unit;

  const TrendIndicator({
    super.key,
    required this.change,
    this.unit = '%',
  });

  @override
  Widget build(BuildContext context) {
    final isUp = change > 0;
    final isFlat = change == 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isFlat
              ? Icons.remove
              : isUp
                  ? Icons.arrow_upward
                  : Icons.arrow_downward,
          size: 14,
          color: isFlat
              ? Colors.grey
              : isUp
                  ? Colors.green.shade600
                  : Colors.red.shade600,
        ),
        Text(
          '${isUp ? '+' : ''}${change.toStringAsFixed(1)}$unit',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isFlat
                ? Colors.grey
                : isUp
                    ? Colors.green.shade600
                    : Colors.red.shade600,
          ),
        ),
      ],
    );
  }
}
