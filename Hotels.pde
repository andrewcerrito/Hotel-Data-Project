class Hotels {

  String name;
  float stars;
  float latitude;
  float longitude;
  float mappedLong, mappedLat, rankBrightness;


  PVector pos = new PVector();
  PVector tpos = new PVector();

  Hotels(float tempStars, float tempLat, float tempLong) {
    stars = tempStars;
    latitude = tempLat;
    longitude = tempLong;
    // mapping long/lat to the confines of the screen
    mappedLong =  map(longitude, -180, 180, 0, width);
    mappedLat = map(latitude, -90, 90, height, 0);
    // gradating color based on star rating, more yellow = higher rating
    rankBrightness =  map(stars, 0, 5, 100, 255);
    tpos.x = mappedLong;
    tpos.y = mappedLat;
  }

  void update() {
    pos.lerp(tpos, 0.1);
  }

  void render() {
    stroke(255, rankBrightness, 0);
    // update position and draw dot
    point(pos.x, pos.y);
  }
}

