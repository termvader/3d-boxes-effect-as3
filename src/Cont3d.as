package  {
	import flash.display.Sprite;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Linear;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	
	public class Cont3d extends Sprite{
		
		static private var stgWt:uint;
		static private var stgHt:uint;
		
		static private const hdHt:uint = 50;
		static private const ftHt:uint = 136;
		static private var fSc:Number;
		
		static private var cubes:Vector.<Vector.<Vector.<Cube>>>;
		public var curStatus:String;
		static private const boxwido:uint = 80;
		static private const halfwido:uint = 40;
		static private var boxwid:uint;
		static private var halfwid:uint;
		static private const cols:uint = 8/2;
		static private const rows:uint = 4/2;

		public function Cont3d() {
			// constructor code
			//stgWt = _stgWt;
			//stgHt = _stgHt;
			
			//this.x = stgWt/2;
			//this.y = stgHt/2;
			//this.z = halfwid;
			
			cubes = new Vector.<Vector.<Vector.<Cube>>>(cols);
			cubes.fixed = true;
			var e:int;
			var r:int;
			for(e = 0; e<cols; e++)
			{
				cubes[e] = new Vector.<Vector.<Cube>>(rows);
				cubes[e].fixed = true;
				for(r = 0; r<rows; r++)
				{
					cubes[e][r] = new Vector.<Cube>(4);
					cubes[e][r].fixed = true;
					
					cubes[e][r][0] = new Cube(false, this);
					cubes[e][r][0].upda();
					cubes[e][r][0].rotationX = 180;
					
					cubes[e][r][1] = new Cube(true, this);
					cubes[e][r][1].upda();
					cubes[e][r][1].rotationX = 180;
					
					cubes[e][r][2] = new Cube(true, this);
					cubes[e][r][2].rotationX = -180;
					cubes[e][r][2].upda();
					
					cubes[e][r][3] = new Cube(false, this);
					cubes[e][r][3].rotationX = -180;
					cubes[e][r][3].upda();
					
				}
			}
			curStatus = "blank";
		}
		
		public function setValues(_stgWt:int, _stgHt:int):void
		{
			stgWt = _stgWt;
			stgHt = _stgHt;
			fSc = (stgHt - hdHt - ftHt - 50)/(2*rows*boxwido);
			boxwid = fSc*boxwido;
			halfwid = fSc*halfwido;
			if(curStatus == "blank")
			{
				for(var e:int = cols-1; e>-1; e--)
				{
					for(var r:int = rows-1; r>-1; r--)
					{
						trace(stgWt);
						cubes[e][r][0].x = -stgWt/2;
						cubes[e][r][0].y = -stgHt/2;
						cubes[e][r][0].rotationX = 0;
						
						cubes[e][r][1].x = stgWt/2;
						cubes[e][r][1].y = -stgHt/2;
						cubes[e][r][1].rotationX = 0;
						
						cubes[e][r][2].x = stgWt/2;
						cubes[e][r][2].y = stgHt/2;
						cubes[e][r][2].rotationX = 0;
						
						cubes[e][r][3].x = -stgWt/2;
						cubes[e][r][3].y = stgHt/2;
						cubes[e][r][3].rotationX = 0;
						
						for(var t:uint = 0; t<4; t++)
						{
							cubes[e][r][t].scaleX = 0;
							cubes[e][r][t].scaleY = 0;
							cubes[e][r][t].scaleZ = 0;
							this.addChild(cubes[e][r][t]);
						}
					}
				}
			}
			else if(curStatus == "Vis")
			{
				this.graphics.clear();
				this.graphics.beginFill(0x000000);
				this.graphics.drawRect(-2*halfwid*cols, -2*halfwid*rows, 4*halfwid*cols, 4*halfwid*rows);
				this.graphics.endFill();
				for(var i:uint = 0; i<cols; i++)
				{
					for(var j:uint = 0; j<rows; j++)
					{
						cubes[i][j][0].scaleX = fSc;
						cubes[i][j][0].scaleY = fSc;
						cubes[i][j][0].x = -halfwid*(2*i+1);
						cubes[i][j][0].y = -halfwid*(2*j +1);
						
						cubes[i][j][1].scaleX = fSc;
						cubes[i][j][1].scaleY = fSc;
						cubes[i][j][1].x = halfwid*(2*i+1);
						cubes[i][j][1].y = -halfwid*(2*j +1);
						
						cubes[i][j][2].scaleX = fSc;
						cubes[i][j][2].scaleY = fSc;
						cubes[i][j][2].x = halfwid*(2*i+1);
						cubes[i][j][2].y = halfwid*(2*j +1);
						
						cubes[i][j][3].scaleX = fSc;
						cubes[i][j][3].scaleY = fSc;
						cubes[i][j][3].x = -halfwid*(2*i+1);
						cubes[i][j][3].y = halfwid*(2*j +1);
						
					}
				}
			}
			/*else if(curStatus == "AnimIn")
			{
				
			}
			else if(curStatus == "AnimOut")
			{
				
			}*/
		}
		
		public function showIn(callThis:Function):void
		{
			this.graphics.clear();
			this.filters = [];
			this.cacheAsBitmap = false;
			for(var i:int = 0; i<cols; i++)
			{
				for(var j:int = 0; j<rows; j++)
				{
					for(var k:int = 0; k<4; k++)
					{
						cubes[i][j][k].visible = true;
					}
					var tl1:TimelineLite = new TimelineLite({delay:0.2*( 4 -i - j), onComplete:showInComp, onCompleteParams:[i+j, callThis], autoRemoveChildren:true});
					/*tl1.appendMultiple([new TweenLite(cubes[i][j][0], 0.3, {x:-halfwid*(2*i+1), scaleX:0.5, scaleY:0.5, scaleZ:0.5, y:0, z:0, rotationX:181, onUpdate:cubes[i][j][0].upda, ease:Quad.easeOut, onStart:cubes[i][j][0].addback}),
										new TweenLite(cubes[i][j][1], 0.3, {x:halfwid*(2*i+1), scaleX:0.5, scaleY:0.5, scaleZ:0.5, y:0, z:0, rotationX:181, onUpdate:cubes[i][j][1].upda, ease:Quad.easeOut, onStart:cubes[i][j][1].addback}),
										new TweenLite(cubes[i][j][2], 0.3, {x:halfwid*(2*i+1), scaleX:0.5, scaleY:0.5, scaleZ:0.5, y:0, z:0, rotationX:-181, onUpdate:cubes[i][j][2].upda, ease:Quad.easeOut, onStart:cubes[i][j][2].addback}),
										new TweenLite(cubes[i][j][3], 0.3, {x:-halfwid*(2*i+1), scaleX:0.5, scaleY:0.5, scaleZ:0.5, y:0, z:0, rotationX:-181, onUpdate:cubes[i][j][3].upda, ease:Quad.easeOut, onStart:cubes[i][j][3].addback})
										]);*/
					tl1.appendMultiple([new TweenLite(cubes[i][j][0], 0.4, {x:-halfwid*(2*i+1), scaleX:fSc, scaleY:fSc, scaleZ:fSc, y:-halfwid*(2*j +1), z:0, rotationX:181, onUpdate:cubes[i][j][0].upda, ease:Quad.easeIn, onStart:cubes[i][j][0].addback}),
										new TweenLite(cubes[i][j][1], 0.4, {x:halfwid*(2*i+1), scaleX:fSc, scaleY:fSc, scaleZ:fSc, y:-halfwid*(2*j +1), z:0, rotationX:181, onUpdate:cubes[i][j][1].upda, ease:Quad.easeIn, onStart:cubes[i][j][1].addback}),
										new TweenLite(cubes[i][j][2], 0.4, {x:halfwid*(2*i+1), scaleX:fSc, scaleY:fSc, scaleZ:fSc, y:halfwid*(2*j +1), z:0, rotationX:-181, onUpdate:cubes[i][j][2].upda, ease:Quad.easeIn, onStart:cubes[i][j][2].addback}),
										new TweenLite(cubes[i][j][3], 0.4, {x:-halfwid*(2*i+1), scaleX:fSc, scaleY:fSc, scaleZ:fSc, y:halfwid*(2*j +1), z:0, rotationX:-181, onUpdate:cubes[i][j][3].upda, ease:Quad.easeIn, onStart:cubes[i][j][3].addback})
										]);
			
					tl1.appendMultiple([new TweenLite(cubes[i][j][0], 0.5, {scaleZ:0, rotationX:360, onUpdate:cubes[i][j][0].upda, onComplete:cubes[i][j][0].rem}), 
										new TweenLite(cubes[i][j][1], 0.5, {scaleZ:0, rotationX:360, onUpdate:cubes[i][j][1].upda, onComplete:cubes[i][j][1].rem}),
										new TweenLite(cubes[i][j][2], 0.5, {scaleZ:0, rotationX:-360, onUpdate:cubes[i][j][2].upda, onComplete:cubes[i][j][2].rem}),
										new TweenLite(cubes[i][j][3], 0.5, {scaleZ:0, rotationX:-360, onUpdate:cubes[i][j][3].upda, onComplete:cubes[i][j][3].rem})
										]);
					tl1 = null;
				}



			}
			curStatus = "AnimIn";
		}
		
		private function showInComp(val:uint, callThis:Function):void
		{
			if(val == 0)
			{
				for(var e:uint = 0; e<cols; e++)
				{
					for(var r:uint = 0; r<rows; r++)
					{
						for(var t:uint = 0; t<4; t++)
						{
							cubes[e][r][t].visible = false;
						}
					}
				}
				this.graphics.clear();
				this.graphics.beginFill(0x000000);
				this.graphics.drawRect(-2*halfwid*cols, -2*halfwid*rows, 4*halfwid*cols, 4*halfwid*rows);
				this.graphics.endFill();
				this.filters = [new GlowFilter(0xffffff)];
				callThis.call();
				curStatus = "Vis";
			}
		}
		
		public function showOut(callThis:Function):void
		{
			this.graphics.clear();
			this.filters = [];
			this.cacheAsBitmap = false;
			for(var i:int = 0; i<cols; i++)
			{
				for(var j:int = 0; j<rows; j++)
				{
					for(var k:int = 0; k<4; k++)
					{
						cubes[i][j][k].visible = true;
					}
					var tl1:TimelineLite = new TimelineLite({delay:0.2*( 4 -i - j), onComplete:showOutComp, onCompleteParams:[i+j, callThis], autoRemoveChildren:true});
					/*tl1.appendMultiple([new TweenLite(cubes[i][j][0], 0.3, {x:-halfwid*(2*i+1), scaleX:0.5, scaleY:0.5, scaleZ:0.5, y:0, z:0, rotationX:181, onUpdate:cubes[i][j][0].upda, ease:Quad.easeOut, onStart:cubes[i][j][0].addback}),
										new TweenLite(cubes[i][j][1], 0.3, {x:halfwid*(2*i+1), scaleX:0.5, scaleY:0.5, scaleZ:0.5, y:0, z:0, rotationX:181, onUpdate:cubes[i][j][1].upda, ease:Quad.easeOut, onStart:cubes[i][j][1].addback}),
										new TweenLite(cubes[i][j][2], 0.3, {x:halfwid*(2*i+1), scaleX:0.5, scaleY:0.5, scaleZ:0.5, y:0, z:0, rotationX:-181, onUpdate:cubes[i][j][2].upda, ease:Quad.easeOut, onStart:cubes[i][j][2].addback}),
										new TweenLite(cubes[i][j][3], 0.3, {x:-halfwid*(2*i+1), scaleX:0.5, scaleY:0.5, scaleZ:0.5, y:0, z:0, rotationX:-181, onUpdate:cubes[i][j][3].upda, ease:Quad.easeOut, onStart:cubes[i][j][3].addback})
										]);*/
					
					tl1.appendMultiple([new TweenLite(cubes[i][j][0], 0.5, {scaleZ:fSc, rotationX:180, onUpdate:cubes[i][j][0].upda, onComplete:cubes[i][j][0].rem, onStart:cubes[i][j][0].addback, ease:Quad.easeIn}), 
										new TweenLite(cubes[i][j][1], 0.5, {scaleZ:fSc, rotationX:180, onUpdate:cubes[i][j][1].upda, onComplete:cubes[i][j][1].rem, onStart:cubes[i][j][1].addback, ease:Quad.easeIn}),
										new TweenLite(cubes[i][j][2], 0.5, {scaleZ:fSc, rotationX:-180, onUpdate:cubes[i][j][2].upda, onComplete:cubes[i][j][2].rem, onStart:cubes[i][j][2].addback, ease:Quad.easeIn}),
										new TweenLite(cubes[i][j][3], 0.5, {scaleZ:fSc, rotationX:-180, onUpdate:cubes[i][j][3].upda, onComplete:cubes[i][j][3].rem, onStart:cubes[i][j][3].addback, ease:Quad.easeIn})
										]);
					tl1.appendMultiple([new TweenLite(cubes[i][j][0], 0.4, {x:-stgWt/2, scaleX:0, scaleY:0, scaleZ:0, y:-stgHt/2, z:0, rotationX:360, onUpdate:cubes[i][j][0].upda}),
										new TweenLite(cubes[i][j][1], 0.4, {x:stgWt/2, scaleX:0, scaleY:0, scaleZ:0, y:-stgHt/2, z:0, rotationX:360, onUpdate:cubes[i][j][1].upda}),
										new TweenLite(cubes[i][j][2], 0.4, {x:stgWt/2, scaleX:0, scaleY:0, scaleZ:0, y:stgHt/2, z:0, rotationX:-360, onUpdate:cubes[i][j][2].upda}),
										new TweenLite(cubes[i][j][3], 0.4, {x:-stgWt/2, scaleX:0, scaleY:0, scaleZ:0, y:stgHt/2, z:0, rotationX:-360, onUpdate:cubes[i][j][3].upda})
										]);
			
					tl1 = null;
				}
			}
			curStatus = "AnimOut";
		}
		
		private function showOutComp(val:int, callThis:Function):void
		{
			if(val == 0)
			{
				for(var e:uint = 0; e<cols; e++)
				{
					for(var r:uint = 0; r<rows; r++)
					{
						for(var t:uint = 0; t<4; t++)
						{
							cubes[e][r][t].visible = false;
						}
					}
				}
				callThis.call();
				curStatus = "blank";
			}
		}
	}
}