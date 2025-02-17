PShape tea;
PShape cap;
PShape ship;
float time = 0.;
float x = 0;
float y = 0;
float z = 1000;
float ux[] = {1., 0., 0.};
float uy[] = {0., 1., 0.};
float uz[] = {0., 0., 1.};
float rtyi = 0.;
float v = 2.;
float vi = 0;
boolean idr = false;
boolean is = false;
float mx;
float my = -0.6;
float mxi;
float myi;
float smx;
float smy;
boolean[] idst = new boolean[17];

void setup() {
  tea = loadShape("teapot.obj");
  cap = loadShape("capsule.obj");
  ship = loadShape("ship.obj");
  size(700, 700, OPENGL);
  noStroke();
}

void c(int n, float s)
{
  beginShape();
  for (int i = 0; i < n; ++i)
    vertex(cos(TWO_PI * (float)i / float(n)) * s, sin(TWO_PI * (float)i / float(n)) * s);
  endShape();
}

void tr(float s, float v, int r, int cr, int cg, int cb, int l, int i) {
  translate(cos((time + l) * v) * r, sin((time + l) * v) * r);
  dr(i, s);
  fill(cr, cg, cb);
}

void dr(int i, float s) {
  if (is && smx > screenX(0,0) - 15 && smx < screenX(0,0) + 15
      && smy > screenY(0,0) && smy < screenY(0,0) + 30) 
      idst[i] = true;
}

void pb(float s, float v, int r, int cr, int cg, int cb, int l, int i) {
  if (idst[i]) return;
  tr(s, v, r, cr, cg, cb, l, i);
  dr(i, s);
  sphere(s);
}

void pbb(float s, float v, int r, int cr, int cg, int cb, int l, int i) {
  if (idst[i]) return;
  tr(s, v, r, cr, cg, cb, l, i);
  rotateZ(-5*time);
  dr(i, s);
  box(s,s,s);
}

void pbb2(float s, float v, int r, int cr, int cg, int cb, int l, int i) {
  tr(s, v, r, cr, cg, cb, l, i);
  rotateX(-5*time);
  rotateY(-5*time);
  dr(i, s);
  box(s,s,s);
}

void pbt(float s, float v, int r, int cr, int cg, int cb, int l, int i) {
  tr(s, v, r, cr, cg, cb, l, i);
  rotateZ(-5 * time);
  dr(i, s);
  scale(5);
  shape(tea, 0, 0);
}

void pbc(float s, float v, int r, int cr, int cg, int cb, int l, int i) {
  if (idst[i]) return;
  translate(sin((time + l) * v) * r, cos((time + l) * v) * r, -sin((time + l) * v) * r);
  fill(cr, cg, cb);
  rotateX(-time);
  rotateY(-time);
  dr(i, s);
  scale(s);
  shape(cap, 0, 0);
}

void pbi(float s, float v, int r, int cr, int cg, int cb, int l, int i) {
  if (idst[i]) return;
  translate(sin(time * v) * r, cos(time * v) * r);
  dr(i, s);
  fill(cr, cg, cb);
  rotateY(-time);
  c(3, s);
}

void p(float s, float v, int r, int cr, int cg, int cb, int l, int i) {
  pushMatrix();
  pb(s, v, r, cr, cg, cb, l, i);
  popMatrix();
}

void b(float s, float v, int r, int cr, int cg, int cb, int l, int i) {
  pushMatrix();
  pbb(s, v, r, cr, cg, cb, l, i);
  popMatrix();
}

void b2(float s, float v, int r, int cr, int cg, int cb, int l, int i) {
  if (idst[i]) return;
  pushMatrix();
  pbb2(s, v, r, cr, cg, cb, l, i);
  popMatrix();
}

void pt(float s, float v, int r, int cr, int cg, int cb, int l, int i) {
  if (idst[i]) return;
  pushMatrix();
  pbt(s, v, r, cr, cg, cb, l, i);
  popMatrix();
}

void pi(float s, float v, int r, int cr, int cg, int cb, int l, int i) {
  pushMatrix();
  pbi(s, v, r, cr, cg, cb, l, i);
  popMatrix();
}

void rty(float a){
  float ca = cos(a);
  float sa = sin(a);
  float m[][] = {
    {uy[0]*uy[0]*(1-ca)+ca, uy[0]*uy[1]*(1-ca)-uy[2]*sa, uy[0]*uy[2]*(1-ca)+uy[1]*sa},
    {uy[0]*uy[1]*(1-ca)+uy[2]*sa, uy[1]*uy[1]*(1-ca)+ca, uy[1]*uy[2]*(1-ca)-uy[0]*sa},
    {uy[0]*uy[2]*(1-ca)-uy[1]*sa, uy[1]*uy[2]*(1-ca)+uy[0]*sa, uy[2]*uy[2]*(1-ca)+ca}
  };
  float oux0 = ux[0], oux1 = ux[1], oux2 = ux[2];
  ux[0] = m[0][0] * oux0 + m[0][1] * oux1 + m[0][2] * oux2;
  ux[1] = m[1][0] * oux0 + m[1][1] * oux1 + m[1][2] * oux2;
  ux[2] = m[2][0] * oux0 + m[2][1] * oux1 + m[2][2] * oux2;
  float ouz0 = uz[0], ouz1 = uz[1], ouz2 = uz[2];
  uz[0] = m[0][0] * ouz0 + m[0][1] * ouz1 + m[0][2] * ouz2;
  uz[1] = m[1][0] * ouz0 + m[1][1] * ouz1 + m[1][2] * ouz2;
  uz[2] = m[2][0] * ouz0 + m[2][1] * ouz1 + m[2][2] * ouz2;
}

void draw()
{
  background(0);
  if (!idst[16]) {
    ambientLight(50,50,50);
    pointLight(255, 255, 255, 0, 0, 0);
    pointLight(255, 255, 255, 0, 0, 0);
    pointLight(255, 255, 255, 0, 0, 0);
  } else return;
  if (v >= 0) v += vi; else v = 0;
  x += -uz[0] * v;
  y += -uz[1] * v;
  z += -uz[2] * v;
  rty(rtyi);
  
  float st = 85 + vi * 50;
  if (st <= 72.5) st = 72.5;
  camera(uz[0] * st + x, uz[1] * st + y - 30, uz[2] * st + z, x, y - 20, z, 0, 1, 0);
  pushMatrix();
  translate(x, y, z);
  rotateX(uz[2] >= 0 ? acos(uz[1]) + HALF_PI : -acos(uz[1]) - HALF_PI);
  rotateY(uz[2] >= 0 ? acos(uz[0]) - HALF_PI : -acos(uz[0]) - HALF_PI);
  rotateZ((ux[0] != 1.) ? (ux[0] > 0) ? asin(uy[0]) : -asin(uy[0]) : 0);
  scale(5);
  mx += mxi;
  if (mx < -11.5) mx = -11.5;
  if (mx > 11.5) mx = 11.5;
  my += myi;
  if (my < -12.5) my = -12.5;
  if (my > 11) my = 11;
  pushMatrix();
  if (!is) {
    fill(255,0,0);
    emissive(255,0,0);
    translate(mx, my + 3.5, 5);
    box(2, 0.2, 0.2);
    box(0.2, 2, 0.2);
  } else {
    translate(0, 0, 5);
    pushMatrix();translate(mx, my + 3.5, 0);smx=screenX(0,0);smy=screenY(0,0);popMatrix();
    fill(0,255,0);
    emissive(0, 255, 0);
    quad(mx + 0.1, my + 4, mx + -0.1, my + 4, -0.25, 0., 0.25, 0.);
    quad(mx - 0.1, my + 4, mx + -0.1, my + 3.9, -0.25, -0.25, -0.25, 0.);
    quad(mx + 0.1, my + 4, mx + 0.1, my + 3.9, 0.25, 0, 0, 0.25);
  }
  popMatrix();
  shape(ship, 0, 0);
  popMatrix();
  fill(255, 255, 0);
  emissive(255, 255, 0);
  scale(2);
  if (idst[0] && idst[1] && idst[2] && idst[4] && idst[7] && idst[7] && idst[15]) dr(16, 0);
  if (!idst[16]) sphere(30);
  
  emissive(0, 0, 0);
  
  p(6, 5, 40, 50, 30, 30, 0, 0);
 
  pt(30, 4, 63, 230, 100, 0, 500, 1);
  
  pushMatrix();
  pb(18, 2.5, 105, 0, 50, 100, -1000, 2);
  pb(4, 5, 25, 220, 220, 220, 0, 3);
  popMatrix();
  
  pushMatrix();
  pb(9, 1.5, 155, 200, 100, 0, -500, 4);
  p(2, 5, 12, 180, 180, 180, 0, 5);
  pb(3, 3, 18, 200, 200, 200, 0, 6);
  popMatrix();
  
  pushMatrix();
  pbb(30, 1, 212, 200, 150, 100, 1000, 7);
  p(2, 5, 23, 180, 180, 180, 0, 8);
  pi(3, 4, 29, 180, 180, 180, 0, 9);
  pb(3, 3, 36, 200, 200, 200, 0, 10);
  popMatrix();
  
  pushMatrix();
  pbc(20, 0.5, 285, 220, 220, 190, -1000, 11);
  p(0.2, 5, 2, 150, 100, 50, 0, 12);
  pi(0.2, 4, 2, 150, 100, 50, 0, 13);
  pi(0.3, 3, 3, 150, 100, 50, 0, 14);
  popMatrix();
 
  b2(16, 0.25, 345, 150, 200, 240, 500, 15);
 
  time += .01;
}

void keyPressed() {
   switch (keyCode) {
     case UP: vi = 0.05; break;
     case DOWN: vi = -0.1; break;
     case LEFT: rtyi = 0.01 * PI; break;
     case RIGHT: rtyi = -0.01 * PI;
   }
   switch (key) {
     case ' ': is = true; break;
     case 'a': mxi = -0.25; break;
     case 'e': case 'd': mxi = 0.25; break;
     case ',': case 'w': myi = 0.25; break;
     case 'o': case 's': myi = -0.25; break;
   }
}

void keyReleased() {
   if (keyCode == UP || keyCode == DOWN) vi = 0;
   if (keyCode == LEFT || keyCode == RIGHT) rtyi=0;
   switch (key) {
     case ' ': is = false; break;
     case 'a': mxi = 0; break;
     case 'e': case 'd': mxi = 0; break;
     case ',': case 'w': myi = 0; break;
     case 'o': case 's': myi = 0; break;
   }
}

void mousePressed() {
  if (mouseButton == LEFT) idr = true;
  if (mouseButton == RIGHT) is = true;
}

void mouseDragged() {
  if (!idr) return;
  if (mouseX > pmouseX)
    rtyi += (mouseX - pmouseX) / 10000.;
  if (mouseX < pmouseX)
    rtyi -= (pmouseX - mouseX) / 10000.;
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    idr = false;
    rtyi = 0;
  }
  if (mouseButton == RIGHT) {
    is = false;
    stopMovingIfOutOfWindow();
  }
}

void mouseClicked() {
  if (mouseButton == LEFT) idr = false;
}

void mouseWheel(MouseEvent e) {
  if (e.getCount() == -1) {
    if (vi < 0.3) vi += 0.05;
  }
  else if (v > 0) {
    if (vi > -0.3) vi -= 0.05;
  }
}

void stopMovingIfOutOfWindow() {
    if (mouseX >= 640 || mouseX <= 0 || mouseY >= 480 || mouseY <= 0)
          idr = false;
}
