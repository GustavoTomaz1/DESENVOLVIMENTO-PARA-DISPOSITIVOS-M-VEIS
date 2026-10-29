import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: JogoMultiplicacao()));

class JogoMultiplicacao extends StatefulWidget {
  const JogoMultiplicacao({super.key});

  @override
  State<JogoMultiplicacao> createState() => _JogoMultiplicacaoState();
}

class _JogoMultiplicacaoState extends State<JogoMultiplicacao> {
  final TextEditingController _respostaController = TextEditingController();

  int _fator = 2;
  int _multiplicador = 1;

  void _verificarResposta() {
    int? resposta = int.tryParse(_respostaController.text);

    if (resposta == _fator * _multiplicador) {
      setState(() {
        if (_multiplicador < 10) {
          _multiplicador++;
        } else {
          _fator++;
          _multiplicador = 1;
        }
        _respostaController.clear();
      });
    } else {
      int fatorAntigo = _fator;
      int multiplicadorAntigo = _multiplicador;

      setState(() {
        _fator++;
        _multiplicador = 1;
        _respostaController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              const Text('Errou, clique aqui para voltar ao fator antigo.'),
          action: SnackBarAction(
            label: 'Voltar',
            onPressed: () {
              setState(() {
                _fator = fatorAntigo;
                _multiplicador = multiplicadorAntigo;
              });
            },
          ),
        ),
      );
    }
  }

  Widget _buildBotoes(List<String> valores) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: valores.map((valor) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(70, 70),
            ),
            onPressed: () {
              if (valor == 'C') {
                setState(() => _respostaController.clear());
              } else if (valor == 'OK') {
                _verificarResposta();
              } else {
                setState(() => _respostaController.text += valor);
              }
            },
            child: Text(valor, style: const TextStyle(fontSize: 24)),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double progresso = _multiplicador / 10.0;

    return Scaffold(
      appBar: AppBar(title: const Text('Sequência de Multiplicação')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              value: progresso,
              color: Color.fromARGB(255, 230, 15, 7),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 30),
            Text(
              'Quanto é $_fator x $_multiplicador?',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _respostaController,
              readOnly: true,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            _buildBotoes(['1', '2', '3']),
            _buildBotoes(['4', '5', '6']),
            _buildBotoes(['7', '8', '9']),
            _buildBotoes(['C', '0', 'OK']),
          ],
        ),
      ),
    );
  }
}
