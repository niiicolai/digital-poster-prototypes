interface SceneListener {
    void onDraw();
    void onKeyPressed();    
}

class Scene {
  
  public String label;  
  public boolean visible;
  private color bggColor;
  private SceneListener listener;
  
  Scene(String _label, color _bggColor, SceneListener _listener) {
    label = _label;
    bggColor = _bggColor;
    listener = _listener;
  }
    
  public void render() {
    if (!visible) {
      return;
    }
    
    background(bggColor);
    listener.onDraw();
    listener.onKeyPressed();
  }
}
