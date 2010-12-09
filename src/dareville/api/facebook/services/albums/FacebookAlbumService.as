package dareville.api.facebook.services.albums
{
	import dareville.api.facebook.FacebookConstants;
	import dareville.api.facebook.data.albums.FacebookAlbumCollectionData;
	import dareville.api.facebook.data.albums.FacebookAlbumCreateData;
	import dareville.api.facebook.data.albums.FacebookAlbumData;
	import dareville.api.facebook.services.common.AbstractFacebookService;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import org.osflash.signals.Signal;
	
	/**
	 * The <code>FacebookAlbumsService</code> class provides access to album
	 * data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookAlbumService 
		extends AbstractFacebookService
	{
		//----------------------------------
		//  Signals
		//----------------------------------
		
		/**
		 * Signal dispatched when the albums call has loaded. Dispatches a
		 * <code>FacebookAlbumCollectionData</code> as a parameter.
		 */		
		public var albumsLoaded : Signal = new Signal( FacebookAlbumCollectionData );
		
		/**
		 * Signal dispatched when the album call has loaded. Dispatches a
		 * <code>FacebookAlbumData</code> as a parameter.
		 */		
		public var albumLoaded : Signal = new Signal( FacebookAlbumData );
		
		/**
		 * Signal dispatched when the create album call has completed. 
		 * Dispatches a <code>String</code> as a parameter.
		 */		
		public var albumCreated : Signal = new Signal( String );
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Retrieves data asynchronously for all albums associated with a 
		 * user/page. The album data returned maybe not include all information 
		 * associated to a  specific album, to access that information call 
		 * <code>getAlbum</code> method instead with a specific album ID. 
		 * 
		 * <p>This method will also not return any photo information, as that 
		 * API is seperated within Facebook APIs. To retrieve photo information, 
		 * see the <code>FacebookPhotoService</code>.</p>
		 * 
		 * <p>If the request succeeds, a <code>albumsLoaded</code> Signal is 
		 * dispatched containing an <code>FacebookAlbumCollectionData</code> 
		 * instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param page_id Page ID to request
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example retrieves all albums related to the currently
		 * logged in user:
<listing version="3.0">
var service : FacebookAlbumService = new FacebookAlbumService();
service.albumsLoaded.addOnce( onAlbumsLoaded );
service.getAlbums( access_token );
 
function onAlbumsLoaded( vo : FacebookAlbumCollectionData ):void
{
	service.albumsLoaded.removeAll();
}</listing>
		 */		
		public function getAlbums( 
			access_token : String, 
			page_id : String = FacebookConstants.CONNECTION_ME ) : URLLoader
		{
			var loader : URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener( IOErrorEvent.IO_ERROR, onAlbumsLoadIOError, false, 0, true );
			loader.addEventListener( Event.COMPLETE, onAlbumsLoadComplete, false, 0, true );
				
			// Call the service
			call( loader, page_id + "/" + FacebookConstants.CONNECTION_ALBUMS, access_token  );
			return loader;
		}
		
		/**
		 * Retrieves an album asynchronously via its ID and returns detailed 
		 * album data. 
		 * 
		 * <p>This method will not return any photo information contained within 
		 * the album, as that API is seperated within the Facebook APIs. To 
		 * retrieve photo information, view the 
		 * <code>FacebookPhotoService</code>.</p>
		 * 
		 * <p>If the request succeeds, a <code>albumLoaded</code> Signal is 
		 * dispatched containing an <code>FacebookAlbumData</code> instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param album_id Album ID to request
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example retrieves an albums based on the specified
		 * album ID:
<listing version="3.0">
var service : FacebookAlbumService = new FacebookAlbumService();
service.albumLoaded.addOnce( onAlbumLoaded );
service.getAlbum( access_token );
 
function onAlbumLoaded( vo : FacebookAlbumData ):void
{
	service.albumLoaded.removeAll();
}</listing>
		 */		
		public function getAlbum( 
			access_token : String, 
			album_id : String ) : URLLoader
		{
			var loader : URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener( IOErrorEvent.IO_ERROR, onAlbumLoadIOError, false, 0, true );
			loader.addEventListener( Event.COMPLETE, onAlbumLoadComplete, false, 0, true );
				
			// Call the service
			call( loader, album_id, access_token  );
			return loader;
		}
		
		/**
		 * Creates an album asynchronously
		 * 
		 * <p>If the request succeeds, a <code>albumCreated</code> Signal is 
		 * dispatched containing an ID <code>String</code>.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param album Create album value object
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example creates an album:
<listing version="3.0">
var album : FacebookAlbumCreateData = new FacebookAlbumCreateData( "Album title", "Album description" )
var service : FacebookAlbumService = new FacebookAlbumService();
service.albumCreated.addOnce( onAlbumCreated );
service.createAlbum( access_token, album );
function onAlbumCreated( id : String ):void
{
	service.albumCreated.removeAll();
}</listing>
		 */		
		public function createAlbum( 
			access_token : String, 
			album : FacebookAlbumCreateData ) : URLLoader
		{
			var loader : URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener( IOErrorEvent.IO_ERROR, onCreateAlbumIOError );
			loader.addEventListener( Event.COMPLETE, onCreateAlbumLoadComplete );
			
			var data : URLVariables = new URLVariables();
			data.name = album.name;
			data.description = album.description;
			
			// Call the service
			call( loader, FacebookConstants.CONNECTION_ME + "/" + FacebookConstants.CONNECTION_ALBUMS, access_token, data, URLRequestMethod.POST );
			return loader;
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
		 * Callback for when the albums load IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */		
		private function onAlbumsLoadIOError( event : IOErrorEvent ) : void
		{
			// Get the loader and remove any event listeners first
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onAlbumsLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onAlbumsLoadComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the albums load completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */	
		private function onAlbumsLoadComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onAlbumsLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onAlbumsLoadComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			
			var vo : FacebookAlbumCollectionData = new FacebookAlbumCollectionData( json_data );
			albumsLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the album load completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */	
		private function onAlbumLoadComplete( event : Event ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onAlbumLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onAlbumLoadComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			
			var vo : FacebookAlbumData = new FacebookAlbumData( json_data );
			albumLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the album load IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */		
		private function onAlbumLoadIOError( event : IOErrorEvent ) : void
		{
			// Get the loader and remove any event listeners first
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onAlbumLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onAlbumLoadComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the create album completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */	
		private function onCreateAlbumLoadComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onCreateAlbumIOError );
			loader.removeEventListener( Event.COMPLETE, onCreateAlbumLoadComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			albumCreated.dispatch( String( json_data.id ) );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the album IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */	
		private function onCreateAlbumIOError( event : IOErrorEvent ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onCreateAlbumIOError );
			loader.removeEventListener( Event.COMPLETE, onCreateAlbumLoadComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
	}
}