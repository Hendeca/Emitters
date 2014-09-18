/* ##############################################
  
          ColorCycle Class
          ----------------
  Cycles through pretty rainbow colors!
  Takes 5 arguments:
    Frequency - How quickly the color changes
    R,G,B Offsets - How much to offset the RGB
      values in order to make a rainbow! If 
      you're not sure what to put here, I
      recommend the values 0, 2, and 4
      respectively
    Alpha - The transparency of the color

  Update() returns an array of rgba values
    for use with Processing's colors

  Future plans: 
    -Switch over to using the color class
    -Overload constructor for default
      values
    -Experiment with controlling other
      variables

############################################## */

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