package org.robotlegs.utilities.deferredcommandqueue {

	import asunit.framework.TestCase;
	
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import org.robotlegs.utilities.deferredcommandqueue.TracerBulletErrorC;
	import org.robotlegs.utilities.deferredcommandqueue.SampleCommandA;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.adapters.SwiftSuspendersReflector;
	import org.robotlegs.base.CommandMap;
	import org.robotlegs.base.MediatorMap;
	import org.robotlegs.core.ICommandMap;
	import org.robotlegs.core.IMediatorMap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class RunNextDeferredCommandTest extends TestCase {
		private var instance:RunNextDeferredCommand;
        private var injector:SwiftSuspendersInjector;

		public function RunNextDeferredCommandTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			instance = new RunNextDeferredCommand();
			
			createInjector();

			injector.mapValue(TracerBulletErrorC, new TracerBulletErrorC());
			
			instance.injector = injector;
			instance.deferredCommandQueue = deferredCommandQueue; 
		}

		override protected function tearDown():void {
			super.tearDown();
			instance = null;
		}

		public function testInstantiated():void {
			assertTrue("instance is RunNextDeferredCommand", instance is RunNextDeferredCommand);
		}
		
		public function testIsCommand():void{
			assertTrue("instance is robotlegs Command", instance is Command);
		}

		public function testFailure():void {
			assertTrue("Failing test", true);
		}
		
		public function test_instantiates_commands_and_fulfills_injections_and_executes():void {
			assertThrows(TracerBulletErrorA, function():void{ instance.execute();  }); 
			assertThrows(TracerBulletErrorB, function():void{ instance.execute();  }); 
			assertThrows(TracerBulletErrorC, function():void{ instance.execute();  });
			instance.execute(); 
			assertTrue("no unexpected errors were thrown if there's no command to execute", true);
		}
		
		
		private function get deferredCommandQueue():DeferredCommandQueue
		{
			var queue:DeferredCommandQueue = new DeferredCommandQueue();
			queue.addCommandToQueue(SampleCommandA);
			queue.addCommandToQueue(SampleCommandB);
			queue.addCommandToQueue(SampleCommandC);
			
			return queue;
		}
		
		private function createInjector():void
		{
			injector = new SwiftSuspendersInjector();
			
			var reflector:SwiftSuspendersReflector = new SwiftSuspendersReflector();
			
			injector.mapValue(IInjector, injector);
			injector.mapValue(IEventDispatcher, new EventDispatcher());
			injector.mapValue(DisplayObjectContainer, new Sprite());
			injector.mapValue(ICommandMap, new CommandMap(new EventDispatcher(), injector, reflector));
			injector.mapValue(IMediatorMap, new MediatorMap(new Sprite(), injector, reflector));
			//injector.mapValue(IViewMap, viewMap);
			//injector.mapClass(IEventMap, EventMap);
		}
		
	}
}