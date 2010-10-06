package org.robotlegs.utilities.deferredcommandqueue 
{
	
	import org.robotlegs.mvcs.Command;
	
	public class RunNextDeferredCommand extends Command
	{
	
		[Inject]
		public var deferredCommandQueue:IDeferredCommandQueue;
		
		override public function execute():void 
		{
			if(!deferredCommandQueue.hasNextCommand)
			{
			   return;
			}
			
			var commandClass:Class = deferredCommandQueue.getNextCommand();
			var command:Object = injector.instantiate(commandClass);
			
			command.execute();
		} 
	}
}
