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
		private var _jsObjName:String;
		private static var  _instance:JS2SWF;
		
		public function JS2SWF(value:InternalClass):void{			
		}
		
		/**
		 *  单例方法
		 *  
		 * @return 
		 * 
		 */		
		public static function getInstance():JS2SWF{	
			if( !_instance ){
				_instance = new JS2SWF( new InternalClass );
			}
			return _instance;
		}
		
		/**
		 * 获取/设置js对象名称
		 *  
		 * @return 
		 * 
		 */		
		public function get jsObjName():String{
			return _jsObjName;	
		}
		public function set jsObjName(value:String):void{
			_jsObjName = value;
		}

	    /**
	     * 注册swf方法, 供js使用
	     * 
	     * @param func
	     */
	    public function registerSWFMethod(funcName:String, func:Function): void{
			if( ExternalInterface.available ){			
				ExternalInterface.addCallback( funcName, func );
			}
	    }
		
		/**
		 * 调用js方法，在as中使用
		 *  
		 * @param funcName
		 * @param parameters
		 * 
		 */		
		public function callJSMethod(funcName:String, ...parameters):void{			
			if( ExternalInterface.available ){				
				ExternalInterface.call( _jsObjName.concat( "." ).concat( funcName ), parameters );
			}
		}
	}
}
internal class InternalClass{} 