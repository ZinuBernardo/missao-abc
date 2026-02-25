import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SubscriptionStatus { free, premium, family }

class BillingService extends StateNotifier<SubscriptionStatus> {
  BillingService() : super(SubscriptionStatus.free);

  // Simula a verificação na Play Store / App Store
  Future<void> checkSubscription() async {
    // mock logic
    await Future.delayed(const Duration(seconds: 1));
    state = SubscriptionStatus.free; 
  }

  Future<bool> purchasePremium() async {
    // Integração real com in_app_purchase entraria aqui
    await Future.delayed(const Duration(seconds: 2));
    state = SubscriptionStatus.premium;
    return true;
  }
}

final billingProvider = StateNotifierProvider<BillingService, SubscriptionStatus>((ref) {
  return BillingService();
});
