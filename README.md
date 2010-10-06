# **DeferredCommandQueue utility for robotlegs** #

### Compatibility: robotlegs v 1.0

## What's it for? ##

Say you've got a series of asynchronous loading actions to be carried out by a service. And each loading action is called by an individual command, but you want to wait until each command is finished before running the next. And the order (and occurrence) of that list of commands is only decided at runtime. This utility helps you in that situation.

## Ok - what do I need to do to use it? ##

#### First, set up the mapping for the DeferredCommandQueue itself

    injector.mapSingletonOf(IDeferredCommandQueue, DeferredCommandQueue)

#### Then wire some events to the RunNextDeferredCommand (really that should be called RunNextDeferredCommandCommand but that sounds stupid)

    // you need an event that's going to kick the process off (this is your custom event)
	commandMap.mapEvent(DataRequestEvent.DATA_LOADING_REQUESTED, RunNextDeferredCommand);

	// you also need to wire to an event that is fired when each process is finished (also a custom event)
	commandMap.mapEvent(SomeServiceEvent.FINISHED_LOADING_DATA, RunNextDeferredCommand);
	
#### Then populate your queue with the commands you'd like to run - this might happen in a command itself - let's assume it does

	[Inject]
	public var deferredCommandQueue:IDeferredCommandQueue;
	
	override public function execute():void
	{
		deferredCommandQueue.addCommandToQueue(SomeCommand);
		deferredCommandQueue.addCommandToQueue(SomeOtherCommand);
		
		// by default, the command will only be added if it has never been in the queue.
		// pass true as the 2nd parameter if you really want to repeat it
		deferredCommandQueue.addCommandToQueue(SomeCommand, true);
	} 
	                 
	
##### An alternative implementation - where you're receiving payload on an event that determines the commands to add:

	// this command is mapped to the data loading request event instead of RunNextDeferredCommand
                     
	[Inject]
	public var deferredCommandQueue:IDeferredCommandQueue;
	
	[Inject]
	public var dataRequestEvent:DataRequestEvent;
	
	// your commands might be stored in a lookup object that allows you to retrieve them using the data request payload 
	// so that UserData is mapped to LoadUserDataCommand etc.
	[Inject]
	public var dataLoadingCommandsLookup:IDataCommandsLookup;
	
	override public function execute():void
	{
		
		var dataRequestTypes:Vector.<Class> = dataRequestEvent.dataRequestTypes;
		
		for each (var nextDataClass:Class in dataRequestTypes)
		{
			var dataLoadingCommandClass:CommandClass = dataLoadingCommandsLookup.getCommandForDataClass(nextDataClass);
			deferredCommandQueue.addCommandToQueue(dataLoadingCommandClass);
		}
		
	    // now run the RunNextDeferredCommand (or you could simply map it to the same event as this one but afterwards)
		var runNextDeferredCommand:Command = injector.instantiate(RunNextDeferredCommand);
		runNextDeferredCommand.execute();
		
	}
	

## Good to know ##

The queue keeps a history of commands that have been run, and unless you pass true as the second parameter, adding a command again will have no impact if it has been added before, not solely if it's in the current execution queue.

If you wanted to map the RunNextDeferredCommand to multiple specific events that are fired at the ends of various async processes that should be fine.

If there are no commands left in the queue then it just ends silently.

You must pass a Command (a class having an execute function) to the queue - anything else causes an IllegalOperationError.

When you add a command to the queue it returns true or false based on whether the command has been added in that process (if it was already there then it would return false unless you passed true as the second parameter)
  

## Where's clearHistory / listCommands / stop / resume ... ##

I built the minimum implementation required for my own purposes. Fork-it-n-fix-it if you want more.            
  
 
## Why not just queue in the service?

This allows you to queue across services, and to keep your queuing logic out of the service layer.


## What's the support directory for? ##

I like to separate source / tests / support. The support folder structure matches the others, but it contains items specifically created for testing purposes that should never be used in your real implementation. The tests are for asUnit 3.