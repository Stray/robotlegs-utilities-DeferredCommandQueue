package {
	/**
	 * This file has been automatically created using
	 * #!/usr/bin/ruby script/generate suite
	 * If you modify it and run this script, your
	 * modifications will be lost!
	 */

	import asunit.framework.TestSuite;
	
	import org.robotlegs.utilities.deferredcommandqueue.DeferredCommandQueueTest;
	import org.robotlegs.utilities.deferredcommandqueue.RunNextDeferredCommandTest;
	
	public class AllTests extends TestSuite {

		public function AllTests() {

			addTest(new org.robotlegs.utilities.deferredcommandqueue.DeferredCommandQueueTest());
			addTest(new org.robotlegs.utilities.deferredcommandqueue.RunNextDeferredCommandTest());

		}
	}
}
