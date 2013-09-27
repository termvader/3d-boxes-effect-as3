package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.MouseEvent;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Aziz K.
	 */
	public class Main extends Sprite 
	{
		static private var bg:Cont3d;
		static private var isAnimating:Boolean;
		static private var isVis:Boolean;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			bg = new Cont3d();
			bg.mouseChildren = false;
			bg.setValues(stage.stageWidth, stage.stageHeight);
			bg.x = stage.stageWidth / 2;
			bg.y = stage.stageHeight / 2;
			bg.transform.perspectiveProjection = new PerspectiveProjection();
			bg.transform.perspectiveProjection.projectionCenter = new Point(0, 0);
			this.addChild(bg);
			
			isAnimating = false;
			isVis = false;
			
			var showBtn:Sprite = new Sprite();
			var showText:TextField = new TextField();
			showText.text = "Show";
			showText.embedFonts = false;
			showText.antiAliasType = AntiAliasType.ADVANCED;
			showText.setTextFormat(new TextFormat("Arial", 18, 0xffffff));
			showText.autoSize = TextFieldAutoSize.LEFT;
			showText.selectable = false;
			showText.x = 15;
			showText.y = 15;
			showBtn.graphics.beginFill(0x000000);
			showBtn.graphics.drawRoundRect(0, 0, showText.width + 30, showText.height + 30, 10, 10);
			showBtn.graphics.endFill();
			showBtn.buttonMode = true;
			showBtn.mouseChildren = false;
			showBtn.addChild(showText);
			showBtn.x = 20;
			showBtn.y = 20;
			showBtn.addEventListener(MouseEvent.CLICK, showAnim);
			stage.addChild(showBtn);
			
			var hideBtn:Sprite = new Sprite();
			var hideText:TextField = new TextField();
			hideText.text = "Hide";
			hideText.embedFonts = false;
			hideText.antiAliasType = AntiAliasType.ADVANCED;
			hideText.setTextFormat(new TextFormat("Arial", 18, 0xffffff));
			hideText.autoSize = TextFieldAutoSize.LEFT;
			hideText.selectable = false;
			hideText.x = 15;
			hideText.y = 15;
			hideBtn.graphics.beginFill(0x000000);
			hideBtn.graphics.drawRoundRect(0, 0, hideText.width + 30, hideText.height + 30, 10, 10);
			hideBtn.graphics.endFill();
			hideBtn.buttonMode = true;
			hideBtn.mouseChildren = false;
			hideBtn.addChild(hideText);
			hideBtn.x = 40 + showBtn.width;
			hideBtn.y = 20;
			hideBtn.addEventListener(MouseEvent.CLICK, hideAnim);
			stage.addChild(hideBtn);
			
			var flipBtn:Sprite = new Sprite();
			var flipText:TextField = new TextField();
			flipText.text = "Flip";
			flipText.embedFonts = false;
			flipText.antiAliasType = AntiAliasType.ADVANCED;
			flipText.setTextFormat(new TextFormat("Arial", 18, 0xffffff));
			flipText.autoSize = TextFieldAutoSize.LEFT;
			flipText.selectable = false;
			flipText.x = 15;
			flipText.y = 15;
			flipBtn.graphics.beginFill(0x000000);
			flipBtn.graphics.drawRoundRect(0, 0, flipText.width + 30, flipText.height + 30, 10, 10);
			flipBtn.graphics.endFill();
			flipBtn.buttonMode = true;
			flipBtn.mouseChildren = false;
			flipBtn.addChild(flipText);
			flipBtn.x = 60 + showBtn.width + hideBtn.width;
			flipBtn.y = 20;
			flipBtn.addEventListener(MouseEvent.CLICK, flipAnim);
			stage.addChild(flipBtn);
			
			stage.addEventListener(Event.RESIZE, stageResized);
		}
		
		private function flipAnim(e:MouseEvent):void 
		{
			if (!isAnimating && isVis)
			{
				isAnimating = true;
				bg.showIn(flipAnimDone);
			}
		}
		
		private function flipAnimDone():void 
		{
			isAnimating = false;
			isVis = true;
		}
		
		private function hideAnim(e:MouseEvent):void 
		{
			if (!isAnimating && isVis)
			{
				isAnimating = true;
				bg.showOut(hideAnimDone);
			}
		}
		
		private function hideAnimDone():void 
		{
			isAnimating = false;
			isVis = false;
		}
		
		private function showAnim(e:MouseEvent):void 
		{
			if (!isAnimating && !isVis)
			{
				isAnimating = true;
				bg.showIn(showAnimDone);
			}
		}
		
		private function showAnimDone():void 
		{
			isAnimating = false;
			isVis = true;
		}
		
		private function stageResized(e:Event):void 
		{
			if (bg != null)
			{
				bg.setValues(stage.stageWidth, stage.stageHeight);
				bg.x = stage.stageWidth / 2;
				bg.y = stage.stageHeight / 2;
				bg.transform.perspectiveProjection = new PerspectiveProjection();
				bg.transform.perspectiveProjection.projectionCenter = new Point(0, 0);
			}
		}
		
	}
	
}