package com.the1sky.utils{	
	
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	
	/**
	 * 负责js与swf通讯
	 * 
	 * @author dumingtan
	 * @version 1.0
	 * @created 23-2-2011 17:02:28
	 */
	public class JS2SWF extends EventDispatcher{									
		
		/**
		 * 注册swf方法, 供js使用
		 * 
		 * @param func
		 */
		public static function registerSWFMethod(funcName:String, func:Function): void{
			if( ExternalInterface.available ){
				try{
					ExternalInterface.addCallback( funcName, func );
				}catch(e:Error){};
			}
		}
		
		/**
		 * 调用js方法，在as中使用
		 *  
		 * @param jsObjName
		 * @param funcName
		 * @param parameters
		 * 
		 */		
		public static function callJSMethod(jsObjName:String='', funcName:String='', ...parameters):void{	
			var existJSObjName:Boolean = true;
			if( ExternalInterface.available ){
				try{
					if( jsObjName ){
						try{
							ExternalInterface.call( jsObjName.concat( "." ).concat( funcName ), parameters );	
						}catch(e:Error){
							existJSObjName = false;
						};
					}else{
						existJSObjName = false;						
					}
					
					if( !existJSObjName ) ExternalInterface.call( funcName, parameters );
				}catch(e:Error){};
			}
		}
	}
}