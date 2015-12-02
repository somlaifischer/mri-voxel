PImage[] images = new PImage[35];

float cameraY;
float fov;
float cameraZ ;
float aspect ;
float rotSpeed = 0.01;
float rot = 0;
int[][][] voxels;
float yOffset = 0;
float xOffset = 0;

PShape pointCloud = new PShape();
void setup()
{
  size(1200, 700, P3D);
  for (int i = 1; i < 35; i++)
  {
    images[i-1] = loadImage("num/"+i+".jpg");
  }
  imageMode(CENTER);
  voxels = new int[35][images[0].width][images[0].height];
  println("voxels are ", voxels.length, voxels[0].length, voxels[0][0].length);
  readVoxels();
  createCloud();

  cameraY = height/2.0;
  fov = float(height)/float(width) * PI;
  cameraZ = cameraY / tan(fov / 2.0);
  aspect = float(width)/float(height);
}

void draw()
{
  background(0);
  tint(255, 80);
  pushMatrix();
  translate(600, 300, 150);

  translate(xOffset, yOffset, mouseX);

  rotateY(rot);
  rot += rotSpeed;
  //showImages();

  shape(pointCloud, 0, 0);
  popMatrix();
  perspective(fov, aspect, cameraZ/10.0, cameraZ*10.0);
}

void createCloud()
{
  pointCloud = createShape();
  pointCloud.beginShape(POINTS);

  for (int i = 0; i < 34; i++)
  {
    for (int j = 0; j < 550; j++)
    {
      for (int k = 0; k < 300; k++)
      {
        if (voxels[i][j][k] > 5) // leave blacks
        {
          pointCloud.stroke(255, voxels[i][j][k]);
          pointCloud.vertex(j, k, i*8);
        }
      }
    }
  }

  pointCloud.endShape();
}


void readVoxels()
{
  //for (int i = 0; i < 1; i++)
  for (int i = 0; i < 34; i++)
  {
    for (int j = 0; j < 550; j++)
    {
      for (int k = 0; k < 300; k++)
      {
        voxels[i][j][k] = images[i].pixels[j + k * 550];
      }
    }
  }

  for (int i = 0; i < 34; i++)
  {
    for (int j = 0; j < 550; j++)
    {
      for (int k = 0; k < 300; k++)
      {
        voxels[i][j][k] = (int)brightness(voxels[i][j][k]);
      }
    }
  }
}


void showImages()
{
  for (int i = 0; i < 34; i++)
  {
    image(images[i], 0, 0);
    translate(0, 0, 10);
  }
}

void keyPressed() 
{
  if (key == '1') {
    rotSpeed += 0.01;
  } else if (key == '2') {
    rotSpeed -= 0.01;
  }

  if (key == CODED) 
  {
    if (keyCode == UP) {
      yOffset -= 10;
    } else if (keyCode == DOWN) {
      yOffset += 10;
    } else if (keyCode == LEFT) {
      xOffset -= 10;
    } else if (keyCode == RIGHT) {
      xOffset += 10;
    }
  }
}