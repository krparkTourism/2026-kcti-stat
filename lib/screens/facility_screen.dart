import 'package:flutter/material.dart';
import '../data/kcti_data.dart';
import '../widgets/common_widgets.dart';

class FacilityScreen extends StatelessWidget {
  const FacilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          _buildFacilityInfo(),
          _buildFloorTable(),
          _buildFeeChart(),
          _buildContractStatus(),
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
          const Text('시설 개요', style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 4),
          const Text(
            '국유재산 임차 (국립국어원)',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _chip('연면적', '6,412.06㎡'),
              const SizedBox(width: 8),
              _chip('전용면적', '3,493.93㎡'),
              const SizedBox(width: 8),
              _chip('1인당', '37.50㎡'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white30),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.white60, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildFacilityInfo() {
    return SectionCard(
      title: '시설 기본 정보',
      icon: Icons.business,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          InfoRow(label: '사용형태', value: '국유재산 임차(국립국어원)'),
          InfoRow(label: '허가기간', value: '2025.7.1. ~ 2027.6.30.'),
          InfoRow(label: '임차료(2025)', value: '171,304,740원 (부가세 포함)', highlight: true),
          InfoRow(label: '관리유지비(2025)', value: '565,662,870원 (분기 납부)', highlight: true),
          InfoRow(label: '상시근로자', value: '171명 기준'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('■ 시설 연혁', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A3A5C))),
                SizedBox(height: 6),
                _TimelineItem(year: '2000.10', text: '한국문화정책개발원 이전'),
                _TimelineItem(year: '2002.12', text: '기관통합으로 한국관광연구원 현 공간으로 이전'),
                _TimelineItem(year: '2007.04', text: '공간 부족으로 상암동 분원 운영 시작'),
                _TimelineItem(year: '2009.07', text: '사무공간 통합'),
                _TimelineItem(year: '2015.07', text: '사무공간 확대(246평 전용면적 증가)'),
                _TimelineItem(year: '2023.07', text: '1층 정책자료실 공간 국립국어원 반납'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloorTable() {
    return SectionCard(
      title: '층별 면적 현황',
      icon: Icons.layers,
      padding: const EdgeInsets.all(16),
      child: DataTable2(
        headers: const ['층', '연면적(㎡)', '전용(㎡)', '공용(㎡)', '(평)'],
        rows: KctiData.facilityFloors.map((f) => [
          f['floor'] as String,
          '${f['total']}',
          '${f['exclusive']}',
          '${f['common']}',
          '${f['pyeong']}평',
        ]).toList(),
        highlightRows: const [4],
      ),
    );
  }

  Widget _buildFeeChart() {
    return SectionCard(
      title: '청사 임차료 및 관리비 추이 (단위: 백만원)',
      icon: Icons.show_chart,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          DataTable2(
            headers: const ['연도', '임차료', '관리유지비', '합계'],
            rows: KctiData.facilityFee.map((f) => [
              '${f['year']}',
              '${f['rent']}',
              '${f['maint']}',
              '${(f['rent'] as int) + (f['maint'] as int)}',
            ]).toList(),
            highlightRows: const [5],
          ),
          const SizedBox(height: 16),
          // 임차료 vs 관리비 시각화
          ...KctiData.facilityFee.map((f) {
            final rent = f['rent'] as int;
            final maint = f['maint'] as int;
            final total = rent + maint;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${f['year']}년  (합계: ${total}백만원)',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Row(
                      children: [
                        Flexible(
                          flex: rent,
                          child: Container(
                            height: 14,
                            color: const Color(0xFF1A3A5C),
                          ),
                        ),
                        Flexible(
                          flex: maint,
                          child: Container(
                            height: 14,
                            color: const Color(0xFF57C5B6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 8),
          Row(
            children: [
              _legendDot(const Color(0xFF1A3A5C), '임차료'),
              const SizedBox(width: 12),
              _legendDot(const Color(0xFF57C5B6), '관리유지비'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContractStatus() {
    return SectionCard(
      title: '계약 현황 (최근 3년)',
      icon: Icons.assignment,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          DataTable2(
            headers: const ['구분', '건수(2023)', '건수(2024)', '건수(2025)', '금액(2023)', '금액(2024)', '금액(2025)'],
            rows: KctiData.contractStatus.map((c) => [
              c['type'] as String,
              '${c['count2023']}건',
              '${c['count2024']}건',
              '${c['count2025']}건',
              '${(c['amt2023'] as int)}백만',
              '${(c['amt2024'] as int)}백만',
              '${(c['amt2025'] as int)}백만',
            ]).toList(),
          ),
          const SizedBox(height: 16),
          // 계약 건수 시각화
          ...KctiData.contractStatus.map((c) {
            final max = 200;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c['type'] as String,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1A3A5C)),
                ),
                const SizedBox(height: 6),
                _contractBar('2023', c['count2023'] as int, max, const Color(0xFF9FD8CB)),
                _contractBar('2024', c['count2024'] as int, max, const Color(0xFF2E86AB)),
                _contractBar('2025', c['count2025'] as int, max, const Color(0xFF1A3A5C)),
                const SizedBox(height: 10),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _contractBar(String year, int count, int max, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 36,
            child: Text(year, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: count / max,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$count건',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
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
}

class _TimelineItem extends StatelessWidget {
  final String year;
  final String text;

  const _TimelineItem({required this.year, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            child: Text(
              year,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF2E86AB),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF1A3A5C),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 11, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
