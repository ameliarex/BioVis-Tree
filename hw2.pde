//BCB 4002 
//Assignment 2 Tree of Life
//Tete Zhang

int[][] matrix = new int[101][101];
int[][] sequence = new int[99][2];
String[] nameList = new String[101];

void setup() {
  //basics
  size(1200,1000);
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
          if (!list[k].equals(list2[k])) {
            counter++;
          }
        }
        matrix[i][j]= counter;
      }
      else {
      matrix[i][j]= -1;
      }
    }
  }
  
  //start recursive
  for (int z = 0; z<99; z++) {
    int[] cross = findMin();
    sequence[z] = cross;

    int[] plus = new int[101];
    for (int d = 0; d<101; d++) {
      if (matrix[cross[0]][d]>=0 && matrix[cross[1]][d]>=0){
        plus[d] = (matrix[cross[0]][d] + matrix[cross[1]][d])/2;
      }
      else {
        plus[d] = -1;
      } 
    }
    matrix = (int[][])append(matrix, plus);
    println(matrix.length);
   
    for (int b = 0; b<101; b++) {
     matrix[cross[0]][b] = -1; 
     matrix[cross[1]][b] = -1;
    }
    for (int c = 0; c<matrix.length;c++){
      if (cross[0]<101) {
        matrix[c][cross[0]] = -1;
      }
      if (cross[1]<101) {
        matrix[c][cross[1]] = -1;
      }
    }
  }
  //int[][] sequence = {{1,3}, {2,4}, {102, 5}, {103, 6}, {7,8}};
  stroke(0);
  fill(50);
  int lines = 0;
  float[][] middles = new float[99][2]; 
    for (int i = 0; i < 99; i++) {
      if (sequence[i][0]-101< 0){
        text(nameList[sequence[i][0]],0,(2*i)*15,50,15);
        lines++;
        text(nameList[sequence[i][1]],0,(2*i)*15+15,50,15);
        lines++;
        line(50,7.5+30*i,60,7.5+30*i);
        line(50,30*i+22.5,60,30*i+22.5);
        line(60,7.5+30*i,60,30*i+22.5);
        middles[i][0] = 60;
        middles[i][1] = 30*i+15;
      }
      else if (sequence[i][0]-101>=0 && sequence[i][1]-101<0){
        int index = sequence[i][0]-100;
        int t = index - 1;
        text(nameList[sequence[i][1]],0,(2*i)*15,50,15);
        lines++;
        line(middles[t][0],middles[t][1],
             middles[t][0]+10,middles[t][1]);
        line(50,15*lines+7.5,middles[t][0]+10,15*lines+7.5);
        line(middles[t][0]+10,middles[t][1],
             middles[t][0]+10,15*lines+7.5);
        middles[i][0] = middles[t][0]+10;
        middles[i][1] = (15*lines+7.5-middles[t][1])/2;
      }
//      else {
//        if (middles[sequence[i][0]][0]<
//            middles[sequence[i][1]][0]) {
//          line(middles[sequence[i][0]][0],middles[sequence[i][0]][1],
//               middles[sequence[i][1]][0]+10, middles[sequence[i][0]][1]);
//          line(middles[sequence[i][1]][0],middles[sequence[i][1]][1], 
//               middles[sequence[i][1]][0]+10,middles[sequence[i][1]][1]);
//          line(middles[sequence[i][1]][0]+10, middles[sequence[i][0]][1],
//               middles[sequence[i][1]][0]+10,middles[sequence[i][1]][1]);
//            }
//        else {
//          line(middles[sequence[i][0]][0],middles[sequence[i][0]][1],
//               middles[sequence[i][0]][0]+10, middles[sequence[i][0]][1]);
//          line(middles[sequence[i][1]][0],middles[sequence[i][1]][1],
//               middles[sequence[i][0]][0]+10, middles[sequence[i][1]][1]);
//          line(middles[sequence[i][0]][0]+10, middles[sequence[i][0]][1],
//               middles[sequence[i][0]][0]+10, middles[sequence[i][1]][1]);
//        }
//      }
    }
  }



void draw() {
}

int[] findMin(){
  int min = 100; 
  int[] cross = new int[2];
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

