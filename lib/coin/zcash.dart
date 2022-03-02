import 'coin.dart';

class ZcashCoin extends CoinBase {
  String app = "ZWallet";
  String symbol = "\u24E9";
  String currency = "zcash";
  String ticker = "ZEC";
  String dbName = "zec.db";
  String explorerUrl = "https://explorer.zcha.in/transactions/";
  List<LWInstance> lwd = [
    LWInstance("Lightwalletd", "https://mainnet.lightwalletd.com:9067"),
    LWInstance("Zecwallet", "https://lwdv3.zecwallet.co"),
  ];
  bool supportsUA = false;
  bool supportsMultisig = false;
  List<double> weights = [0.05, 0.25, 2.50];
}
