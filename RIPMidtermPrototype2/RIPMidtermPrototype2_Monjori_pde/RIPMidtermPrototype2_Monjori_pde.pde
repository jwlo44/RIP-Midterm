
/**
 * Monjori. 
 * 
 * GLSL version of the 1k intro Monjori from the demoscene 
 * (http://www.pouet.net/prod.php?which=52761)
 * Ported from the webGL version available in ShaderToy:
 * http://www.iquilezles.org/apps/shadertoy/
 * (Look for Monjori under the Plane Deformations Presets) 
 */
 
PShader monjori;
  int CENTERX;
  int CENTERY;
  String[] CommandList;
  String[] ModifierList;
  String[] HandList;
  int timer;
  String textToDraw;
  int TIMERLOWER;
  int TIMERHIGHER;

void setup() {
  size(1920, 1080, P2D);
  noStroke();
 
  monjori = loadShader("monjori.glsl");
  monjori.set("resolution", float(width), float(height));   
  
    textFont(createFont("Arial", 72));
  fill(255);
  textAlign(CENTER);
  CENTERX = width/2;
  CENTERY = height/2;
  CommandList = new String[] {"extend", "release", "raise", "lower", "retract", "spread"};
  HandList = new String[] {"left", "right", "both" };
  ModifierList = new String[] {"fast", ""};
  timer = 0;
  textToDraw = "";
  TIMERLOWER = 150;
  TIMERHIGHER = 300;
}

void draw() {
  monjori.set("time", millis() / 1000.0);
  
  shader(monjori);
  // This kind of effects are entirely implemented in the
  // fragment shader, they only need a quad covering the  
  // entire view area so every pixel is pushed through the 
  // shader.   
  rect(0, 0, width, height);  
  
    if (timer == 0) {
  textToDraw = generateCommand(); 
  timer = (int) random(TIMERLOWER, TIMERHIGHER);
  } else {
    timer--;
  }
  fill(timer);
   text(textToDraw, CENTERX, CENTERY);
}

String generateCommand() {
  String dest = "";
  
  int cmd = (int) random(CommandList.length);
  
  int hand = (int) random(HandList.length);

  int modif = (int) random(ModifierList.length);
  dest = dest + CommandList[cmd];
  dest = dest + " " + HandList[hand];
  dest = ModifierList[modif] + " " + dest;
  
  if (hand == 0) {
  if ((int) random(2) == 0) {
        dest = dest + "\n";
    dest = dest + ModifierList[(int) random(ModifierList.length)];
    dest = dest + " " + CommandList[(int) random(CommandList.length)];
    dest = dest + " right";
  }
  } else if (hand == 1) {
     if ((int) random(2) == 0) {
    dest = dest + "\n";
    dest = dest + ModifierList[(int) random(ModifierList.length)];
    dest = dest + " " + CommandList[(int) random(CommandList.length)];
    dest = dest + " left";
  }
    
  }
  return dest;
}

