package com.the1sky.text{
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	/**
	 * 对现有TextField类的扩展
	 *  
	 * @author dumingtan
	 * 
	 */	
	public class TextFieldEx extends TextField{
		public function TextFieldEx(){
			super();
		}
		
		/**
		 *  获取字符串边界矩形
		 * 
		 * @param beginIndex
		 * @param toIndex
		 * @return 
		 * 
		 */		
		public function getStringBoundaries(beginIndex:int, toIndex:int):Rectangle{	
			var rect:Rectangle = new Rectangle();
			if( toIndex > beginIndex && 
				this.text && 
				this.text.length > 0 )
			{
				beginIndex = Math.max( 0, beginIndex );
				toIndex = Math.min( this.text.length - 1, toIndex );
								
				var len:int = toIndex - beginIndex + 1;
				for( var i:int = beginIndex; i < len; i++ ){	
					rect = rect.union( this.getCharBoundaries( i ) );
				}				
			}
			return rect;
		}
	}
}