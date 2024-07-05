class RandomRobot {
  float x, y;
  float armAngle1, armAngle2;
  float legAngle1, legAngle2;

  RandomRobot(float x, float y) {
    this.x = x;
    this.y = y;
    this.armAngle1 = random(-PI / 4, PI / 4);
    this.armAngle2 = random(-PI / 4, PI / 4);
    this.legAngle1 = random(-PI / 4, PI / 4);
    this.legAngle2 = random(-PI / 4, PI / 4);
  }

  void display() {
    pushMatrix();
    translate(x, y); // Transladar para a posição do robô

    // Corpo do robô
    stroke(255); // Define a cor do contorno como branco
    fill(150); // Cor de preenchimento
    rect(-80, -120, 160, 240);

    // Cabeça do robô
    ellipse(0, -160, 80, 80); // Adiciona um círculo como cabeça

    // Braço direito do robô
    pushMatrix();
    translate(70, -100);
    rotate(armAngle1);
    rect(-10, -25, 120, 50);
    pushMatrix();
    translate(90, 0);
    rotate(PI / 6);
    rect(-10, -20, 120, 40);
    popMatrix();
    popMatrix();

    // Braço esquerdo do robô
    pushMatrix();
    translate(-70, -100);
    rotate(armAngle2);
    rect(-110, -25, 120, 50);
    pushMatrix();
    translate(-90, 0);
    rotate(-PI / 6);
    rect(-110, -20, 120, 40);
    popMatrix();
    popMatrix();

    // Perna direita do robô
    pushMatrix();
    translate(50, 120);
    rotate(legAngle1);
    rect(-10, 0, 50, 120);
    pushMatrix();
    translate(5, 100);
    rotate(-PI / 6);
    rect(-10, 0, 40, 120);
    popMatrix();
    popMatrix();

    // Perna esquerda do robô
    pushMatrix();
    translate(-50, 120);
    rotate(legAngle2);
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
