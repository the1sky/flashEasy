package com.the1sky.transform{	
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	/**
	 * 网格item在区域内放大缩小
	 *  
	 * @author dumingtan
	 * 
	 */	
	public class AreaGridZoomer{
		public const LT:String = "lt";          		//左上
		public const RT:String = "rt";          		//右上
		public const LB:String = "lb";          		//左底
		public const RB:String = "rb";          		//右底
		public const C:String = "c";           	 		//中间
		
		private var _w:Number;                  		//区域宽度
		private var _h:Number;                 	 		//区域高度
		private var _itemW:Number;              		//item宽度
		private var _itemH:Number;              		//item高度
		private var _itemToW:Number;                    //item的目标宽度
		private var _itemToH:Number;                    //item的目标高度
		private var _hSpace:Number;                     //水平间隔
		private var _vSpace:Number;                     //垂直间隔
		private var _hNum:int;                          //水平item数目
		private var _vNum:int;                          //垂直item数目
		private var _registrationPointType:String;      // 注册点类型
		private var _oldXYs:Dictionary;                 //旧的x,y
		
		/**
		 * 
		 * @param itemWidth
		 * @param itemHeight
		 * @param itemToWidth
		 * @param itemToHeight
		 * @param hNumber
		 * @param vNumber
		 * @param hSpace
		 * @param vSpace
		 * @param registrationPointType
		 * 
		 */		
		public function AreaGridZoomer( itemWidth:Number, itemHeight:Number,
										   itemToWidth:Number, itemToHeight:Number,
										   hNumber:int, vNumber:int,
										   hSpace:Number=0, vSpace:Number=0, 
										   registrationPointType:String="lt" ){
						
			_itemW = itemWidth;
			_itemH = itemHeight;
			_itemToW = itemToWidth;
			_itemToH = itemToHeight;
			_hSpace = hSpace;
			_vSpace = vSpace;
			_hNum = hNumber;
			_vNum = vNumber;
			_registrationPointType = registrationPointType;
			
			calculateWH();
			calculateOldXY();
		}
		
		/**
		 * 获取/设置item的宽度
		 *  
		 * @return 
		 * 
		 */		
		public function get itemWidth():Number{
			return _itemW;
		}
		public function set itemWidth(value:Number):void{
			_itemW = value;
			calculateWH();
			calculateOldXY();
		}
		
		/**
		 * 获取/设置item的高度
		 *  
		 * @return 
		 * 
		 */		
		public function get itemHeight():Number{
			return _itemH;
		}
		public function set itemHeight(value:Number):void{
			_itemH = value;
			calculateWH();
			calculateOldXY();
		}
		
		/**
		 * 获取/设置item的目标宽度
		 *  
		 * @return 
		 * 
		 */		
		public function get itemToWidth():Number{
			return _itemToW;
		}
		public function set itemToWidth(value:Number):void{
			_itemToW = value;			
		}
		
		/**
		 * 获取/设置item的目标高度
		 *  
		 * @return 
		 * 
		 */		
		public function get itemToHeight():Number{
			return _itemToH;
		}
		public function set itemToHeight(value:Number):void{
			_itemToH = value;			
		}
		
		/**
		 * 获取/设置水平item的数目
		 *  
		 * @return 
		 * 
		 */		
		public function get hNumber():int{
			return _hNum;
		}
		public function set hNumber(value:int):void{
			_hNum = value;
			calculateWH();
			calculateOldXY();
		}
		
		/**
		 * 获取/设置垂直item的数目
		 * 
		 * @return 
		 * 
		 */		
		public function get vNumber():int{
			return _vNum;
		}
		public function set vNumber(value:int):void{
			_vNum = value;
			calculateWH();
			calculateOldXY();
		}
		
		/**
		 * 获取/设置水平item的间隔
		 *  
		 * @return 
		 * 
		 */		
		public function get hSpace():Number{
			return _hSpace;
		}
		public function set hSpace(value:Number):void{
			_hSpace = value;
			calculateWH();
			calculateOldXY();
		}
		
		/**
		 * 获取/设置垂直item的间隔
		 *  
		 * @return 
		 * 
		 */		
		public function get vSpace():Number{
			return _vSpace;
		}
		public function set vSpace(value:Number):void{
			_vSpace = value;
			calculateWH();
			calculateOldXY();
		}
		
		/**
		 * 获取/设置item注册点的类型
		 *  
		 * @return 
		 * 
		 */		
		public function get registrationPointType():String{
			return _registrationPointType;
		}
		public function set registrationPointType(value:String):void{
			_registrationPointType = value;
		}	
		
		/**
		 * 获取旧的x,y
		 *  
		 * @param hIndex
		 * @param vIndex
		 * @return 
		 * 
		 */		
		public function getOldXY(hIndex:int, vIndex:int):Point{
			return _oldXYs[hIndex + "_" + vIndex] as Point;			
		}
		
		/**
		 * 获取目标item的目标x,y
		 *  
		 * @param hIndex       水平方向上的index
		 * @param vIndex       垂直方向上的index
		 * @return 
		 * 
		 */		
		public function getTargetXY(hIndex:int, vIndex:int):Point{
			if( ( hIndex + 1 ) > _hNum || ( vIndex + 1 ) > _vNum ){
				return null;
			}
			
			var p:Point = getOldXY( hIndex, vIndex );
			var oldX:Number = p.x;
			var oldY:Number = p.y;			
			var targetX:Number = 0;
			var targetY:Number = 0;						
			
			switch( _registrationPointType ){
				case LT:
					targetX = oldX +  ( _itemW - _itemToW ) * .5;
					targetY = oldY +  ( _itemH - _itemToH ) * .5;
					break;
				case RT:
					targetX = oldX -  ( _itemW - _itemToW ) * .5;
					targetY = oldY +  ( _itemH - _itemToH ) * .5;
					break;
				case LB:
					targetX = oldX +  ( _itemW - _itemToW ) * .5;
					targetY = oldY -  ( _itemH - _itemToH ) * .5;
					break;
				case RB:
					targetX = oldX -  ( _itemW - _itemToW ) * .5;
					targetY = oldY -  ( _itemH - _itemToH ) * .5;
					break;
				case C:
					targetX = oldX;
					targetY = oldY;
					break;
			}			
			
			if( targetX < 0 ){
				targetX = 0;
			}else if( ( targetX + _itemToW ) > _w ){
				targetX = _w - _itemToW;
			}
			
			if( targetY < 0 ){
				targetY = 0;
			}else if( ( targetY + _itemToH ) > _h ){
				targetY = _h - _itemToH;
			}						
			
			return new Point( targetX, targetY );
		}
		
		/**
		 * 计算区域宽度和高度 
		 * 
		 */		
		private function calculateWH():void{
			_w = ( _itemW * _hNum ) + ( _hNum - 1 ) * _hSpace;
			_h = ( _itemH * _vNum ) + ( _vNum - 1 ) * _vSpace;
		}
		
		/**
		 * 计算区域内每个item的x,y，保存在_oldXYs 
		 * 
		 */		
		private function calculateOldXY():void{
			_oldXYs = new Dictionary();
			for( var i:int = 0; i < _hNum; i++ ){
				for( var j:int = 0; j < _vNum; j++ ){
					_oldXYs[i + "_" + j] = new Point( i * ( _itemW + _hSpace ), 
													  j * ( _itemH + _vSpace ) );
				}
			}
		}
	}
}