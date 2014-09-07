class ColorCycle {
  
  int i = 0;
  float freq, oR, oG, oB, a;
  float[] rgbArray = new float[4];
  
  ColorCycle(float frequency, float offsetRed, float offsetGreen, float offsetBlue, float alpha) {
    freq = frequency;
    oR = offsetRed;
    oG = offsetGreen;
    oB = offsetBlue;
    a = alpha;
  }
  
  ColorCycle() {
    freq = 1;
    oR = 0;
    oG = 2;
    oB = 4;
    a = 255;
  }
  
  float[] update() {
    rgbArray[0] = ((sin(radians(freq * i) + oR)) * 127) + 128;
    rgbArray[1] = ((sin(radians(freq * i) + oG)) * 127) + 128;
    rgbArray[2] = ((sin(radians(freq * i) + oB)) * 127) + 128;
    rgbArray[3] = a;
    i += 1;
    return rgbArray;
  }
}
