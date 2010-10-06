package org.robotlegs.utilities.deferredcommandqueue {
	                                 
	import org.robotlegs.mvcs.Command;
	
	public class SampleCommandC extends Command {
		
		// Testable constants
		//public static const MY_CONST:String = 'myConstant';
		
		[Inject]
		public var injectedError:TracerBulletErrorC;
		
		//--------------------------------------------------------------------------
		//
		//  Initialization
		//
		//--------------------------------------------------------------------------
		
		public function SampleCommandC() {			
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
			throw(injectedError);
		}
	}
}
