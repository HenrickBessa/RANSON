import 'package:flutter/material.dart';
import 'paciente.dart';
import 'card.dart';
class TelaDeExames extends StatelessWidget {
  final Paciente paciente;

  const TelaDeExames({Key? key, required this.paciente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child:  Text('Exames do Paciente')),
        backgroundColor: const Color.fromARGB(255, 201, 209, 208),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            CustomCard(title: 'Nome', value: paciente.nome, icon: Icons.person),
            CustomCard(title: 'Idade',value: '${paciente.idade} anos', icon: Icons.cake),
            CustomCard(title: 'Leucócitos', value: '${paciente.leucocitos} células/mm3',icon: Icons.bloodtype),
            CustomCard(title: 'Glicemia', value: '${paciente.glicemia} mmol/L', icon: Icons.monitor_heart),
            CustomCard(title: 'AST/TGO', value: '${paciente.astTgo} UI/L', icon: Icons.health_and_safety),
            CustomCard(title: 'LDH', value: '${paciente.ldh} UI/L', icon: Icons.health_and_safety),
            CustomCard(title: 'Litíase Biliar', value: paciente.litiaseBiliar ? "Sim" : "Não", icon: Icons.check_circle),
            CustomCard(title: 'Escore', value: '${paciente.escore}', icon: Icons.score),
            CustomCard(title: 'Mortalidade', value: '${paciente.mortalidade}%',icon: Icons.sentiment_dissatisfied),
          ],
        ),
      ),
    );
  }
}