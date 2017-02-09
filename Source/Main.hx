package;

import openfl.Assets;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.geom.Rectangle;
import openfl.ui.Keyboard;

class Main extends Sprite
{
    public function new()
    {
        super();

        var box = new Sprite();
        box.graphics.beginFill(0xBADA55);
        box.graphics.drawRect(-50, -50, 100, 100);
        box.graphics.endFill();
        box.scaleX = 0.25;
        box.scaleY = 0.25;
        box.x = stage.stageWidth / 2;
        box.y = stage.stageHeight / 2;

        addChild(box);

        var bitmapData = Assets.getBitmapData("assets/bar.png");

        var map = new Tilemap(stage.stageWidth, stage.stageHeight);
        map.tileset = new Tileset(bitmapData);
        map.tileset.addRect(new Rectangle(0, 0, 128, 128));

        var follower = new Tile(0);
        follower.scaleX = 0.25;
        follower.scaleY = 0.25;
        
        map.addTile(follower);

        addChild(map);

        var speed = 0;
        
        var keys:Map<Int, Bool> = new Map();
        stage.addEventListener(KeyboardEvent.KEY_UP, function(e:KeyboardEvent) {
            keys[e.keyCode] = false;
        });
        stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent) {
            keys[e.keyCode] = true;
        });

        var lastTime = Lib.getTimer();
        stage.addEventListener(Event.ENTER_FRAME, function(e) {
            var time = Lib.getTimer();
            var dt = (time - lastTime) / 1000;
            
            if(keys[Keyboard.D]) {
                speed = 150;
            } else if(keys[Keyboard.A]) {
                speed = -150;
            } else {
                speed = 0;
            }

            box.x += speed * dt;
            follower.x = box.x - 16;
            follower.y = box.y - 16;

            lastTime = time;
        });
    }
}