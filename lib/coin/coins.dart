import 'coin.dart';
import 'ycash.dart';
import 'zcash.dart';

CoinBase ycash = YcashCoin();
CoinBase zcash = ZcashCoin();

CoinBase getCoin(int coin) {
  if (coin == 1)
    return ycash;
  return zcash;
}
