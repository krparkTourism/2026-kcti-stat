import 'package:flutter/material.dart';
import '../data/kcti_data.dart';
import '../widgets/common_widgets.dart';

class ResearchScreen extends StatefulWidget {
  const ResearchScreen({super.key});

  @override
  State<ResearchScreen> createState() => _ResearchScreenState();
}

class _ResearchScreenState extends State<ResearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedField = '전체';

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
        _buildHeader(),
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
              Tab(text: '연구 건수'),
              Tab(text: '연구 목록'),
              Tab(text: '통계 목록'),
              Tab(text: '관련 사업'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildResearchCount(),
              _buildResearchProjects(),
              _buildStatistics(),
              _buildRelatedBusiness(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF1A3A5C),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('연구사업 현황', style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 4),
          const Text(
            '2025년 총 129건',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _chip('자체연구', '59건', const Color(0xFF57C5B6)),
              const SizedBox(width: 8),
              _chip('수탁연구', '70건', Colors.white24),
              const SizedBox(width: 8),
              _chip('출연금사업', '11건', Colors.white24),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
          const SizedBox(width: 4),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildResearchCount() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SectionCard(
            title: '연구 유형별 건수 (2023~2025)',
            icon: Icons.science,
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 360,
                child: DataTable2(
                  headers: const ['구분', '2023', '2024', '2025'],
                  rows: KctiData.researchCount.map((r) => [
                    r['type'] as String,
                    '${r['y2023']}',
                    '${r['y2024']}',
                    '${r['y2025']}',
                  ]).toList(),
                  highlightRows: const [7, 8, 9, 10],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SectionCard(
            title: '2025년 연구 구성',
            icon: Icons.donut_large,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _researchPieRow('기초연구', 6, 129, const Color(0xFF1A3A5C)),
                _researchPieRow('정책연구', 24, 129, const Color(0xFF2E86AB)),
                _researchPieRow('수시연구', 9, 129, const Color(0xFF57C5B6)),
                _researchPieRow('현안연구', 10, 129, const Color(0xFF9FD8CB)),
                _researchPieRow('정책리포트', 7, 129, const Color(0xFFB8E0D2)),
                _researchPieRow('특별연구', 1, 129, const Color(0xFFD6EFD8)),
                _researchPieRow('계약연구', 59, 129, const Color(0xFF0D6EFD)),
                _researchPieRow('출연금사업', 11, 129, const Color(0xFF6610F2)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SectionCard(
            title: '특정목적출연사업 (9건)',
            icon: Icons.star,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: KctiData.specialProjects.map((p) {
                final budgetM = (p['budget'] as int) ~/ 1000;
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF1A3A5C),
                    radius: 13,
                    child: Text(
                      '${p['no']}',
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                  title: Text(p['name'] as String, style: const TextStyle(fontSize: 13)),
                  subtitle: Text(p['dept'] as String, style: const TextStyle(fontSize: 11)),
                  trailing: Text(
                    '${budgetM}백만원',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E86AB),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _researchPieRow(String label, int count, int total, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: const TextStyle(fontSize: 12)),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: count / total,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 16,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$count건 (${(count / total * 100).toStringAsFixed(1)}%)',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResearchProjects() {
    final fields = ['전체', '문화', '관광', '콘텐츠', '데이터'];
    final fieldColors = {
      '문화': const Color(0xFF1A3A5C),
      '관광': const Color(0xFF2E86AB),
      '콘텐츠': const Color(0xFFE74C3C),
      '데이터': const Color(0xFF27AE60),
    };
    final filtered = _selectedField == '전체'
        ? KctiData.researchProjects
        : KctiData.researchProjects.where((p) => p['field'] == _selectedField).toList();

    return Column(
      children: [
        // 필터 탭
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: fields.map((f) {
                final isSelected = f == _selectedField;
                return GestureDetector(
                  onTap: () => setState(() => _selectedField = f),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF1A3A5C) : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      f,
                      style: TextStyle(
                        fontSize: 13,
                        color: isSelected ? Colors.white : Colors.grey.shade700,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final item = filtered[index];
              final fieldColor = fieldColors[item['field'] as String] ?? Colors.grey;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 번호
                    SizedBox(
                      width: 28,
                      child: Text(
                        '${item['no']}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A3A5C),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 태그
                          Row(
                            children: [
                              _tag(item['field'] as String, fieldColor),
                              const SizedBox(width: 6),
                              _tag(
                                item['type'] as String,
                                item['type'] == '기초'
                                    ? const Color(0xFF6C3483)
                                    : const Color(0xFF17A589),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item['title'] as String,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                          if ((item['researcher'] as String).isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              '연구진: ${item['researcher']}',
                              style: const TextStyle(fontSize: 11, color: Colors.black45),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _tag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    final statColors = {
      '공통(1)': const Color(0xFF1A3A5C),
      '문화(3)': const Color(0xFF9B59B6),
      '관광(4)': const Color(0xFF2E86AB),
      '연구원 승인(1)': const Color(0xFF27AE60),
    };
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SectionCard(
            title: '승인통계 현황 (총 9종)',
            icon: Icons.analytics,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatBadge(label: '문체부 승인', count: 8),
                      _StatBadge(label: '연구원 승인', count: 1),
                      _StatBadge(label: '합계', count: 9),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                ...KctiData.statistics.map((s) {
                  final color = statColors[s['category'] as String] ?? Colors.grey;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: color, width: 4),
                      ),
                      color: color.withValues(alpha: 0.04),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 4),
                          child: Text(
                            s['category'] as String,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ),
                        ...(s['items'] as List<String>).map((item) => Padding(
                              padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                              child: Row(
                                children: [
                                  Icon(Icons.circle, size: 6, color: color.withValues(alpha: 0.6)),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(item, style: const TextStyle(fontSize: 12)),
                                  ),
                                ],
                              ),
                            )),
                        const SizedBox(height: 6),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedBusiness() {
    final businesses = [
      {
        'title': '국내협력사업',
        'icon': Icons.handshake,
        'color': const Color(0xFF1A3A5C),
        'desc': '연구기관·학계 등 교류협력',
      },
      {
        'title': '국제협력사업',
        'icon': Icons.public,
        'color': const Color(0xFF2E86AB),
        'desc': '국제기구, 주요국 연구기관간의 교류협력(MOU 등)',
      },
      {
        'title': '정책토론·세미나',
        'icon': Icons.forum,
        'color': const Color(0xFF8E44AD),
        'desc': '문화정책 네트워크, 관광정책 네트워크, 콘텐츠산업포럼, 데이터·통계포럼 등',
      },
      {
        'title': '정기 간행물',
        'icon': Icons.menu_book,
        'color': const Color(0xFF27AE60),
        'desc': '문화정책논총(KCI등재지), 한국관광정책(계간), KCTI 인사이트 등',
      },
      {
        'title': '동향분석',
        'icon': Icons.trending_up,
        'color': const Color(0xFFE74C3C),
        'desc': '국제관광/관광산업 동향분석, 콘텐츠산업 동향 브리프, 데이터 동향분석 등',
      },
      {
        'title': '데이터분석사업',
        'icon': Icons.storage,
        'color': const Color(0xFFF39C12),
        'desc': '데이터 활용/분석, 통합운영, MAP구축, 행정자료 기반 동향, 공공데이터 운영',
      },
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: SectionCard(
        title: '연구 관련 사업',
        icon: Icons.work_outline,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: businesses.map((b) {
            final color = b['color'] as Color;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: color.withValues(alpha: 0.2)),
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
                    child: Icon(b['icon'] as IconData, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          b['title'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          b['desc'] as String,
                          style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.4),
                        ),
                      ],
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
}

class _StatBadge extends StatelessWidget {
  final String label;
  final int count;

  const _StatBadge({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count종',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A3A5C),
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.black54),
        ),
      ],
    );
  }
}
