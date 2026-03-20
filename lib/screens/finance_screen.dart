import 'package:flutter/material.dart';
import '../data/kcti_data.dart';
import '../widgets/common_widgets.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          _buildFoundingInfo(),
          _buildAssetLiabilityChart(),
          _buildFundManagement(),
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
          const Text('회계 현황', style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 4),
          const Text(
            '2025년 결산(안)',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _statBox('자산총계', '14,740백만'),
              const SizedBox(width: 8),
              _statBox('부채총계', '10,363백만'),
              const SizedBox(width: 8),
              _statBox('자본총계', '4,377백만'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statBox(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(label, style: const TextStyle(color: Colors.white60, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildFoundingInfo() {
    return SectionCard(
      title: '기관 기본 정보',
      icon: Icons.info_outline,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          InfoRow(label: '설립 자본금', value: '512,000,000원', highlight: true),
          InfoRow(label: '한국문화정책개발원', value: '500,000,000원'),
          InfoRow(label: '한국관광연구원', value: '1,200,000원 (정관 제4조)'),
          InfoRow(label: '회계기준', value: '일반기업회계기준, 공익법인회계기준'),
          InfoRow(label: '외부감사 법인', value: '경복회계법인 (허준·곽홍구)', highlight: true),
          InfoRow(label: '외부감사 기간', value: '2025~2027 회계연도'),
          InfoRow(label: '내부감사', value: '이세철 (경기대 회계세무학전공 교수)'),
        ],
      ),
    );
  }

  Widget _buildAssetLiabilityChart() {
    return SectionCard(
      title: '자산 vs 부채·자본 추이',
      icon: Icons.stacked_bar_chart,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: KctiData.financialStatement.map((f) {
          final totalAsset = f['totalAsset'] as int;
          final totalLiab = f['totalLiab'] as int;
          final totalEquity = f['totalEquity'] as int;
          final max = 16000.0;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  f['year'] as String,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: LinearProgressIndicator(
                              value: totalAsset / max,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: const AlwaysStoppedAnimation(Color(0xFF2E86AB)),
                              minHeight: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '자산 ${_fmt(totalAsset)}',
                            style: const TextStyle(fontSize: 10, color: Color(0xFF2E86AB)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: LinearProgressIndicator(
                              value: totalLiab / max,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: const AlwaysStoppedAnimation(Color(0xFFEF5350)),
                              minHeight: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '부채 ${_fmt(totalLiab)}',
                            style: const TextStyle(fontSize: 10, color: Color(0xFFEF5350)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: LinearProgressIndicator(
                              value: totalEquity / max,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: const AlwaysStoppedAnimation(Color(0xFF26A69A)),
                              minHeight: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '자본 ${_fmt(totalEquity)}',
                            style: const TextStyle(fontSize: 10, color: Color(0xFF26A69A)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFundManagement() {
    return SectionCard(
      title: '자금관리 현황 (2025.12.31 기준)',
      icon: Icons.savings,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _fundRow(
            icon: Icons.account_balance_wallet,
            color: const Color(0xFF2E86AB),
            label: '보통예금',
            count: '19개',
            amount: '7,159백만원',
            desc: '사업별 개설계좌, 자체자금 및 수입, 법인카드결제, 퇴직충당금적립 등',
          ),
          const SizedBox(height: 12),
          _fundRow(
            icon: Icons.local_atm,
            color: const Color(0xFF1A3A5C),
            label: '정기예금',
            count: '6개',
            amount: '5,512백만원',
            desc: '신한은행(4개) 및 하나은행(2개), 퇴직적립금 및 기관설립 자본금 예치',
          ),
        ],
      ),
    );
  }

  Widget _fundRow({
    required IconData icon,
    required Color color,
    required String label,
    required String count,
    required String amount,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        count,
                        style: const TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  amount,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(fontSize: 11, color: Colors.black54, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(int n) {
    final s = n.toString();
    final result = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) result.write(',');
      result.write(s[i]);
    }
    return result.toString();
  }
}
