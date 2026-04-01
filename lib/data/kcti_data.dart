// KCTI 통계 데이터 모델 및 정적 데이터

class BudgetData {
  final String category;
  final List<double> values; // 2020~2026
  BudgetData(this.category, this.values);
}

class KctiData {
  // ─── 1. 예산 연도별 (2020~2026) ───
  static const List<String> budgetYears = ['2020', '2021', '2022', '2023', '2024', '2025', '2026'];

  static const Map<String, List<int>> budgetIncome = {
    '출연금': [10801, 12311, 12519, 12195, 12389, 12570, 12522],
    '자체수입': [14543, 12177, 12247, 13888, 13256, 14622, 15296],
    '전기이월금': [1170, 1385, 1827, 1297, 2598, 1473, 1282],
    '연구개발적립금': [0, 0, 0, 0, 177, 249, 433],
    '합계': [26603, 26095, 26688, 27742, 28724, 29098, 29596],
  };

  // 2026년 수입 비율
  static const List<Map<String, dynamic>> income2026 = [
    {'label': '출연금', 'value': 12522, 'ratio': 42.3, 'color': 0xFF1A3A5C},
    {'label': '자체수입', 'value': 15296, 'ratio': 51.7, 'color': 0xFF2E86AB},
    {'label': '전기이월금', 'value': 1282, 'ratio': 4.3, 'color': 0xFF57C5B6},
    {'label': '연구개발적립금', 'value': 496, 'ratio': 1.7, 'color': 0xFF9FD8CB},
  ];

  // 2026년 지출 예산
  static const List<Map<String, dynamic>> expense2026 = [
    {'label': '인건비', 'value': 11265, 'ratio': 38.0, 'color': 0xFF1A3A5C},
    {'label': '개별출연사업비', 'value': 7271, 'ratio': 24.6, 'color': 0xFF2E86AB},
    {'label': '수탁연구비', 'value': 4847, 'ratio': 16.4, 'color': 0xFF57C5B6},
    {'label': '연구사업비(일반)', 'value': 3003, 'ratio': 10.2, 'color': 0xFF9FD8CB},
    {'label': '경상비', 'value': 1914, 'ratio': 6.4, 'color': 0xFFB8E0D2},
    {'label': '예비비', 'value': 800, 'ratio': 2.7, 'color': 0xFFD6EFD8},
    {'label': '연구개발적립금', 'value': 496, 'ratio': 1.7, 'color': 0xFFE9F5E9},
  ];

  // 특정목적출연사업 (2026)
  static const List<Map<String, dynamic>> specialProjects = [
    {'no': 1, 'name': '관광통계개선사업', 'dept': '데이터전략실', 'budget': 3215000},
    {'no': 2, 'name': '외래관광객조사', 'dept': '데이터전략실', 'budget': 586000},
    {'no': 3, 'name': '걷기여행 환경영향지표 개발조사', 'dept': '데이터전략실', 'budget': 200000},
    {'no': 4, 'name': '관광숙박업 기초통계조사', 'dept': '데이터전략실', 'budget': 150000},
    {'no': 5, 'name': '관광개발정보시스템 운영', 'dept': '지역관광개발관리센터', 'budget': 500000},
    {'no': 6, 'name': '광역관광개발 성과관리 및 컨설팅', 'dept': '지역관광개발관리센터', 'budget': 920000},
    {'no': 7, 'name': '관광숙박 수급분석', 'dept': '관광산업연구실', 'budget': 150000},
    {'no': 8, 'name': '국제관광기구 의제 대응 및 발굴 연구', 'dept': '관광정책연구실', 'budget': 100000},
    {'no': 9, 'name': '문화영향평가', 'dept': '문화영향평가단', 'budget': 1450000},
  ];

  // ─── 2. 인사 ───
  static const Map<String, int> staffQuota = {
    '원장': 1, '연구직': 75, '통계직': 12, '행정직': 21, '운영직': 30, '기타': 3, '합계': 139,
  };
  static const Map<String, int> staffCurrent = {
    '원장': 0, '연구직': 69, '통계직': 12, '행정직': 21, '운영직': 26, '기타': 3, '합계': 128,
  };

  // 임금피크제
  static const List<Map<String, dynamic>> wagePeak = [
    {'year': 2024, 'count': 1, 'names': '윤소영(10.29.)'},
    {'year': 2025, 'count': 1, 'names': '채지영(7.31.)'},
    {'year': 2026, 'count': 3, 'names': '김면(1.23.), 이동헌(5.10.), 김규원(9.18.)'},
    {'year': 2027, 'count': 4, 'names': '이상열(7.21.), 류광훈(8.17.), 김영준(9.3.),조현성(9.29.)'},
    {'year': 2028, 'count': 2, 'names': '유지윤(9.5.), 서성원(10.27.)'},
    {'year': 2029, 'count': 2, 'names': '박근화(6.5.), 박상준(8.18.)'},
    {'year': 2030, 'count': 3, 'names': '김현주(4.17.), 허은영(5.21.), 전효재(12.1.)'},
    {'year': 2031, 'count': 4, 'names': '한영은(5.4.), 오훈성(7.22.), 노영순(8.15.), 김윤영(9.13.)'},
    {'year': 2032, 'count': 5, 'names': '장훈(2.23.), 박상곤(4.25.), 최자은(9.20.), 이윤경(10.6.), 박경열(11.15.)'},
  ];

  // 인사평정
  static const List<Map<String, dynamic>> staffRating = [
    {'year': 2022, 'g1': 4, 'g2': 18, 'g3': 64, 'g4': 9, 'g5': 4, 'total': 99},
    {'year': 2023, 'g1': 0, 'g2': 10, 'g3': 77, 'g4': 6, 'g5': 1, 'total': 94},
    {'year': 2024, 'g1': 3, 'g2': 10, 'g3': 83, 'g4': 6, 'g5': 0, 'total': 102},
    {'year': 2025, 'g1': 2, 'g2': 14, 'g3': 82, 'g4': 3, 'g5': 0, 'total': 101},
  ];

  // ─── 3. 시설 ───
  static const List<Map<String, dynamic>> facilityFloors = [
    {'floor': '1층', 'total': 118.28, 'exclusive': 64.45, 'common': 53.83, 'pyeong': 19.50},
    {'floor': '4층', 'total': 1251.92, 'exclusive': 682.17, 'common': 569.75, 'pyeong': 206.35},
    {'floor': '5층', 'total': 2553.39, 'exclusive': 1391.34, 'common': 1162.05, 'pyeong': 420.88},
    {'floor': '6층', 'total': 2488.47, 'exclusive': 1355.97, 'common': 1132.50, 'pyeong': 410.18},
    {'floor': '합계', 'total': 6412.06, 'exclusive': 3493.93, 'common': 2918.13, 'pyeong': 1056.91},
  ];

  // 청사 임차료 및 관리비
  static const List<Map<String, dynamic>> facilityFee = [
    {'year': '2020', 'rent': 196, 'maint': 477},
    {'year': '2021', 'rent': 196, 'maint': 479},
    {'year': '2022', 'rent': 184, 'maint': 495},
    {'year': '2023', 'rent': 175, 'maint': 502},
    {'year': '2024', 'rent': 175, 'maint': 520},
    {'year': '2025', 'rent': 171, 'maint': 566},
  ];

  // 계약 현황
  static const List<Map<String, dynamic>> contractStatus = [
    {'type': '수탁계약', 'count2023': 65, 'count2024': 69, 'count2025': 59,
     'amt2023': 7578, 'amt2024': 8577, 'amt2025': 7862},
    {'type': '위탁계약', 'count2023': 191, 'count2024': 176, 'count2025': 178,
     'amt2023': 8493, 'amt2024': 7733, 'amt2025': 8120},
  ];

  // ─── 4. 회계 ───
  static const List<Map<String, dynamic>> financialStatement = [
    {'year': '2021', 'currentAsset': 13429, 'nonCurrentAsset': 440, 'totalAsset': 13869,
     'currentLiab': 3571, 'nonCurrentLiab': 6780, 'totalLiab': 10351, 'capital': 512, 'other': 3006, 'totalEquity': 3518},
    {'year': '2022', 'currentAsset': 10665, 'nonCurrentAsset': 558, 'totalAsset': 11223,
     'currentLiab': 3487, 'nonCurrentLiab': 4678, 'totalLiab': 8165, 'capital': 512, 'other': 2546, 'totalEquity': 3058},
    {'year': '2023', 'currentAsset': 9861, 'nonCurrentAsset': 617, 'totalAsset': 10478,
     'currentLiab': 2552, 'nonCurrentLiab': 5192, 'totalLiab': 7744, 'capital': 512, 'other': 2223, 'totalEquity': 2735},
    {'year': '2024', 'currentAsset': 12388, 'nonCurrentAsset': 589, 'totalAsset': 12977,
     'currentLiab': 3388, 'nonCurrentLiab': 5759, 'totalLiab': 9147, 'capital': 512, 'other': 3318, 'totalEquity': 3830},
    {'year': '2025(안)', 'currentAsset': 14292, 'nonCurrentAsset': 448, 'totalAsset': 14740,
     'currentLiab': 4191, 'nonCurrentLiab': 6172, 'totalLiab': 10363, 'capital': 512, 'other': 3865, 'totalEquity': 4377},
  ];

  // ─── 5. 연구사업 ───
  static const List<Map<String, dynamic>> researchCount = [
    {'type': '기초연구', 'y2023': 6, 'y2024': 6, 'y2025': 6},
    {'type': '정책연구', 'y2023': 24, 'y2024': 24, 'y2025': 24},
    {'type': '수시연구', 'y2023': 8, 'y2024': 9, 'y2025': 9},
    {'type': '현안연구', 'y2023': 6, 'y2024': 5, 'y2025': 10},
    {'type': '정책리포트', 'y2023': 2, 'y2024': 10, 'y2025': 7},
    {'type': '특별연구', 'y2023': 0, 'y2024': 0, 'y2025': 1},
    {'type': '정책연구사업', 'y2023': 2, 'y2024': 2, 'y2025': 2},
    {'type': '기본연구 소계', 'y2023': 48, 'y2024': 56, 'y2025': 59},
    {'type': '계약연구사업', 'y2023': 65, 'y2024': 69, 'y2025': 59},
    {'type': '출연금사업', 'y2023': 10, 'y2024': 10, 'y2025': 11},
    {'type': '총계', 'y2023': 123, 'y2024': 135, 'y2025': 129},
  ];

  // 통계 목록
  static const List<Map<String, dynamic>> statistics = [
    {'category': '공통(1)', 'items': ['문화체육관광 일자리 현황조사']},
    {'category': '문화(3)', 'items': ['국민문화활동조사', '국민여가활동조사', '근로자휴가조사']},
    {'category': '관광(4)', 'items': ['주요관광지점입장객통계', '관광사업체조사', '국민여행조사', '외래관광객조사']},
    {'category': '연구원 승인(1)', 'items': ['문화체육관광산업통계']},
  ];

  // 기초·정책연구 목록 (2026년)
  static const List<Map<String, dynamic>> researchProjects = [
    {'no': 1, 'type': '기초', 'field': '문화', 'title': '국제사회 의제 기반 문화정책의 중장기 발전 방향 모색', 'researcher': '이성우(김면, 백보현)'},
    {'no': 2, 'type': '정책', 'field': '문화', 'title': '문화권 지표 개발 및 활용방안 연구', 'researcher': '장훈, 이슬기'},
    {'no': 3, 'type': '정책', 'field': '문화', 'title': '문화치유정책 활성화를 위한 전문인력 기반 구축 연구', 'researcher': '윤지연'},
    {'no': 4, 'type': '정책', 'field': '문화', 'title': '공연예술 분야 표준계약서 활용현황 및 개선방안 연구', 'researcher': '황아람, 허은영'},
    {'no': 5, 'type': '정책', 'field': '문화', 'title': '문화정책 관점에서의 지역균형발전의 의미와 추진전략', 'researcher': '김홍규(김규원)'},
    {'no': 6, 'type': '정책', 'field': '문화', 'title': '박물관·미술관 정책구조의 재편방안 연구: 중앙-지방 정책기능 재분배를 중심으로', 'researcher': '김혜인'},
    {'no': 7, 'type': '기초', 'field': '문화', 'title': '환경변화에 대응한 문화분야 전문인력 양성 방향', 'researcher': '박종웅(조현성)'},
    {'no': 8, 'type': '정책', 'field': '문화', 'title': '문화참여의 웰빙․건강 가치 측정과 정책활용방안', 'researcher': '변지혜, 이정희'},
    {'no': 9, 'type': '정책', 'field': '문화', 'title': '문화예술진흥기금 운영관리 개선방안 연구', 'researcher': '김윤경'},
    {'no': 10, 'type': '정책', 'field': '문화', 'title': '지역공연예술 창·제작 생태계 지원 개선방안 연구', 'researcher': '이경진(심성민)'},
    {'no': 11, 'type': '정책', 'field': '문화', 'title': '공공도서관의 친환경·탄소중립 기반 재생 방향에 관한 정책 연구', 'researcher': '김현주, 안희자, 강지수'},
    {'no': 12, 'type': '기초', 'field': '관광', 'title': '인구구조 변화와 기술혁신에 따른 관광노동시장 분석 및 대응방안', 'researcher': '김동현, 강지수'},
    {'no': 13, 'type': '정책', 'field': '관광', 'title': '방한 외래관광객 유입의 지역 경제 효과 분석', 'researcher': '조아라, 이성빈'},
    {'no': 14, 'type': '정책', 'field': '관광', 'title': '일본의 인바운드 관광 정책 심층 분석', 'researcher': '김형종, 류광훈'},
    {'no': 15, 'type': '정책', 'field': '관광', 'title': '항공 접근성 변화가 지역 인바운드 관광수요에 미치는 영향', 'researcher': '이원희, 김진영'},
    {'no': 16, 'type': '정책', 'field': '관광', 'title': 'K-뷰티 관광 현황 및 정책 추진 방안', 'researcher': '최경은, 김형종'},
    {'no': 17, 'type': '정책', 'field': '관광', 'title': '방한 중국관광시장 분석 및 정책방향', 'researcher': '유지윤, 정광민, 손신욱'},
    {'no': 18, 'type': '기초', 'field': '관광', 'title': '인공지능(AI) 시대 관광산업 생태계 변화와 대응 방안 연구', 'researcher': '류광훈, 정광민'},
    {'no': 19, 'type': '정책', 'field': '관광', 'title': '국내 카지노산업 특성 분석과 성장을 위한 정책과제', 'researcher': '김영준, 김성윤'},
    {'no': 20, 'type': '정책', 'field': '관광', 'title': '지역 간 연계 협력 관광사업 실태와 활성화 방안', 'researcher': '전효재, 송수엽'},
    {'no': 21, 'type': '정책', 'field': '관광', 'title': '신관광산업의 동향과 정책 대응 방안', 'researcher': '김윤영'},
    {'no': 22, 'type': '정책', 'field': '관광', 'title': '지역관광산업 활성화를 위한 관광기념품 육성 방안', 'researcher': '윤주, 강현수'},
    {'no': 23, 'type': '정책', 'field': '관광', 'title': '5극3특 국가균형성장전략과 초광역권 관광정책방향', 'researcher': '진보라, 박주영'},
    {'no': 24, 'type': '정책', 'field': '관광', 'title': '관광단지 민간투자 활성화를 위한 정책방안', 'researcher': '양지훈'},
    {'no': 25, 'type': '기초', 'field': '콘텐츠', 'title': '한류 트렌드 분석과 전망', 'researcher': '박찬욱, 김예솔'},
    {'no': 26, 'type': '정책', 'field': '콘텐츠', 'title': '애니메이션 기획개발 지원 고도화 방안 연구', 'researcher': '홍무궁'},
    {'no': 27, 'type': '정책', 'field': '콘텐츠', 'title': '콘텐츠 정책펀드 구조 개선방안 연구', 'researcher': '이승희'},
    {'no': 28, 'type': '정책', 'field': '콘텐츠', 'title': 'K-콘텐츠 주도형 글로벌 신흥시장 진출 방안 연구', 'researcher': '전진영, 김정림(오서경)'},
    {'no': 29, 'type': '기초', 'field': '데이터', 'title': '문화·관광 조사통계의 합성데이터 생산 방안 연구', 'researcher': '이상규, 강용수(김수경)'},
    {'no': 30, 'type': '정책', 'field': '데이터', 'title': '문화·관광·콘텐츠 AI-Ready 데이터 개방·활용을 위한 정책 연구', 'researcher': ''},
  ];
}
