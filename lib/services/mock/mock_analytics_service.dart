class CategoryStat {
  final String name;
  final int donated;
  final int distributed;
  final String colorHex;

  const CategoryStat({
    required this.name,
    required this.donated,
    required this.distributed,
    required this.colorHex,
  });

  double get fulfillmentRate => donated == 0 ? 0 : distributed / donated;
}

class MockAnalyticsService {
  Future<Map<String, dynamic>> getAnalyticsOverview() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return {
      'totalDonated': 14250,
      'totalDistributed': 12100,
      'activeVolunteers': 840,
      'beneficiaries': 45200,
      'categoryStats': const [
        CategoryStat(name: 'Food & Water', donated: 8500, distributed: 7800, colorHex: '0xFFD97B3F'), // Accent
        CategoryStat(name: 'Medical Supplies', donated: 1200, distributed: 1100, colorHex: '0xFFB25444'), // Critical
        CategoryStat(name: 'Clothing', donated: 3100, distributed: 2200, colorHex: '0xFFA9754F'), // Secondary
        CategoryStat(name: 'Essentials (Blankets, etc.)', donated: 1450, distributed: 1000, colorHex: '0xFF7A8B5E'), // Success
      ],
      'weeklyTrend': const [120, 350, 420, 290, 580, 810, 640], // Last 7 days donations
    };
  }
}
