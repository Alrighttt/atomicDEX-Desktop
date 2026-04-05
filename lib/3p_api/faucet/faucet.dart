import 'package:web_dex/3p_api/faucet/faucet_response.dart';

Future<FaucetResponse> callFaucet(String coin, String address) async {
  // Faucet endpoint disabled
  return FaucetResponse.error('Faucet not available');
}
