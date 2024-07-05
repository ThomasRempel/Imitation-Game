boolean stopRightArmMovement = false;
boolean startLeftArmMovement = false;
boolean stopLeftArmMovement = false;
boolean startRightLegMovement = false;
boolean stopRightLegMovement = false;
boolean startLeftLegMovement = false;
boolean stopLeftLegMovement = false;

int pontuacao = 0;
boolean angulosImpressos = false;
boolean pontosCalculados = false;

int tempoRestante = 20; // Tempo inicial de 30 segundos
int ultimoSegundo;

MainRobot mainRobot;
RandomRobot randomRobot;
TelaInicial telaInicial;
TelaFinal telaFinal;
boolean fimDeJogo = false;

void setup() {
  size(1024, 768);
  telaInicial = new TelaInicial("Thomas Rempel", "O Objetivo é deixar o seu robô o mais parecido com o exemplo. \n Para parar um dos membros basta apertar espaço. \n Tente chegar no 100 \n Boa Sorte !! ");
  telaFinal = new TelaFinal("A sua pontuação foi de: ");
  mainRobot = new MainRobot(768, 384); // Robô parado no lado direito
  randomRobot = new RandomRobot(256, 384); // Robô se movendo no lado esquerdo
  ultimoSegundo = second();
}

void draw() {
  if (telaInicial.telaInicial) {
    telaInicial.desenhar();
    telaInicial.verificarClique();
  } else if (fimDeJogo) {
    if (!pontosCalculados) {
      // Calcular a pontuação quando o jogo termina
      pontuacao += calcularPontos(mainRobot.rightArmAngle, randomRobot.armAngle1);
      pontuacao += calcularPontos(mainRobot.leftArmAngle, randomRobot.armAngle2);
      pontuacao += calcularPontos(mainRobot.rightLegAngle, randomRobot.legAngle1);
      pontuacao += calcularPontos(mainRobot.leftLegAngle, randomRobot.legAngle2);

      // Exibir a pontuação na tela final
      println("Pontuação final: " + pontuacao);

      pontosCalculados = true;
    }
    telaFinal.desenhar();
    fill(255);
    textSize(32);
    textAlign(CENTER);
    text("Pontuação: " + pontuacao, width / 2, height / 2 + 50); // Posiciona a pontuação
  } else if (telaInicial.jogando) {
    background(0);

    // Atualizar o cronômetro
    if (second() != ultimoSegundo) {
      ultimoSegundo = second();
      tempoRestante--;
      if (tempoRestante <= 0) {
        fimDeJogo = true; // Ativa a tela final quando o tempo acaba
      }
    }

    // Desenhar a linha branca no meio
    stroke(255); // Define a cor do contorno como branco
    strokeWeight(2); // Define a espessura da linha
    line(width / 2, 0, width / 2, height); // Desenha a linha no meio da tela

    // Desenhar o cronômetro
    fill(255);
    textSize(32);
    textAlign(CENTER);
    text("Tempo: " + tempoRestante, width / 2 + 200, 50); // Posiciona o cronômetro

    // Desenhar a pontuação
    text("Pontuação: " + pontuacao, width / 2 - 200, 50); // Posiciona a pontuação

    // Desenhar o robô parado na metade direita da tela
    mainRobot.display();

    // Desenhar o robô se movendo na metade esquerda da tela
    randomRobot.display();

    // Imprimir os ângulos atuais do RandomRobot uma vez
    if (!angulosImpressos) {
      println("Angulos atuais do RandomRobot:");
      println("Braço direito: " + randomRobot.armAngle1);
      println("Braço esquerdo: " + randomRobot.armAngle2);
      println("Perna direita: " + randomRobot.legAngle1);
      println("Perna esquerda: " + randomRobot.legAngle2);
      angulosImpressos = true;
    }
  }
}

void keyPressed() {
  // Verifica se a tecla pressionada é a tecla espaço (código 32)
  if (key == ' ') {
    if (!stopRightArmMovement && !startLeftArmMovement) {
      // Primeira tecla pressionada: para o braço direito e inicia o movimento do braço esquerdo
      stopRightArmMovement = true;
      startLeftArmMovement = true;
      // Calcular pontos para o braço direito
      pontuacao += calcularPontos(mainRobot.rightArmAngle, randomRobot.armAngle1);
    } else if (stopRightArmMovement && startLeftArmMovement && !stopLeftArmMovement) {
      // Segunda tecla pressionada: para o braço esquerdo e inicia o movimento da perna direita
      stopLeftArmMovement = true;
      startRightLegMovement = true;
      // Calcular pontos para o braço esquerdo
      pontuacao += calcularPontos(mainRobot.leftArmAngle, randomRobot.armAngle2);
    } else if (stopLeftArmMovement && startRightLegMovement && !stopRightLegMovement) {
      // Terceira tecla pressionada: para a perna direita e inicia o movimento da perna esquerda
      stopRightLegMovement = true;
      startLeftLegMovement = true;
      // Calcular pontos para a perna direita
      pontuacao += calcularPontos(mainRobot.rightLegAngle, randomRobot.legAngle1);
    } else if (stopRightLegMovement && startLeftLegMovement && !stopLeftLegMovement) {
      // Quarta tecla pressionada: para a perna esquerda e finaliza o movimento de todas as partes
      stopLeftLegMovement = true;
      fimDeJogo = true; // Ativa a tela final
      // Calcular pontos para a perna esquerda
      pontuacao += calcularPontos(mainRobot.leftLegAngle, randomRobot.legAngle2);
    }
  }
}

int calcularPontos(float angulo1, float angulo2) {
  float diferenca = abs(angulo1 - angulo2);

  if (diferenca < 0.05) {
    return 25; 
  } else if (diferenca < 0.1) {
    return 20; 
  } else if (diferenca < 0.3) {
    return 17; 
  } else if (diferenca < 0.5) {
    return 13; 
  } else if (diferenca < 0.65) {
    return 10; 
  } else if (diferenca < 0.80) {
    return 7; 
  } else if (diferenca < 1) {
    return 5; 
  } else if (diferenca < 2) {
    return 4;
  } else if (diferenca < 4) {
    return 3; 
  } else {
    return 1; 
  }
}
