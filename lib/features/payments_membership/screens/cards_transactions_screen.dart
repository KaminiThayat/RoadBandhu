import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';

class CardsTransactionsScreen extends StatelessWidget {
  const CardsTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<_TxItem> transactions = [
      _TxItem(
        title: 'Payment - Towing Service',
        date: '20 Jan 2026, 04:32 PM',
        amount: '-₹1,800',
        isCredit: false,
        icon: Icons.local_shipping,
      ),
      _TxItem(
        title: 'Payment - Service Call',
        date: '12 Jan 2026, 11:20 AM',
        amount: '-₹450',
        isCredit: false,
        icon: Icons.build,
      ),
      _TxItem(
        title: 'Wallet Top-up (UPI)',
        date: '10 Jan 2026, 09:05 AM',
        amount: '+₹1,000',
        isCredit: true,
        icon: Icons.add_circle,
      ),
      _TxItem(
        title: 'Refund - Overcharge Reversal',
        date: '08 Jan 2026, 03:18 PM',
        amount: '+₹450',
        isCredit: true,
        icon: Icons.replay,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('cards_transactions'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saved Card Visual Container
            Container(
              width: double.infinity,
              height: 190,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF334155)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(50),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'VISA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Icon(Icons.contactless, color: Colors.white70, size: 24),
                    ],
                  ),
                  const Text(
                    '••••  ••••  ••••  4321',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CARD HOLDER',
                            style: TextStyle(color: Colors.white54, fontSize: 9, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'AMIT SHARMA',
                            style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Primary',
                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Add Card Link
            Center(
              child: TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Card vault setup: Enter card details.')),
                  );
                },
                icon: const Icon(Icons.add_card, size: 18, color: AppColors.primary),
                label: const Text(
                  '+ Add New Card',
                  style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Transaction History / लेन-देन इतिहास',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 12),

            // Transactions List
            ...transactions.map((tx) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: tx.isCredit ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        tx.icon,
                        color: tx.isCredit ? AppColors.success : AppColors.alertHigh,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tx.title,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : AppColors.lightTextPrimary,
                            ),
                          ),
                          Text(
                            tx.date,
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      tx.amount,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: tx.isCredit ? AppColors.success : AppColors.alertHigh,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _TxItem {
  final String title;
  final String date;
  final String amount;
  final bool isCredit;
  final IconData icon;

  _TxItem({
    required this.title,
    required this.date,
    required this.amount,
    required this.isCredit,
    required this.icon,
  });
}
