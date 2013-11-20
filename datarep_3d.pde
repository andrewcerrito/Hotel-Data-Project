
Table dataset;
ArrayList<Hotels> hotelList = new ArrayList();

BufferedReader reader; 
PrintWriter writer; 

int[] starCount = new int[6];
float[] mSC = new float[6];

PFont font;

String textString = "Hotel map view - 1 dot : 10 hotels - brighter yellow indicates higher rating - press S for star rating view";


void setup() {
  size(1280, 720, P2D);
  background(0);
  smooth();
  font = createFont("Gill Sans", 14);
  textFont(font);

  /*
    reader = createReader("hotelsbase.csv");
   writer = createWriter("hotelssplit.csv");
   
   try {
   String line = null;
   while ((line = reader.readLine()) != null) {
   if (random(100) < 10) writer.println(line);
   }
   } 
   catch (IOException e) {
   e.printStackTrace();
   }
   writer.flush();
   writer.close();
   
   //*/

  dataset = loadTable("hotelsbase.csv", "header");
  // dataset = loadTable("hotelssplit.csv", "header");

  for (TableRow row : dataset.rows()) {
    // Controls what percentage of the dataset is shown on the map
    if (random(100) < 13) {
      float stars = row.getFloat("stars");
      countStars(stars); // counts the number of star-ranked hotels in each category
      float latitude = row.getFloat("latitude");
      float longitude =row.getFloat("longitude");
      Hotels hotel = new Hotels(stars, latitude, longitude);
      hotel.pos = new PVector((int) random(0, width), (int) random(0, height));
      hotelList.add(hotel);
    }
  }
}


void draw() {
  pushStyle();
  fill(215);
  text(textString, 15, height - 15);
  textAlign(RIGHT);
  text("Andrew Cerrito - ITP 2013", width - 15, height -15);
  fill(0, 25);
  noStroke();
  //using rect with alpha instead of background for fading effects
  rect(0, 0, width, height);
  popStyle();
  
  for (Hotels hotel:hotelList) {
    hotel.update();
    hotel.render();
  }
  //saveFrame("line-######.png");
}


void countStars(float stars) {
  // get a count of how many hotels are in each star rating category
  if (stars == 0) {
    starCount[0]++;
  }
  if (stars == 1 || stars == 1.5) {
    starCount[1]++;
  }
  if (stars == 2 || stars == 2.5) {
    starCount[2]++;
  }
  if (stars == 3 || stars == 3.5) {
    starCount[3]++;
  }
  if (stars == 4 || stars == 4.5) {
    starCount[4]++;
  }
  if (stars == 5) {
    starCount[5]++;
  }
  // prepare the numbers to be mapped into square areas that show their relative sizes.
  // The numbers are square-rooted to prevent amplification when put into a square later.
  int s = 40000;  // size modifier for bounding area for star sorting
  mSC[0] = sqrt(map(starCount[0], 0, starCount[0], 0, s));
  mSC[1] = sqrt(map(starCount[1], 0, starCount[0], 0, s));
  mSC[2] = sqrt(map(starCount[2], 0, starCount[0], 0, s));
  mSC[3] = sqrt(map(starCount[3], 0, starCount[0], 0, s));
  mSC[4] = sqrt(map(starCount[4], 0, starCount[0], 0, s));
  mSC[5] = sqrt(map(starCount[5], 0, starCount[0], 0, s));
}


void orderByStars() {
  // draws each hotel point into appropriately sized squares
  textString = "Star rating view - squares from left to right are 0-5 stars - press M for map view";
  for (Hotels hotel:hotelList) {
    if (hotel.stars == 0) {
      hotel.tpos.x = width/7 + 85 + random(-mSC[0], mSC[0]);
      hotel.tpos.y = height/2 + random(-mSC[0], mSC[0]);
    }
    if (hotel.stars == 1 || hotel.stars == 1.5) {
      hotel.tpos.x = 2*width/7 + 100 + random(-mSC[1], mSC[1]);
      hotel.tpos.y = height/2 + random(-mSC[1], mSC[1]);
    }
    if (hotel.stars == 2 || hotel.stars == 2.5) {
      hotel.tpos.x = 3*width/7 + 90 + random(-mSC[2], mSC[2]);
      hotel.tpos.y = height/2 + random(-mSC[2], mSC[2]);
    }
    if (hotel.stars == 3 || hotel.stars == 3.5) {
      hotel.tpos.x = 4*width/7 + 100 + random(-mSC[3], mSC[3]);
      hotel.tpos.y = height/2 + random(-mSC[3], mSC[3]);
    }
    if (hotel.stars == 4 || hotel.stars == 4.5) {
      hotel.tpos.x = 5*width/7 + 100 + random(-mSC[4], mSC[4]);
      hotel.tpos.y = height/2 + random(-mSC[4], mSC[4]);
    }
    if (hotel.stars == 5) {
      hotel.tpos.x = 6*width/7 + 60 + random(-mSC[5], mSC[5]);
      hotel.tpos.y = height/2 + random(-mSC[5], mSC[5]);
    }
  }
}


void mapView() {
  // reverts hotels into default map view
  textString = "Hotel map view - 1 dot : 10 hotels - brighter yellow indicates higher rating - press S for star rating view";
  for (Hotels hotel:hotelList) {
    hotel.tpos.x = hotel.mappedLong;
    hotel.tpos.y = hotel.mappedLat;
  }
}

void keyPressed() {
  if (key == 's') orderByStars();
  if (key == 'm') mapView();
}

