class RNG {

  Random generator = new Random();
  float num; // Generated number
        
  RNG() {
  }
  
  float getGaussRand(float sd, float mean) {
    num = (((float) generator.nextGaussian()) * sd) + mean;
    return num;
  }
  
}
