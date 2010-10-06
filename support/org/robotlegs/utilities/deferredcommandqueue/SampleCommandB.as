package org.robotlegs.utilities.deferredcommandqueue {
	                                 
	import org.robotlegs.mvcs.Command;
	
	public class SampleCommandB extends Command {
		
		// Testable constants
		//public static const MY_CONST:String = 'myConstant';
		
		//--------------------------------------------------------------------------
		//
		//  Initialization
		//
		//--------------------------------------------------------------------------
		
		public function SampleCommandB() {			
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
			throw(new TracerBulletErrorB());
		}
		
	}
}
