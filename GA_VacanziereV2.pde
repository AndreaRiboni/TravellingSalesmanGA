public PVector[] punti = new PVector[10];
float mutationRate = 0.01;
percorso[] popolazione = new percorso[200];
float max=0;
int index=0;
percorso BEST_ONE;

void setup(){
  size(500,500);
  for(int i=0; i<punti.length; i++){
    punti[i] = new PVector((int)random(width),(int)random(height));
  }
  for(int i=0; i<popolazione.length; i++){
    popolazione[i] = new percorso();
  }
}

void draw(){
  
  //noLoop();
  
  
  background(42);
  //fitness
  float max2=0;
  for(int i=0; i<popolazione.length; i++){
    popolazione[i].calcolaFitness();
    if(popolazione[i].fitness>max2){
      max2 = popolazione[i].fitness;
      index = i;
    }
    if(popolazione[i].fitness>max){
      max = popolazione[i].fitness;
      BEST_ONE = popolazione[i];
      println("Lunghezza migliore: "+BEST_ONE.lunghezzapercorso);
    }
  }
  popolazione[index].show(false);
  BEST_ONE.show(true);
  disegnaPunti();
  
  //Riproduzione
  for(int i=0; i<popolazione.length; i++){
    percorso p1 = MatingPool();
    percorso p2 = MatingPool();
    percorso figlio = p1.combinaCon(p2);
    figlio.muta();
    popolazione[i]=figlio;
  }
}

private void disegnaPunti(){
  fill(255);
  stroke(0);
  strokeWeight(2);
  for(PVector pv : punti){
    ellipse(pv.x,pv.y,20,20);
  }
  noFill();
}

private percorso MatingPool(){
  int somma = 0;        //calcolo la somma di tutti i fitness
  for(percorso d : popolazione){
    somma+=d.fitness;
  }
  int Punto = (int)random(somma);  //genero un punto
  somma = 0;
  for(int i=0; i<popolazione.length; i++){
    somma+=popolazione[i].fitness;
    if(Punto<=somma){
      return popolazione[i];
    }
  }
  return MatingPool(); //in caso di errore di calcolo, rieseguo il metodo
}