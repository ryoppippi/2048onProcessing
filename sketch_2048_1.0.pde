int[][] numbers = new int[4][4];
float[][] centersX = new float[4][4];
float[][] centersY = new float[4][4];
int scene;
int score;
boolean move;
boolean drawS;
boolean gameover;
void setup(){
    size(480, 640, P2D);
    for(int i=0;i<4;i++){
        for(int j=0;j<4;j++){
            numbers[i][j] = 0;
            centersX[i][j] = 0;
            centersY[i][j] = 0;
        }
    }
    scene = 0;
    score = 0;
    move = false;
    drawS = true;
    gameover = false;
    int firstAX;
    int firstAY;
    int firstBX;
    int firstBY;
    do{
        firstAX = int(random(0,4));
        firstAY = int(random(0,4));
        firstBX = int(random(0,4));
        firstBY = int(random(0,4));
    }while((firstBX == firstAX) && (firstBY == firstAY));
    int firstNumber1, firstNumber2;
    if(random(0,1)>0.5){
        firstNumber1 = 2;
    }else{firstNumber1 = 4;}
    if(random(0,1)>0.5){
        firstNumber2 = 2;
    }else{firstNumber2 = 4;}
    numbers[firstAX][firstAY] = firstNumber1;
    numbers[firstBX][firstBY] = firstNumber2;

    for(int i=0;i<4;i++){
        for(int j=0;j<4;j++){
            float x = 75 + 110*i;
            float y = 195 + 110*j;
            centersX[i][j] = x;
            centersY[i][j] = y;
        }
    }
    drawBackground();
}

void draw(){
    if(drawS == true && gameover == false){
            drawSquares(12);
    }
    if(gameover==true){
        drawS = false;
        rectMode(CENTER);
        fill(#9f8d85,12);
        rect(240,360,440,440);
        textAlign(CENTER,CENTER);
        fill(#fa0000,36);
        textSize(48);
        text("GAMEOVER",240,360);
        textAlign(CENTER,TOP);
        fill(#ffffff,12);
        textSize(32);
        text("Tap to restart",240,400);
    }
}

void drawBackground(){
    background(#F9F6E9);
    textAlign(CENTER);
    fill(0);
    textSize(64);
    text("2048",240,80);
    strokeJoin(ROUND);
    fill(#d4271c);
    textAlign(LEFT,TOP);
    textSize(28);
    text("Score: " + score,0,0,CORNER);
    fill(#857970);
    rectMode(CENTER);
    rect(240,360,440,440,10);
    for(int i=0;i<4;i++){
        for(int j=0;j<4;j++){
            fill(#988C81);
            rect(centersX[i][j],centersY[i][j],100,100,10);
        }
    }
}

void drawSquares(int a){
    for(int i=0;i<4;i++){
        for(int j=0;j<4;j++){
            int x = numbers[i][j];
            if(x != 0){
                fillSquareColors(x,a);
                rect(centersX[i][j],centersY[i][j],100,100,10);
                fill(#000000);
                textSize(48);
                textAlign(CENTER,CENTER);
                text(numbers[i][j],centersX[i][j],centersY[i][j]);
            }
        }
    }
}

void keyWorks(){
    if(true){
        gameover = gameOverOrNot();
        int[][] numberBefore = {{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0}};
        for(int i=0;i<4;i++){
            for(int j=0;j<4;j++){
                numberBefore[i][j] = numbers[i][j];
            }
        }
        if(keyCode == UP){
            for(int i=0;i<4;i++){
                for(int j=0;j<4;j++){
                    int count = 0;
                    while(numbers[i][j] == 0 && count < 4){
                        count++;
                        for(int k=0;k+j<3;k++){
                            numbers[i][j+k] = numbers[i][j+k+1];
                        }
                        numbers[i][3] = 0;
                    }
                }
                for(int j=0;j<4;j++){
                    if(j<3){
                        if(numbers[i][j] == numbers[i][j+1]){
                            numbers[i][j] += numbers[i][j+1];
                            score += numbers[i][j];
                            for(int k=1;k<(3-j);k++){
                                numbers[i][j+k] = numbers[i][j+k+1];
                            }
                            numbers[i][3] = 0;
                        }
                    }
                }
            }
        }
        else if(keyCode == DOWN){
            for(int i=0;i<4;i++){
                for(int j=3;j>0;j--){
                    int count = 0;
                    while(numbers[i][j] == 0 && count < 4){
                        count++;
                        for(int k=0;j-k>0;k++){
                            numbers[i][j-k] = numbers[i][j-k-1];
                        }
                        numbers[i][0] = 0;
                    }
                }
                for(int j=3;j>0;j--){
                    if(j>0){
                        if(numbers[i][j] == numbers[i][j-1]){
                            numbers[i][j] += numbers[i][j-1];
                            score += numbers[i][j];
                            for(int k=1;j-k>0;k++){
                                numbers[i][j-k] = numbers[i][j-k-1];
                            }
                            numbers[i][0] = 0;
                        }
                    }
                }
            }
        }
        else if(keyCode == LEFT){
            for(int j=0;j<4;j++){
                for(int i=0;i<4;i++){
                    int count = 0;
                    while(numbers[i][j] == 0 && count < 4){
                        count++;
                        for(int k=0;k+i<3;k++){
                            numbers[i+k][j] = numbers[i+k+1][j];
                        }
                        numbers[3][j] = 0;
                    }
                }
                for(int i=0;i<4;i++){
                    if(i<3){
                        if(numbers[i][j] == numbers[i+1][j]){
                            numbers[i][j] += numbers[i+1][j];
                            score += numbers[i][j];
                            for(int k=1;k+i<3;k++){
                                numbers[i+k][j] = numbers[i+k+1][j];
                            }
                            numbers[3][j] = 0;
                        }
                    }
                }
            }
        }
        else if(keyCode == RIGHT){
            for(int j=0;j<4;j++){
                for(int i=3;i>0;i--){
                    int count = 0;
                    while(numbers[i][j] == 0 && count < 4){
                        count++;
                        for(int k=0;i-k>0;k++){
                            numbers[i-k][j] = numbers[i-k-1][j];
                        }
                        numbers[0][j] = 0;
                    }
                }
                for(int i=3;i>0;i--){
                    if(i>0){
                        if(numbers[i][j] == numbers[i-1][j]){
                            numbers[i][j] += numbers[i-1][j];
                            score += numbers[i][j];
                            for(int k=1;i-k>0;k++){
                                numbers[i-k][j] = numbers[i-k-1][j];
                            }
                            numbers[0][j] = 0;
                        }
                    }
                }
            }
        }
        else{}
        for(int i=0;i<4;i++){
            for(int j=0;j<4;j++){
                if(numberBefore[i][j] != numbers[i][j]){
                    move = true;
                    break;
                }
                if(move==true){break;}
            }
        }
        if(move==true){
            drawS = true;
            move = false;
        }
        if(drawS == true){
            drawBackground();
            drawSquares(256);
            randomNumber();
        }
    }
}

void fillSquareColors(int x, int y){
        switch(x){
            case 2: fill(#EFE2DB,y); break;
            case 4: fill(#F1DEC7,y); break;
            case 8: fill(#F3B077,y); break;
            case 16: fill(#FF995C,y); break;
            case 32: fill(#FF8558,y); break;
            case 64: fill(#FF682F,y); break;
            case 128: fill(#F3CB69,y); break;
            case 256: fill(#F0C552,y); break;
            case 512: fill(#F5C344,y); break;
            case 1024: fill(#F4BF28,y); break;
            case 2048: fill(#F7BD00,y); break;
            case 4096: fill(#FF736B,y); break;
            case 8192: fill(#FF5A57,y); break;
            case 16384: fill(#F15030,y); break;
            case 32768: fill(#68ADDB,y); break;
            case 65536: fill(#559AE7,y); break;
            case 131072: fill(#0071C6,y); break;
            default: fill(#0071C6,y); break;
        }
}

void randomNumber(){
    int a;
    do{
        a = int(random(0,15.1));
    }while(numbers[a%4][a/4] != 0);
    int b;
    if(random(0,1)>0.5){
        b = 2;
    }else{b = 4;}
    numbers[a%4][a/4] = b;
}


void keyPressed(){
    drawS = false;
    keyWorks();
}

void mousePressed() {
    if(gameover == true){
        setup();
    }
    else{
        drawS = false;
        keyCode = 0;
        if(mouseX < width / 4) keyCode = LEFT;
        if(mouseX > width * 3 / 4) keyCode = RIGHT;
        if(mouseY < 240) keyCode = UP;
        if(mouseY > height * 3 / 4) keyCode = DOWN;
        if(keyCode>0) keyWorks();
    }
}

boolean gameOverOrNot(){
    for(int i=0;i<4;i++){
        for(int j=0;j<3;j++){
            if( numbers[i][j]==0 || numbers[j][i]==0 ||numbers[i][j+1]==0 ||numbers[j+1][i]==0 || numbers[i][j]==numbers[i][j+1] || numbers[j][i]==numbers[j+1][i]){
                return false;
            }
        }
    }
    return true;
}
