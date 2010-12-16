package dareville.api.facebook.services.common
{
	import dareville.api.facebook.FacebookConstants;
	import dareville.api.facebook.data.feed.FacebookFeedCollectionData;
	import dareville.api.facebook.data.feed.FacebookFeedCreatePostData;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	
	import org.osflash.signals.ISignalOwner;
	import org.osflash.signals.Signal;

	/**
	 * The <code>AbstractFacebookProfileService</code> class provides base 
	 * access to profile data. This class should be overriden to provide access 
	 * to specific data like users/groups/pages/applications/etc.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class AbstractFacebookProfileService 
		extends AbstractFacebookService
	{
		//----------------------------------
		//  Signals
		//----------------------------------
		
		/**
		 * Signal dispatched when a profile has loaded.
		 */		
		public var profileLoaded : ISignalOwner = getProfileLoadedSignal();
		
		/**
		 * Signal dispatched when a profile feed has loaded.
		 */		
		public var profileFeedLoaded : ISignalOwner = getProfileFeedLoadedSignal();
		
		/**
		 * Signal dispatched when a profile photo has loaded.
		 */		
		public var profilePhotoLoaded : ISignalOwner = getProfilePhotoLoadedSignal();
		
		/**
		 * Signal dispatched when a wall post message or link is created. 
		 * Dispatches a <code>String</code> as a parameter. 
		 */		
		public var wallPostCreated : ISignalOwner = new Signal( String );
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Retrieves data asynchronously from a profile associated with a 
		 * user/page/etc. 
		 * 
		 * <p>This methods protected callback <code>onProfileLoadComplete</code> 
		 * should be overriden to return a specific type of data.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param page_id Page ID to request
		 * 
		 * @return URLLoader Loader
		 */	
		public function getProfile( access_token : String, page_id : String ) : URLLoader
		{
			var loader : URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener( IOErrorEvent.IO_ERROR, onProfileLoadIOError, false, 0, true );
			loader.addEventListener( Event.COMPLETE, onProfileLoadComplete );				
				
			// Call the service
			call( loader, page_id, access_token );
			return loader;
		}
		
		/**
		 * Retrieves feed data asynchronously that is associated with a 
		 * user/page/etc.
		 * 
		 * <p>If the request succeeds, the <code>profileFeedLoaded</code> 
		 * Signal is dispatched containing an <code>FacebookFeedData</code> 
		 * instance</p>
		 * 
		 * @param access_token Facebook access token
		 * @param page_id Page ID to request
		 * 
		 * @return URLLoader Loader
		 */
		public function getFeed( access_token : String, page_id : String ) : URLLoader
		{
			var loader : URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener( IOErrorEvent.IO_ERROR, onFeedLoadIOError, false, 0, true );
			loader.addEventListener( Event.COMPLETE, onFeedLoadComplete, false, 0, true );
			
			// Call the service
			call( loader, page_id + "/" + FacebookConstants.CONNECTION_FEED, access_token );
			return loader;
		}
		
		/**
		 * Retrieve the profile picture asynchronously of the provided page ID.
		 * 
		 * <p>If the request succeeds, the <code>profilePhotoLoaded</code> 
		 * Signal is dispatched containing an <code>DisplayObject</code> 
		 * instance.</p>
		 * 
		 * <p>If a SecurityErrorEvent is returned from Facebook (aka. the 
		 * default Facebook profile photo is being loaded), a 
		 * <code>profilePhotoLoaded</code> Signal is now dispatched instead with 
		 * a null DisplayObject as its parameter. Facebook will hopefully put 
		 * the default profile photo image on a server with crossdomain access 
		 * as this is just a temporary fix.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param page_id String value of the page ID
		 * @param type Size of the image returned
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example gets the currently logged in users 
		 * profile picture in the large size:
<listing version="3.0">
var service : FacebookUserService = new FacebookUserService();
service.profilePhotoLoaded.addOnce( onProfilePhotoLoad );
service.getProfilePicture( access_token, FacebookConstants.CONNECTION_ME, FacebookConstants.SIZE_LARGE );
 
function onProfilePhotoLoad( photo : DisplayObject ) : void
{
	service.profilePhotoLoaded.removeAll();
	addChild( photo );
}</listing>
		 */		
		public function getProfilePicture( 
			access_token : String, 
			page_id : String,
			type : String = FacebookConstants.SIZE_SQUARE ) : URLLoader
		{
			var loader : URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onProfilePictureSecurityError, false, 0, true );
			loader.addEventListener( IOErrorEvent.IO_ERROR, onProfilePictureLoadIOError, false, 0, true );
			loader.addEventListener( Event.COMPLETE, onProfilePictureLoadComplete, false, 0, true );
			
			// Call the service
			var path : String = page_id + "/" + FacebookConstants.CONNECTION_PICTURE + "?type=" + type + "&";
			call( loader, path, access_token, null, null, FacebookConstants.API_SECURE_PATH, false );
			return loader;
		}
		
		/**
		 * Posts a message to a pages wall feed.
		 * 
		 * <p>If the request succeeds, a <code>wallPostCreated</code> Signal is 
		 * dispatched containing a <code>String</code> of the post ID.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param page_id String value of the page ID
		 * @param post Post value object
		 * 
		 * @example This example posts a link on the currently logged in 
		 * users wall:
<listing version="3.0">
var post : FacebookFeedCreatePostData = new FacebookFeedCreatePostData( "Check this out!", "http://www.rftc.com/" );
 
var service : FacebookUserService = new FacebookUserService();
service.wallPostCreated.addOnce( onWallPostCreated );
service.createWallPost( access_token, FacebookConstants.CONNECTION_ME, post );
 
function onWallPostCreated( id : String ):void
{
	service.wallPostCreated.removeAll();
}</listing>
		 */
		public function createWallPost( 
			access_token : String, 
			page_id : String,
			post : FacebookFeedCreatePostData ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onCreateWallPostIOError, false, 0, true );
				loader.addEventListener( Event.COMPLETE, onCreateWallPost );
				
				var data : URLVariables = new URLVariables();
				if( post.message )
					data.message = post.message;
				
				if( post.picture )
					data.picture = post.picture;
				
				if( post.link )
					data.link = post.link;
				
				if( post.name ) 
					data.name = post.name;
				
				if( post.caption )
					data.caption = post.caption;
				
				if( post.description )
					data.description = post.description;
				
				if( post.source )
					data.source = post.source;
				
				// Call the service
				var path : String = page_id + "/" + FacebookConstants.CONNECTION_FEED;
				call( loader, path, access_token, data, URLRequestMethod.POST );
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
		 * Retrieves the signal for when the profile is loaded
		 * 
		 * @return Signal 
		 */		
		protected function getProfileLoadedSignal() : ISignalOwner
		{
			return new Signal( Object );
		}
		
		/**
		 * @private
		 * Retrieves the signal for when the profile feed is loaded
		 * 
		 * @return Signal 
		 */	
		protected function getProfileFeedLoadedSignal() : ISignalOwner
		{
			return new Signal( FacebookFeedCollectionData );
		}
		
		/**
		 * @private
		 * Retrieves the signal for when the profile photo is loaded
		 * 
		 * @return Signal 
		 */	
		protected function getProfilePhotoLoadedSignal() : ISignalOwner
		{
			return new Signal( DisplayObject );
		}
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		/**
		 * @private
		 * Callback for when the profile call has loaded
		 * 
		 * @param event <code>Event.COMPLETE</code>
		 */		
		protected function onProfileLoadComplete( event : Event ) : void
		{
			// Get the loader and remove any event listeners first
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onProfileLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onProfileLoadComplete );
			
			var json_data : Object = decodeData( loader.data );
			profileLoaded.dispatch( json_data );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the profile call has IO errored
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */	
		protected function onProfileLoadIOError( event : IOErrorEvent ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onProfileLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onProfileLoadComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when a user/page feed is loaded
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */		
		protected function onFeedLoadComplete( event : Event ) : void
		{
			// Get the loader and remove any event listeners first
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onFeedLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onFeedLoadComplete );
			
			var json_data : Object = decodeData( loader.data );
			
			// Create the value object and dispatch the event;
			var vo : FacebookFeedCollectionData = new FacebookFeedCollectionData( json_data );
			profileFeedLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when a user/page feed IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */	
		protected function onFeedLoadIOError( event : IOErrorEvent ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onFeedLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onFeedLoadComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the profile picture load completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */		 
		protected function onProfilePictureLoadComplete( event : Event ) : void
		{
			// Get the loader and remove any event listeners first
			var url_loader : URLLoader = event.target as URLLoader;
			url_loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onProfilePictureSecurityError );
			url_loader.removeEventListener( IOErrorEvent.IO_ERROR, onProfilePictureLoadIOError );
			url_loader.removeEventListener( Event.COMPLETE, onProfilePictureLoadComplete );
			
			// Cast the data as a byte array and load the bytes in a
			// bitmap object
			var byte_array : ByteArray = url_loader.data as ByteArray;
			var loader : Loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onProfilePictureParseComplete, false, 0, true );
			loader.loadBytes( byte_array );
			
			// Local function for parsing the profile picture load data in
			// a format we can add to the display list
			function onProfilePictureParseComplete( event : Event ) : void
			{
				loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onProfilePictureParseComplete );
				
				// Dispatch signal of the display object loaded
				profilePhotoLoaded.dispatch( loader.content );
				
				// Null the loader and url loaders
				loader = null;
				url_loader = null;
			}
		}
		
		/**
		 * @private
		 * Callback for when the profile picture load IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */	
		protected function onProfilePictureLoadIOError( event : IOErrorEvent ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onProfilePictureSecurityError );
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onProfilePictureLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onProfilePictureLoadComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the profile picture load security errors
		 * 
		 * @param event <code>SecurityErrorEvent.SECURITY_ERROR</code> 
		 */	
		protected function onProfilePictureSecurityError( event : SecurityErrorEvent ):void	
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onProfilePictureSecurityError );
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onProfilePictureLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onProfilePictureLoadComplete );
			
			// Dispatch signal of but without a display object
			// Note: 2010/12/13 - This is due to Facebook not having a 
			// crossdomain.xml file on the server that allows unapproved 
			// FB hosts.
			profilePhotoLoaded.dispatch( null );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the create wall post completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */	
		protected function onCreateWallPost( event : Event ) : void
		{
			// Get the loader and remove any event listeners first
			var url_loader : URLLoader = event.target as URLLoader;
			url_loader.removeEventListener( IOErrorEvent.IO_ERROR, onCreateWallPostIOError );
			url_loader.removeEventListener( Event.COMPLETE, onCreateWallPost );
			
			var json_data : Object = decodeData( url_loader.data );
			wallPostCreated.dispatch( json_data.id );
		}
		
		/**
		 * @private
		 * Callback for when the create wall post IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */	
		protected function onCreateWallPostIOError( event : IOErrorEvent ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onCreateWallPostIOError );
			loader.removeEventListener( Event.COMPLETE, onCreateWallPost );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
	}
}