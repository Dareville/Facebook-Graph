package dareville.api.facebook.services.common
{
	import com.adobe.serialization.json.JSON;
	
	import dareville.api.facebook.FacebookConstants;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import org.osflash.signals.ISignalOwner;
	import org.osflash.signals.Signal;
	
	/**
	 * The <code>AbstractFacebookService</code> class provides abstract
	 * access to data. This class should be overriden to provide specific access 
	 * to different types of data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class AbstractFacebookService
	{
		//----------------------------------
		//  Signals
		//----------------------------------
		
		/**
		 * Signal dispatched when a service has errored. Dispatches a
		 * <code>String</code> as a parameter.
		 */		
		public var errored : ISignalOwner = new Signal( String );
		
		/**
		 * Signal dispatched when a service has loaded multiple IDs via the 
		 * <code>callMultiple</code> method. Dispatches an 
		 * <code>Object</code> as a parameter.
		 */		
		public var multipleLoaded : ISignalOwner = new Signal( Object );
		
		/**
		 * Signal dispatched when a service has deleted an item. Dispatches a
		 * <code>Boolean</code> as a parameter.
		 */		
		public var deleted : ISignalOwner = new Signal( Boolean );
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function AbstractFacebookService()
		{
		}
		
		/**
		 * Abstract method to call a Facebook service. This method is provided
		 * so that developers can make undocumented calls or calls that might
		 * not yet be available within this API.
		 * 
		 * @param loader URLLoader to load with
		 * @param path The Facebook path to retrieve
		 * @param access_token The sessions access token
		 * @param data Any additional variables that need to be passed
		 * @param method GET/POST method
		 * @param api_path Specified path to the Facebook secure/unsecure URIs
		 * 
		 * @return Boolean
		 */		
		public function call( 
			loader : URLLoader,
			path : String,
			access_token : String,
			data : URLVariables = null,
			method : String = null,
			api_path : String = FacebookConstants.API_SECURE_PATH,
			metadata : Boolean = true ) : Boolean
		{	
			// If no data is provided, create a new instance and assign
			// access token
			data = data || new URLVariables();
			data.metadata = ( metadata ) ? 1 : 0;
			if( access_token && 
				access_token.length > 1 )
			{
				data.access_token = access_token;
			}
			
			// If no method is provided, set to the default GET request method
			method = method || URLRequestMethod.GET;
			
			// Create the URL and the request
			var url : String = api_path;
			if( path )
			{
				url += path;
			}
			
			var request : URLRequest = new URLRequest( url );
			request.data = data;
			request.method = method;
			
			// Load the request
			loader.load( request );
			return true;
		}
		
		/**
		 * Calls multiple IDs at the same time. Returns the data as an 
		 * unformatted object.
		 * 
		 * <p>If the request succeeds, a <code>multipleLoaded</code> Signal is 
		 * dispatched containing an <code>Object</code>.</p>
		 * 
		 * @param access_token The sessions access token
		 * @param ids Facebook IDs the request
		 *
		 * @return URLLoader
		 * 
		 * @example This example retrieves 2 IDs from Facebook in the same 
		 * request. The listener method then formats one of the IDs to 
		 * <code>FacebookUserData</code>
		 * <listing version="3.0">
var service : FacebookUserService = new FacebookUserService();
service.multipleLoaded.addOnce( onMultipleLoaded );
service.callMultiple( access_token, ["btaylor","cocacola"] );
function onMultipleLoaded( vo : Object ):void
{
	var user : FacebookUserData = new FacebookUserData( vo.btaylor );
}
</listing>
		 */		
		public function callMultiple(
			access_token : String,
			ids : Array ) : URLLoader
		{
			var loader : URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener( IOErrorEvent.IO_ERROR, onCallMultipleIOError, false, 0, true );
			loader.addEventListener( Event.COMPLETE, onCallMultipleComplete, false, 0, true );
			
			var data : URLVariables = new URLVariables();
			if( ids )
			{
				data.ids = ids.join( "," );
			}
			
			// Call the service
			call( loader, "", access_token, data );
			return loader;
		}	
		
		/**
		 * Deletes data asynchronously as long as the logged in user has access
		 * to delete the specified item.
		 * 
		 * <p>If the request succeeds, a <code>deleted</code> Signal is 
		 * dispatched containing a <code>Boolean</code> object.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param item Item ID to delete
		 * 
		 * @return URLLoader Loader
		 */		
		public function deleteItem( 
			access_token : String, 
			item : String ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onDeleteIOError, false, 0, true );
				loader.addEventListener( Event.COMPLETE, onDeleteComplete, false, 0, true );
				
				var data : URLVariables = new URLVariables();
				data.method = FacebookConstants.DELETE;
				
				// Call the service
				call( loader, item, access_token, data, URLRequestMethod.POST );
				return loader;
			}
			return null;
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 * Decode data received from a service. This decodes a JSON string into
		 * an object. If the JSON string is invalide, it will dispatch an
		 * <code>errored</code> Signal.
		 * 
		 * @param data String value of all the data to decode
		 * @return JSON encoded object 
		 */		
		protected function decodeData( data : String ) : Object
		{
			// Attempt to decode the JSON data and create the value object
			var json_data : Object;
			try
			{
				json_data = JSON.decode( data );
			}
			// JSON was invalid so dispatch an error
			catch( error : Error )
			{
				errored.dispatch();
				return null;
			}
			
			return json_data;
		}
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		/**
		 * @private
		 * Callback for when the delete request completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */		
		protected function onDeleteComplete( event : Event ) : void
		{
			// Get the loader and remove any event listeners first
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onDeleteIOError );
			loader.removeEventListener( Event.COMPLETE, onDeleteComplete );
			
			var json_data : Object = decodeData( loader.data );
			deleted.dispatch( Boolean( json_data ) );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the delete request IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */	
		protected function onDeleteIOError( event : IOErrorEvent ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onDeleteIOError );
			loader.removeEventListener( Event.COMPLETE, onDeleteComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the multiple requests call completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */
		protected function onCallMultipleComplete( event : Event ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onCallMultipleIOError );
			loader.removeEventListener( Event.COMPLETE, onCallMultipleComplete );
			
			var json_data : Object = decodeData( loader.data );
			multipleLoaded.dispatch( json_data );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the multiple requests IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */
		protected function onCallMultipleIOError( event : IOErrorEvent ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onCallMultipleIOError );
			loader.removeEventListener( Event.COMPLETE, onCallMultipleComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
	}
}