import java.util.Collections;

public class percorso{
  ArrayList<PVector> path = new ArrayList<PVector>();
  float fitness;
  int lunghezzapercorso;
  
  percorso(){
    for(int i=0; i<punti.length; i++){
      path.add(new PVector(punti[i].x, punti[i].y));
    }
    randomizza();
  }
  
  private void randomizza(){
    ArrayList<int[]> p2 = new ArrayList<int[]>();
    for(PVector pv : path){
      int[] array = {(int)pv.x,(int)pv.y};
      p2.add(array);
    }
    Collections.shuffle(p2);
    for(int i=0; i<path.size(); i++){
      PVector pv = new PVector(p2.get(i)[0],p2.get(i)[1]);
      path.set(i,pv);
    }
  }
  
  public void show(boolean b){
    int x=0;
    if(b){
      strokeWeight(4);
      stroke(255,0,0,100);
    } else {
      strokeWeight(1);
      stroke(0,255);
    }
    pushMatrix();
    beginShape();
    fill(255);
    for(PVector pv : path){
      if(b) text(x,pv.x+15,pv.y+15);
      vertex(pv.x,pv.y);
      x++;
    }
    noFill();
    endShape();
    popMatrix();
  }
  
  public void calcolaFitness(){
    int somma=0;
    for(int i=0; i<path.size()-1; i++){
      somma += dist(path.get(i).x, path.get(i).y, path.get(i+1).x, path.get(i+1).y);
    }
    lunghezzapercorso = somma;
    fitness=(1.0/somma)*8000;
    fitness=pow(fitness,4);
  }
  
  public void muta(){
    for(int i=0; i<path.size();i++){
      if(random(1)<mutationRate){
        inverti(path,i,(int)random(0,path.size()));
      }
    }
  }
  
  public percorso combinaCon(percorso p){
    percorso figlio = new percorso();
    //Resetto il figlio
    figlio.path.clear();
    //Scelgo quanti valori copiare
    int valoriDaCopiare = (int)random(path.size()/2);
    //Scelgo un intervallo dal quale estrarre questi N valori
    int indiceInizialeCopiare = (int)random(0,path.size()-valoriDaCopiare);
    //Copio questi valori
    for(int i=indiceInizialeCopiare; i<indiceInizialeCopiare+valoriDaCopiare; i++){
      figlio.path.add(path.get(i));
    }
    //Copio i valori restanti
    for(int i=0; i<path.size();i++){
      if(!figlio.path.contains(path.get(i))){
        figlio.path.add(path.get(i));
      }
    }
    return figlio;
  }
  
  private void inverti(ArrayList<PVector> array, int index1, int index2){
    PVector momentaneo = array.get(index1);
    array.set(index1,array.get(index2));
    array.set(index2,momentaneo);
  }
}