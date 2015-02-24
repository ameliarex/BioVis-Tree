//BCB 4002
//A2: Tree of Life
//Tete Zhang

//animals' name and attributes read from the file
class Animal{
  String name;
  int[] attr;
  
  Animal(String n, int[] a){
    name = n;
    attr = a;
  }
}

//calculate the distance between two Animals and/or two clusters
int aDistance(Animal a, Animal b){
  int counter = 0;
  for(int i = 0; i<16; i++){
    if (a.attr[i] != b.attr[i]){
      counter++;
    }
  }
    return counter;
}

//list of animals as tree nodes
class Cluster{
  Animal[] node;
  int level;
}

int cDistance(Cluster a, Cluster b){
  int accu = 0;
  for(int i=0; i<a.node.length; i++){
    for(int j=0; j<b.node.length; j++) {
      accu = accu + aDistance(a.node[i], b.node[j]);
    }
  }
  accu = accu/(a.node.length * b.node.length);
  return accu;
}  

Cluster[] list = new Cluster[101];
Cluster merge(Cluster a, Cluster b, int l, int h){

  if (a.node.length == 1 && b.node.length == 1){
    textSize(10);
    text(a.node[0].name, 0, 5*h);
    textSize(10);
    text(b.node[0].name, 0,5*(h+3));
  }
  if (a.node.length == 1 && b.node.length > 1){
    textSize(10);
    text(a.node[0].name, 0,5*h);
  }
  if (b.node.length == 1 && a.node.length > 1){
    textSize(10);
    text(b.node[0].name, 0,5*h);
  }
  else{
  }
  Cluster c = new Cluster();
  for (int i=0; i<b.node.length; i++) {
    a.node = (Animal[])append(a.node, b.node[i]);
  }
  c.node = a.node;
  c.level = l+1;
  return c;
}

void setup() {
  //basics
  size(1200,1200);
  background(230,230,250);
  stroke(0,0,0);
  
  //Read from zoo.data file and create animal/cluster objects
  //Cluster[] list = new Cluster[101];
  String[] data = loadStrings("zoo.data");
  for (int i=0; i<data.length; i++){
    String[] temp = split(data[i],",");
    int[] temp2 = new int[16];
    for (int j=0; j<16; j++){     
      temp2[j] = int(temp[j+1]);
    }
    Cluster c = new Cluster();
    c.node = new Animal[1];
    c.node[0] = new Animal(temp[0], temp2);
    c.level = 1;
    list[i] = c;
  }
  
  int countlevel = 1;
  int textPos = 1;
  float min = cDistance(list[0], list[1]);
  int x=0;
  int y=1;
  // clustering
  for(int k=0; k<98; k++) {
//    println(list.length);
    Cluster[] list2 = new Cluster[0];
    //find minimum distance
    
    for (int i=0;i<list.length;i++){
      for(int j=0;j<list.length;j++){
        if (i != j && min>cDistance(list[i],list[j])){
          min = cDistance(list[i],list[j]);
          x=i;
          y=j;
          println(min);
//          println(x);
//          println(y);
        }
      }
    }
    //println(min);
    if(list[x].node.length ==1 || list[y].node.length ==1){
         textPos = textPos + 3;
       }
    list2 = (Cluster[])append(list2, merge(list[x], list[y], countlevel, textPos)); 
  
    countlevel++;
    for (int a = 0; a<list.length; a++) {
      if (a != x && a != y){
        list2 = (Cluster[])append(list2,list[a]);
      }
    }
    list = list2;
  }
  
  //draw the tree
//  stroke(0);
//  fill(50);
//  for (int i=0; i<list.length; i++){
//    if (list[i].level == 1) {
//      text(list[i].node[0].name, 50,5);
//      text(list[i+1).node[0].name, 50, 5);
//      textSize(5);
//      line(
//  }
}

void draw() {
  
}

