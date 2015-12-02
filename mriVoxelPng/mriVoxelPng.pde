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
float zOffset = 0;
float tiltX = 0;
float tiltZ = 0;
PShape pointCloud = new PShape();
void setup()
{
  size(1200, 700, P3D);
  for (int i = 1; i < 35; i++)
  {
    images[i-1] = loadImage("png/"+i+".png");
  }
  imageMode(CENTER);

  cameraY = height/2.0;
  fov = float(height)/float(width) * PI / 2;
  cameraZ = cameraY / tan(fov / 2.0);
  aspect = float(width)/float(height);
}

void draw()
{
  background(0);
  tint(255, 80);
  pushMatrix();
  translate(600, 300, 0);

  translate(xOffset, yOffset, zOffset);

  rotateY(rot);
  rotateX(tiltX);
  rotateZ(tiltZ);
  rot += rotSpeed;
  if (rot%(PI*2) < 1.2 || rot%(PI*2) > 5.04) showImages(1);
  else showImages(-1);

  popMatrix();
  perspective(fov, aspect, cameraZ/10.0, cameraZ*10.0);
}


void showImages(int dir)
{
  tint(255, 100);
  if (dir == 1)
  {
    for (int i = 0; i < 34; i++)
    {
      for (int j = 0; j < 6; j++)
      {
        image(images[i], 0, 0);
        translate(0, 0, 2);
      }

    }
  } else
  {
    translate(0, 0, 10 * 33);
    for (int i = 33; i >= 0; i--)
    {
      for (int j = 0; j < 6; j++)
      {
        image(images[i], 0, 0);
        translate(0, 0, -2);
      }
    }
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
      tiltX -= 0.1;
    } else if (keyCode == DOWN) {
      tiltX += 0.1;
    } else if (keyCode == LEFT) {
      tiltZ -= 0.1;
    } else if (keyCode == RIGHT) {
      tiltZ += 0.1;
    }
  }
}

void mouseDragged() 
{
  yOffset -= pmouseY-mouseY;
  xOffset -= pmouseX-mouseX;
}

void mouseWheel(MouseEvent event) 
{
  float e = event.getCount();
  zOffset += e;
}