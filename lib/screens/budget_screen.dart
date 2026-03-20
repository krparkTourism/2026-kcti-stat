import 'package:flutter/material.dart';
import '../data/kcti_data.dart';
import '../widgets/common_widgets.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSummaryCards(),
        Container(
          color: const Color(0xFF1A3A5C),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: const Color(0xFF57C5B6),
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: '연도별 예산'),
              Tab(text: '수입 구조'),
              Tab(text: '지출 구조'),
              Tab(text: '특정목적사업'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildYearlyBudget(),
              _buildIncomeStructure(),
              _buildExpenseStructure(),
              _buildSpecialProjects(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCards() {
    return Container(
      color: const Color(0xFF1A3A5C),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '2026년 예산 현황',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '29,596백만원',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildHeaderChip('전년대비', '+1.7%', const Color(0xFF57C5B6)),
              const SizedBox(width: 8),
              _buildHeaderChip('출연금', '42.3%', Colors.white24),
              const SizedBox(width: 8),
              _buildHeaderChip('자체수입', '51.7%', Colors.white24),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYearlyBudget() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 바 차트형 시각화
          SectionCard(
            title: '연도별 예산 규모 (백만원)',
            icon: Icons.bar_chart,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: KctiData.budgetYears.asMap().entries.map((entry) {
                final i = entry.key;
                final year = entry.value;
                final total = KctiData.budgetIncome['합계']![i];
                final maxVal = 30000.0;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Text(
                          year,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: i >= 5
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: i >= 5
                                ? const Color(0xFF1A3A5C)
                                : Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 22,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: total / maxVal,
                              child: Container(
                                height: 22,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: i >= 5
                                        ? [const Color(0xFF1A3A5C), const Color(0xFF2E86AB)]
                                        : [const Color(0xFF57C5B6), const Color(0xFF9FD8CB)],
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 60,
                        child: Text(
                          _fmt(total),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: i >= 5
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: i >= 5
                                ? const Color(0xFF1A3A5C)
                                : Colors.black87,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildIncomeStructure() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: SectionCard(
        title: '2026년 수입 구조',
        icon: Icons.pie_chart,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 비교 행 (2025 vs 2026)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCompareCol('2025년', '29,098', Colors.grey.shade600),
                  const Icon(Icons.arrow_forward, color: Color(0xFF1A3A5C)),
                  _buildCompareCol('2026년', '29,596', const Color(0xFF1A3A5C)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF57C5B6).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '+498\n+1.7%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A3A5C),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...KctiData.income2026.map((item) => RatioBar(
                  label: item['label'] as String,
                  ratio: (item['ratio'] as double),
                  value: item['value'] as int,
                  color: Color(item['color'] as int),
                )),
            const SizedBox(height: 16),
            // 범례
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: KctiData.income2026.map((item) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Color(item['color'] as int),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item['label'] as String,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompareCol(String year, String amount, Color color) {
    return Column(
      children: [
        Text(year, style: TextStyle(fontSize: 11, color: color)),
        const SizedBox(height: 2),
        Text(
          amount,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text('백만원', style: TextStyle(fontSize: 10, color: color)),
      ],
    );
  }

  Widget _buildExpenseStructure() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SectionCard(
            title: '2026년 지출 구조',
            icon: Icons.account_balance_wallet,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: KctiData.expense2026.map((item) => RatioBar(
                    label: item['label'] as String,
                    ratio: (item['ratio'] as double),
                    value: item['value'] as int,
                    color: Color(item['color'] as int),
                  )).toList(),
            ),
          ),
          const SizedBox(height: 8),
          SectionCard(
            title: '지출 예산 비교 (2025 vs 2026)',
            icon: Icons.compare_arrows,
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 350,
                child: DataTable2(
                  headers: const ['사업명', '2025', '2026', '증감률'],
                  rows: const [
                    ['연구사업비(일반)', '3,337', '3,003', '△10.0%'],
                    ['수탁연구비', '6,113', '4,847', '△20.7%'],
                    ['개별출연사업비', '5,621', '7,271', '+29.4%'],
                    ['인건비', '10,883', '11,265', '+3.5%'],
                    ['경상비', '1,911', '1,914', '+0.2%'],
                    ['예비비', '800', '800', '0.0%'],
                    ['연구개발적립금', '433', '496', '+14.5%'],
                    ['합계', '29,098', '29,596', '+1.7%'],
                  ],
                  highlightRows: const [7],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialProjects() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: SectionCard(
        title: '특정목적출연사업 (2026년, 9건/7,271백만원)',
        icon: Icons.star_outline,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: KctiData.specialProjects.asMap().entries.map((entry) {
            final item = entry.value;
            final budget = (item['budget'] as int);
            final budgetM = budget / 1000; // 천원 → 백만원
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFF),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1A3A5C),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${item['no']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'] as String,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A3A5C),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item['dept'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E86AB).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${budgetM.toStringAsFixed(0)}백만',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E86AB),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
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
