import 'package:flutter/material.dart';
import '../data/kcti_data.dart';
import '../widgets/common_widgets.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          _buildStaffSummary(),
          _buildWagePeak(),
          _buildRating(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF1A3A5C),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('인사 현황', style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 4),
          Row(
            children: [
              _buildKpiCard('정원', '139명', '원장 포함'),
              const SizedBox(width: 12),
              _buildKpiCard('현원', '128명', '2026.2.2 기준'),
              const SizedBox(width: 12),
              _buildKpiCard('결원', '11명', '충원 필요'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKpiCard(String label, String value, String sub) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            Text(
              sub,
              style: const TextStyle(color: Colors.white38, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaffSummary() {
    final categories = ['원장', '연구직', '통계직', '행정직', '운영직', '기타'];
    return SectionCard(
      title: '직종별 인원 현황',
      icon: Icons.people,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 테이블 헤더
          Row(
            children: [
              const Expanded(flex: 2, child: SizedBox()),
              ...[
                '원장', '연구직', '통계직', '행정직', '운영직', '기타', '합계'
              ].map((h) => Expanded(
                    child: Text(
                      h,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A3A5C),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ],
          ),
          const Divider(height: 12),
          _buildStaffRow('정원', KctiData.staffQuota, isHeader: false),
          const SizedBox(height: 4),
          _buildStaffRow('현원', KctiData.staffCurrent, isHeader: false),
          const Divider(height: 12),
          // 결원 표시
          Row(
            children: [
              const Expanded(
                flex: 2,
                child: Text(
                  '결원',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              ...['원장', '연구직', '통계직', '행정직', '운영직', '기타', '합계'].map((k) {
                final quota = KctiData.staffQuota[k] ?? 0;
                final current = KctiData.staffCurrent[k] ?? 0;
                final diff = quota - current;
                return Expanded(
                  child: Text(
                    diff > 0 ? '$diff' : '-',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: diff > 0 ? Colors.red.shade600 : Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 16),
          // 직종별 현황 시각화
          ...categories.map((cat) {
            final quota = KctiData.staffQuota[cat] ?? 0;
            final current = KctiData.staffCurrent[cat] ?? 0;
            if (quota == 0) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(cat, style: const TextStyle(fontSize: 12)),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: quota / 80.0,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: const AlwaysStoppedAnimation(Color(0xFFB0C4DE)),
                            minHeight: 18,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: current / 80.0,
                            backgroundColor: Colors.transparent,
                            valueColor: const AlwaysStoppedAnimation(Color(0xFF1A3A5C)),
                            minHeight: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$current/$quota',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 8),
          Row(
            children: [
              _legendDot(const Color(0xFF1A3A5C), '현원'),
              const SizedBox(width: 12),
              _legendDot(const Color(0xFFB0C4DE), '정원'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStaffRow(String label, Map<String, int> data, {bool isHeader = false}) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.w600,
              color: const Color(0xFF1A3A5C),
            ),
          ),
        ),
        ...['원장', '연구직', '통계직', '행정직', '운영직', '기타', '합계'].map((k) {
          final val = data[k] ?? 0;
          return Expanded(
            child: Text(
              '$val',
              style: TextStyle(
                fontSize: 12,
                fontWeight: k == '합계' ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }),
      ],
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54)),
      ],
    );
  }

  Widget _buildWagePeak() {
    return SectionCard(
      title: '임금피크제 현황',
      icon: Icons.trending_down,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '적용: 정년퇴직일 기준 2년 전 (만 59세~전년퇴직일)\n임금조정: 1년차 70%, 2년차 60% | 근무시간: 1년차 2시간, 2년차 3시간/일 최대',
              style: TextStyle(fontSize: 11, color: Color(0xFF795548), height: 1.5),
            ),
          ),
          const SizedBox(height: 14),
          ...KctiData.wagePeak.map((item) {
            final year = item['year'] as int;
            final count = item['count'] as int;
            final isCurrent = year <= 2026;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isCurrent
                    ? const Color(0xFFE3F2FD)
                    : const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isCurrent ? const Color(0xFF2E86AB) : Colors.grey.shade200,
                  width: isCurrent ? 1.5 : 0.5,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    child: Text(
                      '$year',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isCurrent
                            ? const Color(0xFF1A3A5C)
                            : Colors.grey.shade700,
                      ),
                    ),
                  ),
                  Container(
                    width: 28,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isCurrent
                          ? const Color(0xFF1A3A5C)
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$count명',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item['names'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRating() {
    return SectionCard(
      title: '인사평정 현황',
      icon: Icons.grade,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          DataTable2(
            headers: const ['연도', '1등급', '2등급', '3등급', '4등급', '5등급', '합계'],
            rows: KctiData.staffRating.map((r) => [
              '${r['year']}',
              '${r['g1']}',
              '${r['g2']}',
              '${r['g3']}',
              '${r['g4']}',
              '${r['g5']}',
              '${r['total']}',
            ]).toList(),
            highlightRows: const [3],
          ),
          const SizedBox(height: 12),
          const Text(
            '2025년 기준: 1등급 2명·2등급 14명·3등급 82명·4등급 3명',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          // 2025년 등급 분포 시각화
          Row(
            children: [
              _ratingBar('1등급', 2, 101, const Color(0xFF1A3A5C)),
              _ratingBar('2등급', 14, 101, const Color(0xFF2E86AB)),
              _ratingBar('3등급', 82, 101, const Color(0xFF57C5B6)),
              _ratingBar('4등급', 3, 101, const Color(0xFF9FD8CB)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _ratingBar(String label, int count, int total, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Column(
          children: [
            Container(
              height: 60 * count / total + 10,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 10, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
