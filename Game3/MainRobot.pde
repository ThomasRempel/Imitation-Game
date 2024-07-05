class MainRobot {
  float x, y;
  float rightArmAngle = 0;
  float leftArmAngle = 0;
  float rightLegAngle = 0;
  float leftLegAngle = 0;

  MainRobot(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    pushMatrix();
    translate(x, y); // Transladar para a posição do robô

    // Corpo do robô
    stroke(0); // Define a cor do contorno como branco
    fill(255); // Cor de preenchimento
    rect(-80, -120, 160, 240);

    // Cabeça do robô
    ellipse(0, -160, 80, 80); // Adiciona um círculo como cabeça

    // Braço direito do robô
    pushMatrix();
    if (!stopRightArmMovement) { // Apenas incrementa o ângulo se stopRightArmMovement for falso
      rightArmAngle += 0.01;
    }
    translate(70, -100);
    rotate(rightArmAngle);
    rect(-10, -25, 120, 50);
    pushMatrix();
    translate(90, 0);
    rotate(PI / 6);
    rect(-10, -20, 120, 40);
    popMatrix();
    popMatrix();

    // Braço esquerdo do robô
    pushMatrix();
    if (startLeftArmMovement && !stopLeftArmMovement) { // Apenas incrementa o ângulo se startLeftArmMovement for verdadeiro e stopLeftArmMovement for falso
      leftArmAngle += 0.04;
    }
    translate(-70, -100);
    rotate(leftArmAngle);
    rect(-110, -25, 120, 50);
    pushMatrix();
    translate(-90, 0);
    rotate(-PI / 6);
    rect(-110, -20, 120, 40);
    popMatrix();
    popMatrix();

    // Perna direita do robô
    pushMatrix();
    if (startRightLegMovement && !stopRightLegMovement) { // Apenas incrementa o ângulo se startRightLegMovement for verdadeiro e stopRightLegMovement for falso
      rightLegAngle += 0.08;
    }
    translate(50, 120);
    rotate(rightLegAngle);
    rect(-10, 0, 50, 120);
    pushMatrix();
    translate(5, 100);
    rotate(-PI / 6);
    rect(-10, 0, 40, 120);
    popMatrix();
    popMatrix();

    // Perna esquerda do robô
    pushMatrix();
    if (startLeftLegMovement && !stopLeftLegMovement) { // Apenas incrementa o ângulo se startLeftLegMovement for verdadeiro e stopLeftLegMovement for falso
      leftLegAngle += 0.16;
    }
    translate(-50, 120);
    rotate(leftLegAngle);
    rect(-40, 0, 50, 120);
    pushMatrix();
    translate(5, 100);
    rotate(PI / 6);
    rect(-40, 0, 40, 120);
    popMatrix();
    popMatrix();

    popMatrix();
  }
}
