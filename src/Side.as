package  {
	import flash.display.Shape;
	
	public class Side extends Shape{
		
		private const halfwid:uint = 40;
		private const boxwid:uint = 80;

		public function Side(color:uint) {
			// constructor code
			this.graphics.beginFill(color);
			this.graphics.drawRect(-halfwid, -halfwid, boxwid, boxwid);
			this.graphics.endFill();
		}
		
		public function fil(color:uint):void
		{
			this.graphics.clear();
			this.graphics.beginFill(color);
			this.graphics.drawRect(-halfwid, -halfwid, boxwid, boxwid);
			this.graphics.endFill();
		}
 	}
}