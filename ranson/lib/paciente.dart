class Paciente {
  String nome;
  int idade;
  int leucocitos;
  double glicemia;
  int astTgo;
  int ldh;
  bool litiaseBiliar;
  int escore;
  double mortalidade;

  Paciente({
    this.nome = '',
    this.idade = 0,
    this.leucocitos = 0,
    this.glicemia = 0.0,
    this.astTgo = 0,
    this.ldh = 0,
    this.litiaseBiliar = false,
    this.escore = 0,
    this.mortalidade = 0.0,
  });
}
