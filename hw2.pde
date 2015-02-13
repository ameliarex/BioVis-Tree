//BCB 4002 
//Assignment 2 Tree of Life
//Tete Zhang

int[][] matrix = new int[101][101];
int[][] sequence = new int[99][2];
String[] nameList = new String[101];
void setup() {
  //basics
  size(300,300);
  frameRate(3);
  background(230,230,250);
  
  //Read from the zoo.data file and create leaf Objects
  String[] data = loadStrings("zoo.data");
  for (int i = 0; i<data.length; i++){
    String[] temp = split(data[i], ",");
    nameList[i] = temp[0];
  }

  
  for (int i =0; i<data.length; i++){
    String[] list = split(data[i], ",");
    for (int j = 0; j<data.length; j++) {
      String[] list2 = split(data[j], ",");
      int counter = 0;
      if (i != j) {
        for (int k = 1; k<17; k++) {
          if (list[k] != list2[k]) {
            counter++;
          }
        }
        matrix[i][j]= counter;
      }
    }
  }
  
  //start recursive
  for (int z = 0; z<99; z++) {
    int[] cross = findMin();
    println(cross);
    sequence[z] = cross;

    int[] plus = new int[101];
    for (int a = 0; a<101; a++) {
      if (matrix[cross[0]][a]>=0 && matrix[cross[1]][a]>=0){
        plus[a] = (matrix[cross[0]][a] + matrix[cross[1]][a])/2;
      }
    }
    int[][] matrixplus = (int[][])append(matrix, plus);
    for (int a =0; a<101; a++) {
     matrix[cross[0]][a] = -1; 
     matrix[cross[1]][a] = -1;
     matrix[a][cross[0]] = -1;
     matrix[a][cross[1]] = -1;
    }
    println(sequence[z]);
  }
}


void draw() {
  stroke(0);
  fill(50);
  //translate (0,height);
  //rotate(PI/2);
  text(nameList[sequence[49][0]],0,0,60,60);
  text(nameList[sequence[49][1]],0,60,60,60);
}

int[] findMin(){
  int min = 100; 
  int[] cross = {0,1};
  for(int i = 0; i<matrix.length; i++){
      for (int j = 0; j<101; j++){
        if (i != j && matrix[i][j]>=0 && matrix[i][j] < min) {
          min = matrix[i][j];
          cross[0] = i;
          cross[1] = j;
        }
      }
    }
    return cross;
}

