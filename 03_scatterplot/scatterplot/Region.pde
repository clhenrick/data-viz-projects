class Region {
  String name;
  int r, g, b;
  
  Region(String name_, int r_, int g_, int b_){
    r = r_;
    g = g_;
    b = b_;
    name = name_;
  };
  
  int rValue(){
    return r;
  }
  
  int gValue(){
    return g;
  }
  
  int bValue(){
    return b;
  }
  
  String nameValue(){
    return name;
  }
  
}
