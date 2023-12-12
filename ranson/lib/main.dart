import 'package:flutter/material.dart';
import 'paciente.dart';
import 'tela_exames.dart';
import 'db.dart';
import 'card.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Ranson',
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  Paciente paciente = Paciente();
  Dados dados = Dados();

  void calculateMortalityScore() {
    setState(() {
      int score = calculateEscore();
      paciente.escore = score;
      paciente.mortalidade = calculateMortality(score);
    });
  }

  int calculateEscore() {
    int score = 0;
    if (paciente.litiaseBiliar) {
      score += checkParameter(paciente.idade, dados.idadeLitiase);
      score += checkParameter(paciente.leucocitos, dados.leucocitosLitiase);
      score += checkParameter(paciente.glicemia, dados.glicemiaLitiase);
      score += checkParameter(paciente.astTgo, dados.astTgoLimite);
      score += checkParameter(paciente.ldh, dados.ldhLitiase);
    } else {
      score += checkParameter(paciente.idade, dados.idadeSemLitiase);
      score += checkParameter(paciente.leucocitos, dados.leucocitosSemLitiase);
      score += checkParameter(paciente.glicemia, dados.glicemiaSemLitiase);
      score += checkParameter(paciente.astTgo, dados.astTgoLimite);
      score += checkParameter(paciente.ldh, dados.ldhSemLitiase);
    }
    return score;
  }

  int checkParameter(num valorPaciente, num limite) {
    return valorPaciente > limite ? 1 : 0;
  }

  double calculateMortality(int score) {
    if (score < 3) {
      return 2.0;
    } else if (score < 5) {
      return 15.0;
    } else if (score < 7) {
      return 40.0;
    } else {
      return 100.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Novo Paciente')),
        backgroundColor: const Color.fromARGB(255, 198, 206, 205),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo não pode está vazio';
                  }
                  return null;
                },
                onSaved: (value) => paciente.nome = value as String,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Idade'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (int.tryParse(value!) == null) {
                    return 'Por favor, isira um numero inteiro';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    paciente.idade = int.tryParse(value) ?? 0;
                  }
                },
                onChanged: (value) {
                  paciente.idade = int.tryParse(value) ?? 0;
                  calculateMortalityScore();
                },
              ),
              Row(
                children: [
                  Checkbox(
                    value: paciente.litiaseBiliar,
                    onChanged: (bool? value) {
                      setState(() {
                        paciente.litiaseBiliar = value ?? false;
                        calculateMortalityScore();
                      });
                    },
                  ),
                  const Text('Litíase Biliar?'),
                ],
              ),
              Row(
                
                children: <Widget>[
                  const Expanded(

                    child: Text('Leucócitos', style: TextStyle(fontSize: 10)),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (int.tryParse(value!) == null) {
                          return 'Por favor, insira um numero inteiro';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null && value.isNotEmpty) {
                          paciente.idade = int.tryParse(value) ?? 0;
                        }
                      },
                      onChanged: (value) {
                        paciente.leucocitos = int.tryParse(value) ?? 0;
                        calculateMortalityScore();
                      },
                    ),
                  ),
                  const Expanded(

                    child: Text('cél./mm3'),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Expanded(

                    child: Text('Glicemia', style: TextStyle(fontSize: 10)),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (int.tryParse(value!) == null) {
                          return 'Por favor, insira um numero inteiro';
                        }
                        return null;
                      },
                      onSaved: (value) => paciente.glicemia =
                          double.tryParse(value ?? '0') ?? 0.0,
                      onChanged: (value) {
                        paciente.glicemia = double.tryParse(value) ?? 0.0;
                        calculateMortalityScore();
                      },
                    ),
                  ),
                  const Expanded(

                    child: Text('mmol/L')),
                ],
              ),
              Row(
                children: <Widget>[
                  const Expanded(

                    child: Text('AST/TGO', style: TextStyle(fontSize: 10)),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (int.tryParse(value!) == null) {
                          return 'Por favor, insira um numero inteiro';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        paciente.astTgo = int.tryParse(value) ?? 0;
                        calculateMortalityScore();
                      },
                    ),
                  ),
                  const Expanded(
                    
                    child: Text('UI/L'),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Expanded(

                    child: Text('LDH', style: TextStyle(fontSize: 10)),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (int.tryParse(value!) == null) {
                          return 'Por favor, isira um numero inteiro';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null && value.isNotEmpty) {
                          paciente.ldh = int.parse(value);
                        }
                      },
                      onChanged: (value) {
                        paciente.ldh = int.tryParse(value) ?? 0;
                        calculateMortalityScore();
                      },
                    ),
                  ),
                  const Expanded(

                    child: Text('UI/L'),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey[300],
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 0,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExamScreen(paciente: paciente),
                      ),
                    );
                  }
                },
                child: const Text('ADICIONAR PACIENTE'),
              ),
              CustomCard(
                title: 'Pontuação',
                value: '${paciente.escore}', // Substitua com o valor real
                icon: Icons.score,
              ),
              CustomCard(
                title: 'Mortalidade',
                value: '${paciente.mortalidade}%', // Substitua com o valor real
                icon: Icons.sentiment_dissatisfied,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
