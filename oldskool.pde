import fullscreen.*; // http://www.superduper.org/processing/fullscreen_api/

String PROJECT_NAME = "viaje-aqui";
String URL = "http://v-hudson-01.abrdigital.com.br/hudson/cc.xml";

String BIG_FONT_NAME = "SynchroLET-128.vlw";
String SMALL_FONT_NAME = "SynchroLET-32.vlw";

PFont bigFont, smallFont;

void setup() {
  size(1680, 1050);
  new FullScreen(this).enter();
  bigFont = loadFont(BIG_FONT_NAME);
  smallFont = loadFont(SMALL_FONT_NAME);
}

void draw() {
  List<XMLElement> elements = parseFeed();

  background(0,0,0);
  fill(255, 255, 255);
  textFont(bigFont);
  text("viajeaqui", 32, 128);

  for(int i = 0; i < elements.size(); i++) {
    XMLElement element = elements.get(i);
    String title = element.getString("name");

    int y = 192 + (64 * (i + 1));
    
    textFont(smallFont);

    fill(255, 190, 0);    
    text(element.getString("lastBuildLabel"), 32, y);

    paintBuildColour(element);
    text(title, 100, y);
    text(element.getString("lastBuildStatus"), 675, y);
    text(element.getString("activity"), 825, y);
  }

  delay(2000);
}

List parseFeed() {
  List results = new ArrayList();
  XMLElement rss = new XMLElement(this, URL);
println(rss);
  XMLElement[] titles = rss.getChildren("Project");
  for(int i = 0; i < titles.length; i++) {
    if(titles[i].getString("name").startsWith(PROJECT_NAME)) {
      results.add(titles[i]);
    }
  }

  return results;
}

void paintBuildColour(XMLElement element) {
  if(element.getString("lastBuildStatus").equals("Success")) {
    fill(0, 255, 0);
  } else {
    fill(255, 0, 0);
  }
}

