import 'package:any_base/any_base.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }

  String binToDec(String num) {
    var bin2dec = AnyBase(AnyBase.bin, AnyBase.dec);

    String numDec = bin2dec.convert(num);
    return numDec;
  }

  String decToBin(String num) {
    var dec2bin = AnyBase(AnyBase.dec, AnyBase.bin);

    String numbin = dec2bin.convert(num);
    return numbin;
  }

  String completaZerosEsquerda(String numBin) {
    String zeros = '';
    if (numBin.length < 8) {
      for (int i = 0; i < 8 - numBin.length; i++) {
        zeros = '0' + zeros;
      }
      return zeros + numBin;
    }
    else return numBin;
  }

  String calcula(String num1, String num2, String operacao) {
    int resultInt;
    switch (operacao) {
      case '+':
        {
          resultInt = int.parse(num1) + int.parse(num2);
          return completaZerosEsquerda(decToBin(resultInt.toString()));
        }
        break;

      case '-':
        {
          resultInt = int.parse(num1) - int.parse(num2);
          return completaZerosEsquerda(decToBin(resultInt.toString()));
        }
        break;

      case '*':
        {
          resultInt = int.parse(num1) * int.parse(num2);
          return completaZerosEsquerda(decToBin(resultInt.toString()));
        }
        break;
      case '/':
        {
          double resultInt = int.parse(num1) / int.parse(num2);
          return  completaZerosEsquerda(decToBin( resultInt.floor().toString()));
        }
        break;
      case '%':
        {
          resultInt = (int.parse(num1) % int.parse(num2)).round();
          return completaZerosEsquerda(decToBin(resultInt.toString()));
        }
        break;

      default:
        {
          print("Operação inválida");
          return "Operação Inválida";
        }
        break;
    }
  }
}
