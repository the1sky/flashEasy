package com.the1sky.load{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.URLRequest;	
	
	/**
	 * 万能加载器
	 *  
	 * @author dumingtan
	 * 
	 */	
	public class AnyLoader extends Sprite{		
		private var _w:Number = 50;
		private var _h:Number = 50;
		private var _actualW:Number;
		private var _actualH:Number;
		private var _url:String;
		private var _area:Sprite;
		private var _mask:Sprite;
		private var _ld:Loader;		
		
		public function AnyLoader(){						
			init();
		}				
		
		public function startLoad(url:String):void{				
			_url = url;
			try{
				_ld.close();
			}catch(e:Error){};
			_ld.unload();
			_ld.scaleX = _ld.scaleY = 1;
			_ld.load( new URLRequest( url ) );
		}
		
		/**
		 * 获取/设置宽度
		 *  
		 * @param value
		 * 
		 */		
		public override function set width(value:Number):void{
			_w = value;
			drawArea();
		}
		public override function get width():Number{
			return _w;
		}
		
		/**
		 * 获取/设置高度
		 *  
		 * @param value
		 * 
		 */		
		public override function set height(value:Number):void{
			_h = value;
			drawArea();
		}
		public override function get height():Number{
			return _h;
		}
		
		/**
		 * 被加载素材的实际宽度
		 *  
		 * @return 
		 * 
		 */		
		public function get actualWidth():Number{	
			return _actualW;
		}
		
		/**
		 * 被加载素材的实际高度
		 *  
		 * @return 
		 * 
		 */		
		public function get actualHeight():Number{
			return _actualH;
		}
		
		/**
		 * 初始化 
		 * 
		 */		
		private function init():void{
			_ld = new Loader();			
			_ld.contentLoaderInfo.addEventListener( Event.COMPLETE, loadedHandler );
			_ld.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, loadedHandler );
			addChild( _ld );	
		}
		
		/**
		 * 绘制背景区域 ,透明
		 * 
		 */		
		private function drawArea():void{
			if( !_area ){
				_area = new Sprite();
			}
			_area.graphics.clear();
			_area.graphics.beginFill( 0, 0 );
			_area.graphics.drawRect( 0, 0, _w, _h );
			_area.graphics.endFill();
			addChildAt( _area, 0 );
			
			if( !_mask ){
				_mask = new Sprite();
			}
			
			_mask.graphics.copyFrom( _area.graphics );
			addChild( _mask );
			this.mask = _mask;
		}
		
		/**
		 * 加载事件处理
		 *  
		 * @param e
		 * 
		 */		
		private function loadedHandler(e:Event):void{			
			var tmpw:Number;
			var tmph:Number;
			try{
				tmpw = _ld.contentLoaderInfo.width;
			}catch(e:Error){
				tmpw = 0;
			};
			try{
				tmph = _ld.contentLoaderInfo.height;
			}catch(e:Error){
				tmph = 0;
			};			
			_actualW = ( _ld.width > 0 ) ? _ld.width : tmpw;
			_actualH = ( _ld.height > 0 ) ? _ld.height : tmph;			
			var scale:Number = ( _actualW && _actualH ) ? Math.min(  _w / _actualW, _h / _actualH ) : 1;
			_ld.scaleX = _ld.scaleY = scale;
			_ld.x = ( _w - _actualW * scale ) * .5;
			_ld.y = ( _h - _actualH * scale ) * .5;				
			this.dispatchEvent( new Event( Event.COMPLETE ) );
		}
	}
}