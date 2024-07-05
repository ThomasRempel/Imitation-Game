class TelaFinal {
  String mensagem;

  TelaFinal(String mensagem) {
    this.mensagem = mensagem;
  }

  void desenhar() {
    background(0);
    textAlign(CENTER);
    textSize(32);
    fill(255);
    text(mensagem, width / 2, height / 2);
  }
}
