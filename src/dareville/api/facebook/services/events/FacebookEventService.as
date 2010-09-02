package dareville.api.facebook.services.events
{
	import dareville.api.facebook.FacebookConstants;
	import dareville.api.facebook.data.common.FacebookIdentificationCollectionData;
	import dareville.api.facebook.data.events.FacebookEventCollectionData;
	import dareville.api.facebook.data.events.FacebookEventCreateData;
	import dareville.api.facebook.data.events.FacebookEventData;
	import dareville.api.facebook.services.common.AbstractFacebookService;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import org.casalib.util.DateUtil;
	import org.osflash.signals.Signal;
	
	/**
	 * The <code>FacebookEventService</code> class provides access to event
	 * data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookEventService 
		extends AbstractFacebookService
	{
		//----------------------------------
		//  Signals
		//----------------------------------
		
		/**
		 * Signal dispatched once the events call has loaded. Dispatches a
		 * <code>FacebookEventCollectionData</code> as a parameter.
		 */		
		public var eventsLoaded : Signal = new Signal( FacebookEventCollectionData );
		
		/**
		 * Signal dispatched once the event call has loaded. Dispatches a
		 * <code>FacebookEventData</code> as a parameter.
		 */		
		public var eventLoaded : Signal = new Signal( FacebookEventData );
		
		/**
		 * Signal dispatched once the create event call has completed. 
		 * Dispatches a <code>String</code> as a parameter.
		 */		
		public var eventCreated : Signal = new Signal( String );
		
		/**
		 * Signal dispatched once the modify event call has completed. 
		 * Dispatches a <code>Boolean</code> as a parameter.
		 */		
		public var eventModified : Signal = new Signal( Boolean );
		
		/**
		 * Signal dispatched once the status event load call has completed. 
		 * Dispatches a <code>FacebookIdentificationCollectionData</code> as 
		 * a parameter.
		 */		
		public var statusLoaded : Signal = new Signal( FacebookIdentificationCollectionData );
		
		/**
		 * Signal dispatched once the update status event call has completed. 
		 * Dispatches a <code>Boolean</code> as a parameter.
		 */		
		public var statusUpdated : Signal = new Signal( Boolean );
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Retrieves all events asynchronously that are associated with the 
		 * specified post/photo/link/etc.
		 * 
		 * <p>If the request succeeds, a <code>eventsLoaded</code> 
		 * Signal is dispatched containing an 
		 * <code>FacebookEventCollectionData</code> instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param page_id Page ID to retrieve
		 * 
		 * @return URLLoader Loader 
		 * 
		 * @example This example retrieves the events associated with the 
		 * currently logged in user:
<listing version="3.0">
var service : FacebookEventService = new FacebookEventService();
service.eventsLoaded.addOnce( onEventsLoaded );
service.getEvents( access_token );
 
function onEventsLoaded( vo : FacebookEventCollectionData ):void
{
	service.eventsLoaded.removeAll();
}</listing>
		 */		
		public function getEvents(
			access_token : String,
			page_id : String = FacebookConstants.CONNECTION_ME ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onEventsLoadIOError );
				loader.addEventListener( Event.COMPLETE, onEventsLoadComplete );
				
				// Call the service
				call( loader, page_id + "/" + FacebookConstants.CONNECTION_EVENTS, access_token  );
				return loader;
			}
			return null;
		}
		
		/**
		 * Retrieves an event asynchronously via its event ID.
		 * 
		 * <p>If the request succeeds, a <code>eventLoaded</code> 
		 * Signal is dispatched containing an <code>FacebookEventData</code> 
		 * instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param event_id Event ID to retrieve
		 * 
		 * @return URLLoader Loader 
		 * 
		 * @example This example retrieves the event associated with the 
		 * specified event ID:
<listing version="3.0">
var service : FacebookEventService = new FacebookEventService();
service.eventLoaded.addOnce( onEventLoaded );
service.getEvent( access_token, "{EVENT_ID}" );
 
function onEventLoaded( vo : FacebookEventData ):void
{
	service.eventLoaded.removeAll();
}</listing>
		 */		
		public function getEvent( 
			access_token : String,
			event_id : String ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onEventLoadIOError );
				loader.addEventListener( Event.COMPLETE, onEventLoadComplete );
				
				// Call the service
				call( loader, event_id, access_token );
				return loader;
			}
			return null;
		}
		
		/**
		 * <p>Creates an event asynchronously.</p>
		 * 
		 * <p>If the request succeeds, a <code>eventCreated</code> 
		 * Signal is dispatched containing an <code>FacebookEventData</code> 
		 * instance.</p>
		 * 
		 * <p><b>Note:</b> Uploading an event photo is not yet supported 
		 * (unaware of available Facebook Graph API for such functionality). 
		 * Also, venue information does not seem to be recieved by FB and 
		 * privacy status seems to always be set to 'OPEN'.</p>
		 * 
		 * @param access_token
		 * @param event value object for creating the event 
		 * @param profile_id Profile to create to event from
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example creates an event:
<listing version="3.0">
var event : FacebookEventCreateData = new FacebookEventCreateData(
	"Crazy Party", 
	new Date(), new Date( 2010, 7, 24 ), 
	"Party description", 
	"Stockholm, Sweden", 
	"Linnegatan 89 E, Stockholm, Sweden", 
	FacebookConstants.EVENT_PRIVACY_OPEN );

var service : FacebookEventService = new FacebookEventService();
service.eventCreated.addOnce( onEventCreated );
service.createEvent( access_token, event );
 
function onEventCreated( id : String ):void
{
	service.eventCreated.removeAll();
}</listing>
		 */		
		public function createEvent( 
			access_token : String, 
			event : FacebookEventCreateData,
			profile_id : String = FacebookConstants.CONNECTION_ME ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onEventCreateIOError );
				loader.addEventListener( Event.COMPLETE, onEventCreateComplete );
				
				var data : URLVariables = new URLVariables();
				
				if( event.name )
					data.name = event.name;
				
				if( event.start_time )
					data.start_time = DateUtil.formatDate( event.start_time, "c" );
				
				if( event.end_time )
					data.end_time = DateUtil.formatDate( event.end_time, "c" );
				
				if( event.description )
					data.description = event.description;
				
				if( event.location ) 
					data.location = event.location;
				
				if( event.venue )
					data.venue = event.venue;
				
				if( event.privacy )
					data.privacy = event.privacy;
				
				// Call the service
				call( loader, profile_id + "/" + FacebookConstants.CONNECTION_EVENTS, access_token, data, URLRequestMethod.POST, FacebookConstants.API_SECURE_PATH );
				return loader;
			}
			return null;
		}
		
		/**
		 * Modify an event. 
		 * 
		 * <p>If the request succeeds, a <code>eventModified</code> 
		 * Signal is dispatched containing an <code>Boolean</code> of whether or
		 * not the modification succeeded.</p>
		 * 
		 * @param access_token
		 * @param event_id Event ID
		 * @param event value object for creating the event 
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example modifies the name of an event:
<listing version="3.0">
var event : FacebookEventCreateData = new FacebookEventCreateData( "Modified Crazy Party", null, null );

var service : FacebookEventService = new FacebookEventService();
service.eventModified.addOnce( onEventModified );
service.modifyEvent( access_token, "{EVENT_ID}", event );
 
function onEventModified( id : String ):void
{
	service.eventModified.removeAll();
}</listing>
		 */	
		public function modifyEvent( 
			access_token : String, 
			event_id : String, 
			event : FacebookEventCreateData ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onEventModifyIOError );
				loader.addEventListener( Event.COMPLETE, onEventModifyComplete );
				
				var data : URLVariables = new URLVariables();
				
				if( event.name )
					data.name = event.name;
				
				if( event.start_time )
					data.start_time = DateUtil.formatDate( event.start_time, "c" );
				
				if( event.end_time )
					data.end_time = DateUtil.formatDate( event.end_time, "c" );
				
				if( event.description )
					data.description = event.description;
				
				if( event.location ) 
					data.location = event.location;
				
				if( event.venue )
					data.venue = event.venue;
				
				if( event.privacy )
					data.privacy = event.privacy;
				
				// Call the service
				call( loader, event_id, access_token, data, URLRequestMethod.POST );
				return loader;
			}
			return null;
		}
		
		/**
		 * Return asynchronously a list of users are connected to 
		 * an event based on the status provided.
		 * 
		 * <p>The <code>status</code> property can be one of the below 
		 * values:</p>
		 * 
		 * <li><code>FacebookConstants.EVENT_STATUS_NO_REPLY</code></li>
		 * <li><code>FacebookConstants.EVENT_STATUS_MAYBE</code></li>
		 * <li><code>FacebookConstants.EVENT_STATUS_INVITED</code></li>
		 * <li><code>FacebookConstants.EVENT_STATUS_ATTENDING</code></li>
		 * <li><code>FacebookConstants.EVENT_STATUS_DECLINED</code></li>
		 * 
		 * <p>If the request succeeds, a <code>statusLoaded</code> 
		 * Signal is dispatched containing an 
		 * <code>FacebookIdentificationCollectionData</code> object.</p>
		 * 
		 * @param access_token
		 * @param event_id Event ID
		 * @param status String value of the status to request
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example gets the users related to the specified event 
		 * ID whose status is "attending":
<listing version="3.0">
var service : FacebookEventService = new FacebookEventService();
service.statusLoaded.addOnce( onStatusLoaded );
service.getStatus( access_token, "{EVENT_ID}" );
 
function onStatusLoaded( vo : FacebookIdentificationCollectionData ):void
{
	service.statusLoaded.removeAll();
}</listing>
		 */	
		public function getStatus(
			access_token : String, 
			event_id : String, 
			status : String = FacebookConstants.EVENT_STATUS_ATTENDING ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onEventStatusLoadIOError );
				loader.addEventListener( Event.COMPLETE, onEventStatusLoadComplete );
				
				// Call the service
				call( loader, event_id + "/" + status, access_token );
				return loader;
			}
			return null;
		}
		
		/**
		 * Update the current event status of the currently logged in user.
		 * 
		 * <p>The <code>status</code> property can be one of the below 
		 * values:</p>
		 * 
		 * <li><code>FacebookConstants.EVENT_STATUS_ATTENDING</code></li>
		 * <li><code>FacebookConstants.EVENT_STATUS_DECLINED</code></li>
		 * <li><code>FacebookConstants.EVENT_STATUS_MAYBE</code></li>
		 * 
		 * <p>If the request succeeds, a <code>statusUpdated</code> 
		 * Signal is dispatched containing an <code>Boolean</code> object 
		 * whether or not the update succeeded.</p>
		 * 
		 * @param access_token
		 * @param event_id Event ID
		 * @param status String value of the status to update
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example updates the current logged in users status to
		 * "attending" for the specified event:
<listing version="3.0">
var service : FacebookEventService = new FacebookEventService();
service.statusUpdated.addOnce( onStatusUpdated );
service.updateStatus( access_token, "{EVENT_ID}" );
 
function onStatusUpdated( vo : FacebookIdentificationCollectionData ):void
{
	service.statusUpdated.removeAll();
}</listing>
		 */	
		public function updateStatus(
			access_token : String, 
			event_id : String, 
			status : String = FacebookConstants.EVENT_STATUS_ATTENDING ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onEventStatusUpdateIOError );
				loader.addEventListener( Event.COMPLETE, onEventStatusUpdateComplete );
				
				// Call the service
				call( loader, event_id + "/" + status, access_token, null, URLRequestMethod.POST );
				return loader;
			}
			return null;
		}
		
		//---------------------------------------------------------------------
		//
		//  Private methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		/**
		 * @private
		 * Callback for when the events load request completes
		 * 
		 * @param event <code>Event.COMPLETE</code>
		 */		
		private function onEventsLoadComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onEventsLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onEventsLoadComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			
			var vo : FacebookEventCollectionData = new FacebookEventCollectionData( json_data );
			eventsLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private 
		 * Callback for when the events load request errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code>
		 */		
		private function onEventsLoadIOError( event : IOErrorEvent ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onEventsLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onEventsLoadComplete );
			
			errored.dispatch( loader.data );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the event load request completes
		 * 
		 * @param event <code>Event.COMPLETE</code>
		 */		
		private function onEventLoadComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onEventLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onEventLoadComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			
			var vo : FacebookEventData = new FacebookEventData( json_data );
			eventLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private 
		 * Callback for when the event load request errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code>
		 */		
		private function onEventLoadIOError( event : IOErrorEvent ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onEventLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onEventLoadComplete );
			
			errored.dispatch( loader.data );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the event create request completes
		 * 
		 * @param event <code>Event.COMPLETE</code>
		 */		
		private function onEventCreateComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onEventCreateIOError );
			loader.removeEventListener( Event.COMPLETE, onEventCreateComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			eventCreated.dispatch( String( json_data.id ) );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private 
		 * Callback for when the event create request errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code>
		 */		
		private function onEventCreateIOError( event : IOErrorEvent ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onEventCreateIOError );
			loader.removeEventListener( Event.COMPLETE, onEventCreateComplete );
			
			errored.dispatch( loader.data );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the event modify request completes
		 * 
		 * @param event <code>Event.COMPLETE</code>
		 */		
		private function onEventModifyComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onEventModifyIOError );
			loader.removeEventListener( Event.COMPLETE, onEventModifyComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			eventModified.dispatch( Boolean( json_data.id ) );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private 
		 * Callback for when the event modify request errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code>
		 */		
		private function onEventModifyIOError( event : IOErrorEvent ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onEventModifyIOError );
			loader.removeEventListener( Event.COMPLETE, onEventModifyComplete );
			
			errored.dispatch( loader.data );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the event status load request completes
		 * 
		 * @param event <code>Event.COMPLETE</code>
		 */		
		private function onEventStatusLoadComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onEventStatusLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onEventStatusLoadComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			var vo : FacebookIdentificationCollectionData = new FacebookIdentificationCollectionData( json_data.data );
			statusLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private 
		 * Callback for when the event status load request errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code>
		 */		
		private function onEventStatusLoadIOError( event : IOErrorEvent ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onEventStatusLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onEventStatusLoadComplete );
			
			errored.dispatch( loader.data );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the event status update request completes
		 * 
		 * @param event <code>Event.COMPLETE</code>
		 */		
		private function onEventStatusUpdateComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onEventStatusUpdateIOError );
			loader.removeEventListener( Event.COMPLETE, onEventStatusUpdateComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			statusUpdated.dispatch( json_data );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private 
		 * Callback for when the event status update request errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code>
		 */		
		private function onEventStatusUpdateIOError( event : IOErrorEvent ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onEventStatusUpdateIOError );
			loader.removeEventListener( Event.COMPLETE, onEventStatusUpdateComplete );
			
			errored.dispatch( loader.data );
			
			// NULL the loader
			loader = null;
		}
	}
}