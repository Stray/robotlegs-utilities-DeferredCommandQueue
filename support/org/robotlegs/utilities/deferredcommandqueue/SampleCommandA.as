package org.robotlegs.utilities.deferredcommandqueue {
	                                 
	import org.robotlegs.mvcs.Command;
	
	public class SampleCommandA extends Command {
		
		// Testable constants
		// public static const MY_CONST:String = 'myConstant';
		
		//--------------------------------------------------------------------------
		//
		//  Initialization
		//
		//--------------------------------------------------------------------------
		
		public function SampleCommandA() {			
			// pass constants to the super constructor for properties
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden API
		//
		//--------------------------------------------------------------------------
		
		override public function execute():void
		{
			throw(new TracerBulletErrorA());
		}
		
	}
}
