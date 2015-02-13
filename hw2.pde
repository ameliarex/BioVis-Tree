//BCB 4002 
//Assignment 2 Tree of Life
//Tete Zhang

int[][] matrix = new int[101][101];
int[][] sequence = new int[3][2];
String[] nameList = new String[101];

void setup() {
  //basics
  size(600,600);
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
  }
  //int[][] sequence = {{1,3}, {2,4}, {102, 5}, {103, 6}, {7,8}};
  stroke(0);
  fill(50);
  for (int i = 0; i < 99; i++) {
    if (sequence[i][0]-101< 0){
      text(nameList[sequence[i][0]],0,(2*i)*15,50,15);
      text(nameList[sequence[i][1]],0,(2*i)*15+15,50,15);
      line(50,7.5+30*i,60+i*10,7.5+30*i);
      line(50,30*i+22.5,60+i*10,30*i+22.5);
      line(60+i*10,7.5+30*i,60+i*10,30*i+22.5);
    }
    else{
      int index = sequence[i][0]-101;
      int t = index - 1;
      text(nameList[sequence[i][1]],0,(2*i)*15,50,15);
      line(50+(index)*10,30*t+15, 
           60+(index+1)*10,30*t+15);
      line(50,7.5+30*(index+1),60+(index+1)*10,7.5+30*(index+1));
      line(60+(index+1)*10,30*t+15,
           60+(index+1)*10,7.5+30*(index+1));
    }
  }
}


void draw() {
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

