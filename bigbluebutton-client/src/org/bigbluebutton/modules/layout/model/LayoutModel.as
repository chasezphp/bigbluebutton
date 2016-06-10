package org.bigbluebutton.modules.layout.model
{
  import org.as3commons.logging.api.ILogger;
  import org.as3commons.logging.api.getClassLogger;
  import org.bigbluebutton.util.i18n.ResourceUtil;

  public class LayoutModel
  {
	private static const LOGGER:ILogger = getClassLogger(LayoutModel);      
    
    private static var instance:LayoutModel = null;
    
    private var _layouts:LayoutDefinitionFile = null;
    
    public function LayoutModel(enforcer:SingletonEnforcer)
    {
      if (enforcer == null){
        throw new Error("There can only be 1 LayoutModel instance");
      }
    }
    
    public static function getInstance():LayoutModel{
      if (instance == null){
        instance = new LayoutModel(new SingletonEnforcer());
      }
      return instance;
    }
    
    public function getDefaultLayout():LayoutDefinition {
      return _layouts.getDefault();
    }
    
    public function getLayout(name:String):LayoutDefinition {
      return _layouts.getLayout(name);
    }
    
    public function hasLayout(name:String):Boolean {
      for each (var lay:Object in getLayoutNames()){
        var translatedName:String = ResourceUtil.getInstance().getString(lay.name);
        if (translatedName == "undefined"){
          if (name == lay.name){
            return true;
          }
        }
        else if (translatedName == name){
          return true;
        }
      }
      
      return false;
    }
    
    public function addLayouts(layouts: LayoutDefinitionFile):void {
      _layouts = layouts;
    }
    
    public function addLayout(layout: LayoutDefinition):void {
      _layouts.push(layout);
    }

    public function removeLayout(layout: LayoutDefinition):void{
      _layouts.splice(_layouts.indexOf(layout));
    }
    
    public function getLayoutNames():Array {
      if (_layouts == null) return new Array();
      return _layouts.list;
    }
    
    public function toString():String {
      return _layouts.toXml().toXMLString();
    }
  }
}

class SingletonEnforcer{}