package org.robotlegs.utilities.deferredcommandqueue {

	import asunit.framework.TestCase;
	import org.robotlegs.utilities.deferredcommandqueue.SampleCommandA;
	import org.robotlegs.utilities.deferredcommandqueue.SampleCommandB;
	import org.robotlegs.utilities.deferredcommandqueue.SampleCommandC;
	import flash.errors.IllegalOperationError;

	public class DeferredCommandQueueTest extends TestCase {
		private var instance:DeferredCommandQueue;

		public function DeferredCommandQueueTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			instance = new DeferredCommandQueue();
		}

		override protected function tearDown():void {
			super.tearDown();
			instance = null;
		}

		public function testInstantiated():void {
			assertTrue("instance is DeferredCommandQueue", instance is DeferredCommandQueue);
		}
		
		public function testImplementsInterface():void {
			assertTrue("instance is IDeferredCommandQueue", instance is IDeferredCommandQueue);
		}

		public function testFailure():void {
			assertTrue("Failing test", true);
		}
		
		public function test_adds_and_retrieves_new_commands():void {
			instance.addCommandToQueue(SampleCommandA);
			instance.addCommandToQueue(SampleCommandB);
			instance.addCommandToQueue(SampleCommandC);
			assertEquals('retrieves correct command A', SampleCommandA, instance.getNextCommand());
			assertEquals('retrieves correct command B', SampleCommandB, instance.getNextCommand());
			assertEquals('retrieves correct command C', SampleCommandC, instance.getNextCommand());
			assertTrue('retrieves correct command - no commands left', null == instance.getNextCommand());
		}
		
		public function test_repeat_adds_if_asked_to():void {
			assertTrue('returns true when adding if unique A', instance.addCommandToQueue(SampleCommandA, false));
			assertTrue('returns true when adding if unique B', instance.addCommandToQueue(SampleCommandB, false));
			assertTrue('returns true when adding when asked to repeat', instance.addCommandToQueue(SampleCommandA, true));
			assertEquals('retrieves correct command A', SampleCommandA, instance.getNextCommand());
			assertEquals('retrieves correct command B', SampleCommandB, instance.getNextCommand());
			assertEquals('retrieves correct command A', SampleCommandA, instance.getNextCommand());
			assertTrue('retrieves correct command - no commands left', null == instance.getNextCommand());
		}
		
		public function test_returns_false_for_repeated_commands_in_queue_if_asked_not_to_repeat():void {
			assertTrue('returns true when adding if unique A', instance.addCommandToQueue(SampleCommandA));
			assertTrue('returns true when adding if unique B', instance.addCommandToQueue(SampleCommandB));
			assertFalse('returns false when adding when asked not to repeat', instance.addCommandToQueue(SampleCommandA));
			assertEquals('retrieves correct command A', SampleCommandA, instance.getNextCommand());
			assertEquals('retrieves correct command B', SampleCommandB, instance.getNextCommand());
			assertTrue('retrieves correct command - no commands left', null == instance.getNextCommand());
		}
		
		public function test_throws_error_if_class_passed_is_not_a_command():void {
			assertThrows(IllegalOperationError, function():void{ instance.addCommandToQueue(String)  }); 
		}
		
		public function test_returns_false_for_commands_in_history_if_asked_not_to_repeat():void {
			assertTrue('returns true when adding if unique A', instance.addCommandToQueue(SampleCommandA));
			assertTrue('returns true when adding if unique B', instance.addCommandToQueue(SampleCommandB));
			assertEquals('retrieves correct command A', SampleCommandA, instance.getNextCommand());
			assertFalse('returns false for command in history when adding when asked not to repeat', instance.addCommandToQueue(SampleCommandA));
			assertEquals('retrieves correct command B', SampleCommandB, instance.getNextCommand());
			assertTrue('retrieves correct command - no commands left', null == instance.getNextCommand());
		}
		
		public function test_retuns_true_and_adds_for_commands_in_history_if_asked_to_repeat():void {
			assertTrue('returns true when adding if unique A', instance.addCommandToQueue(SampleCommandA));
			assertTrue('returns true when adding if unique B', instance.addCommandToQueue(SampleCommandB));
			assertEquals('retrieves correct command A', SampleCommandA, instance.getNextCommand());
			assertTrue('returns true for command in history when adding when asked to repeat', instance.addCommandToQueue(SampleCommandA, true));
			assertEquals('retrieves correct command B', SampleCommandB, instance.getNextCommand());
			assertEquals('retrieves correct command A', SampleCommandA, instance.getNextCommand());
			assertTrue('retrieves correct command - no commands left', null == instance.getNextCommand());
		}
		
		public function test_returns_has_next_command_only_until_none_are_left():void {
			instance.addCommandToQueue(SampleCommandA);
			instance.addCommandToQueue(SampleCommandB);
			instance.addCommandToQueue(SampleCommandC);
			assertTrue("returns hasNextCommand true when there are more commands 1", instance.hasNextCommand);
			instance.getNextCommand();
			assertTrue("returns hasNextCommand true when there are more commands 2", instance.hasNextCommand);
			instance.getNextCommand();
			assertTrue("returns hasNextCommand true when there are more commands 3", instance.hasNextCommand);
			instance.getNextCommand();
			assertFalse("returns hasNextCommand false when there are no more commands 4", instance.hasNextCommand);
			instance.addCommandToQueue(SampleCommandA, true);
			assertTrue("returns hasNextCommand true when there are more commands 5", instance.hasNextCommand);
			instance.getNextCommand();
			assertFalse("returns hasNextCommand false when there are no more commands 6", instance.hasNextCommand);
		}
		
		
		
	}
}