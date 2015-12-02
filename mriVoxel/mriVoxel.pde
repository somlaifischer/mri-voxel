PImage[] images = new PImage[35];

float cameraY;
float fov;
float cameraZ ;
float aspect ;
float rotSpeed = 0.01;
float rot = 0;
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
        int br = (int)brightness(images[i].pixels[j + k * 550]);
        if (br > 5) // leave blacks
        {
          pointCloud.stroke(255, br);
          pointCloud.vertex(j, k, i*8);
        }
      }
    }
  }

  pointCloud.endShape();
}


void readVoxels()
{
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
