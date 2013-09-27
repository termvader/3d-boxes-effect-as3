package  {
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	
	public class Cube extends Sprite{
		
		private var zIndex:Array;
		private var i:uint;
		private var side:DisplayObject;
		
		private var back:Side;
		private var top:Side;
		private var bottom:Side;
		private var front:Side;
		private var left:Side;
		private var right:Side;
		
		private var rit2:Boolean;
		
		private var stag:DisplayObject;
		
		private const halfwid:uint = 40;
		
		private var col:uint;
		private var r:uint;
		private var g:uint;
		private var b:uint;
		
		public function Cube(rit:Boolean, stg:DisplayObject) {
			// constructor code
			stag = stg;
			rit2 = rit;
			zIndex = new Array();
			i = 5;
			while(i--)
			{
				zIndex.push(new Object);
			}
			back = new Side(0x333333);
			back.x = 0;
			back.y = 0;
			back.z = halfwid;
			this.addChild(back);
			
			top = new Side(0x666666);
			top.y = -halfwid;
			top.x = 0;
			top.rotationX = -90;
			this.addChild(top);
			
			bottom = new Side(0x666666);
			bottom.y = halfwid;
			bottom.x = 0;
			bottom.rotationX = 90;
			this.addChild(bottom);
			
			if(rit)
			{
				left = new Side(0x333333);
				left.y = 0;
				left.x = -halfwid;
				left.rotationY = 90;
				this.addChild(left);
			}
			else
			{
				right = new Side(0x333333);
				right.y = 0;
				right.x = halfwid;
				right.rotationY = 90;
				this.addChild(right);
			}
			front = new Side(0x333333);
			front.y = 0;
			front.x = 0;
			front.z = -halfwid;
			this.addChild(front);
		}
		
		public function upda():void
		{
			for(i=0; i<5; i++)
			{
				side = this.getChildAt(i);
				zIndex[i].screenZ = side.transform.getRelativeMatrix3D(stag).position.z;
				
				zIndex[i].mc = side;
			}
			zIndex.sortOn("screenZ", Array.NUMERIC | Array.DESCENDING);
			for(i=2; i<5; i++)
			{
				this.addChild(zIndex[i].mc);
				zIndex[i].mc.visible = true;
			}
			for(i=0; i<2; i++)
			{
				zIndex[i].mc.visible = false;
			}
			var rotX:int = (Math.abs(this.rotationX)>180)?(Math.abs(this.rotationX)-360):Math.abs(this.rotationX);
			//var rotX = Math.abs(this.rotationX) - 360;
			col =  (Math.abs(rotX)/90)*0x33;
			front.fil((col<<16) + (col<<8) + col);
			col = (Math.abs(90 - Math.abs(rotX))/90)*0x66;
			top.fil((col<<16) + (col<<8) + col);
			bottom.fil((col<<16) + (col<<8) + col);
		}
		
		public function rem():void
		{
			this.rotationX = 0;
			back.visible = false;
			top.visible = false;
			bottom.visible = false;
			if(rit2)
			{
				left.visible = false;
			}
			else
			{
				right.visible = false;
			}
		}
		
		public function addback():void
		{
			this.visible = true;
			back.visible = true;
			top.visible = true;
			bottom.visible = true;
			if(rit2)
			{
				left.visible = true;
			}
			else
			{
				right.visible = true;
			}
		}
	}
}