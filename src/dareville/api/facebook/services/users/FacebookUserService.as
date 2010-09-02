package dareville.api.facebook.services.users
{
	import dareville.api.facebook.FacebookConstants;
	import dareville.api.facebook.data.common.FacebookIdentificationCollectionData;
	import dareville.api.facebook.data.feed.FacebookFeedCollectionData;
	import dareville.api.facebook.data.users.FacebookBookCollectionData;
	import dareville.api.facebook.data.users.FacebookMovieCollectionData;
	import dareville.api.facebook.data.users.FacebookMusicCollectionData;
	import dareville.api.facebook.data.users.FacebookUserData;
	import dareville.api.facebook.services.common.AbstractFacebookProfileService;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	
	import org.osflash.signals.Signal;
	
	/**
	 * The <code>FacebookUserService</code> class provides access to user
	 * data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookUserService 
		extends AbstractFacebookProfileService
	{	
		//----------------------------------
		//  Signals
		//----------------------------------
		
		/**
		 * Signal dispatched when the logged in users news feed has loaded. 
		 * Dispatches a <code>FacebookFeedCollectionData</code> as a parameter.  
		 */	
		public var newsFeedLoaded : Signal = new Signal( FacebookFeedCollectionData );
		
		/**
		 * Signal dispatched when a users friends data has loaded. Dispatches a
		 * <code>FacebookIdentificationCollectionData</code> as a parameter. 
		 */	
		public var friendsLoaded : Signal = new Signal( FacebookIdentificationCollectionData );
		
		/**
		 * Signal dispatched when a users movies data has loaded. Dispatches a
		 * <code>FacebookMovieCollectionData</code> as a parameter. 
		 */	
		public var moviesLoaded : Signal = new Signal( FacebookMovieCollectionData );
		
		/**
		 * Signal dispatched when a users music data has loaded. Dispatches a
		 * <code>FacebookMusicCollectionData</code> as a parameter. 
		 */	
		public var musicLoaded : Signal = new Signal( FacebookMusicCollectionData );
		
		/**
		 * Signal dispatched when a users books data has loaded. Dispatches a
		 * <code>FacebookBookCollectionData</code> as a parameter. 
		 */	
		public var booksLoaded : Signal = new Signal( FacebookBookCollectionData );
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Retrieves a users news feed. Facebook only allows for an application
		 * to retrieve the current logged in users news feed, so the only 
		 * parameter is a current <code>access_token</code>.
		 * 
		 * <p>If the request succeeds, a <code>newsFeedLoaded</code> 
		 * Signal is dispatched containing an 
		 * <code>FacebookFeedCollectionData</code> instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param user_id User ID
		 * 
		 * @return URLLoader Loader 
		 * 
		 * @example This example retrieves the news feed of the current logged 
		 * in user:
<listing version="3.0">
var service : FacebookUserService = new FacebookUserService();
service.newsFeedLoaded.addOnce( onNewsFeedLoad );
service.getNewsFeed( access_token );
 
function onNewsFeedLoad( vo : FacebookFeedCollectionData ):void
{
	service.newsFeedLoaded.removeAll();
}</listing>
		 */
		public function getNewsFeed( access_token : String ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onNewsFeedLoadIOError, false, 0, true );
				loader.addEventListener( Event.COMPLETE, onNewsFeedLoadComplete, false, 0, true );
				
				// Call the service
				call( loader, FacebookConstants.CONNECTION_ME + "/" + FacebookConstants.CONNECTION_HOME, access_token );
				return loader;
			}
			return null;
		}
		
		/**
		 * Retrieves friends of the specified user. Facebook only allows for the 
		 * lookup of the currently logged in user or friends of the currenlty
		 * logged in user with the appropriate permissions.
		 * 
		 * <p>If the request succeeds, a <code>friendsLoaded</code> 
		 * Signal is dispatched containing an 
		 * <code>FacebookIdentificationCollectionData</code> instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param user_id User ID
		 * 
		 * @return URLLoader Loader 
		 * 
		 * @example This example retrieves the news feed of the current logged 
		 * in user:
<listing version="3.0">
var service : FacebookUserService = new FacebookUserService();
service.friendsLoaded.addOnce( onFriendsLoad );
service.getFriends( access_token );
 
function onFriendsLoad( vo : FacebookIdentificationCollectionData ):void
{
	service.friendsLoaded.removeAll();
}</listing>
		 */
		public function getFriends( 
			access_token : String, 
			user_id : String = FacebookConstants.CONNECTION_ME ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onFriendsLoadIOError, false, 0, true );
				loader.addEventListener( Event.COMPLETE, onFriendsLoadComplete, false, 0, true );
				
				// Call the service
				call( loader, user_id + "/" + FacebookConstants.CONNECTION_FRIENDS, access_token );
				return loader;
			}
			return null;
		}
		
		/**
		 * Retrieves movies interests of the specified user.
		 * 
		 * <p>If the request succeeds, a <code>moviesLoaded</code> 
		 * Signal is dispatched containing an 
		 * <code>FacebookMovieCollectionData</code> instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param user_id User ID
		 * 
		 * @return URLLoader Loader 
		 * 
		 * @example This example retrieves the liked movies of the current 
		 * logged in user:
<listing version="3.0">
var service : FacebookUserService = new FacebookUserService();
service.moviesLoaded.addOnce( onMoviesLoad );
service.getMovies( access_token );
 
function onMoviesLoad( vo : FacebookMovieCollectionData ):void
{
	service.moviesLoaded.removeAll();
}</listing>
		 */
		public function getMovies(
			access_token : String, 
			user_id : String = FacebookConstants.CONNECTION_ME ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onMoviesLoadIOError, false, 0, true );
				loader.addEventListener( Event.COMPLETE, onMoviesLoadComplete, false, 0, true );
				
				// Call the service
				call( loader, user_id + "/" + FacebookConstants.CONNECTION_MOVIES, access_token );
				return loader;
			}
			return null;
		}
		
		/**
		 * Retrieves music interests of the specified user.
		 * 
		 * <p>If the request succeeds, a <code>musicLoaded</code> 
		 * Signal is dispatched containing an 
		 * <code>FacebookMusicCollectionData</code> instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param user_id User ID
		 * 
		 * @return URLLoader Loader 
		 * 
		 * @example This example retrieves the liked movies of the current 
		 * logged in user:
<listing version="3.0">
var service : FacebookUserService = new FacebookUserService();
service.musicLoaded.addOnce( onMusicLoad );
service.getMusic( access_token );
 
function onMusicLoad( vo : FacebookMusicCollectionData ):void
{
	service.musicLoaded.removeAll();
}</listing>
		 */
		public function getMusic(
			access_token : String, 
			user_id : String = FacebookConstants.CONNECTION_ME ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onMusicLoadIOError, false, 0, true );
				loader.addEventListener( Event.COMPLETE, onMusicLoadComplete, false, 0, true );
				
				// Call the service
				call( loader, user_id + "/" + FacebookConstants.CONNECTION_MUSIC, access_token );
				return loader;
			}
			return null;
		}
		
		/**
		 * Retrieves books interests of the specified user.
		 * 
		 * <p>If the request succeeds, a <code>booksLoaded</code> 
		 * Signal is dispatched containing an 
		 * <code>FacebookBookCollectionData</code> instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param user_id User ID
		 * 
		 * @return URLLoader Loader 
		 * 
		 * @example This example retrieves the liked books of the current 
		 * logged in user:
<listing version="3.0">
var service : FacebookUserService = new FacebookUserService();
service.booksLoaded.addOnce( onBooksLoad );
service.getBooks( access_token );
 
function onBooksLoad( vo : FacebookBookCollectionData ):void
{
	service.booksLoaded.removeAll();
}</listing>
		 */
		public function getBooks(
			access_token : String, 
			user_id : String = FacebookConstants.CONNECTION_ME ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onBooksLoadIOError, false, 0, true );
				loader.addEventListener( Event.COMPLETE, onBooksLoadComplete, false, 0, true );
				
				// Call the service
				call( loader, user_id + "/" + FacebookConstants.CONNECTION_BOOKS, access_token );
				return loader;
			}
			return null;
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * Retrieves data asynchronously from a profile associated with a 
		 * user.
		 * 
		 * <p>If the request succeeds, a <code>profileLoaded</code> 
		 * Signal is dispatched containing an 
		 * <code>FacebookUserData</code> instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param user_id User ID to request
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example retrieves the liked books of the current 
		 * logged in user:
<listing version="3.0">
var service : FacebookUserService = new FacebookUserService();
service.profileLoaded.addOnce( onProfileLoad );
service.getProfile( access_token, FacebookConstants.CONNECTION_ME );
 
function onProfileLoad( vo : FacebookUserData ):void
{
	service.profileLoaded.removeAll();
}</listing>
		 */	
		override public function getProfile( 
			access_token : String, 
			user_id : String ) : URLLoader
		{
			return super.getProfile( access_token, user_id );
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @private
		 */	
		override protected function getProfileLoadedSignal():Signal
		{
			return new Signal( FacebookUserData );
		}
		
		/**
		 * @private
		 */		
		override protected function onProfileLoadComplete( event : Event ) : void
		{
			// Get the loader and remove any event listeners first
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onProfileLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onProfileLoadComplete );
			
			var json_data : Object = decodeData( loader.data );
			
			// Create the value object and dispatch the event;
			var vo : FacebookUserData = new FacebookUserData( json_data );
			profileLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
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
		 * Callback for when the news feed load completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */		
		private function onNewsFeedLoadComplete( event : Event ) : void
		{
			// Get the loader and remove any event listeners first
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onNewsFeedLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onNewsFeedLoadComplete );
			
			var json_data : Object = decodeData( loader.data );
			
			var vo : FacebookFeedCollectionData = new FacebookFeedCollectionData( json_data );
			newsFeedLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the news feed load IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */	
		private function onNewsFeedLoadIOError( event : IOErrorEvent ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onNewsFeedLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onNewsFeedLoadComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the friends load completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */		
		private function onFriendsLoadComplete( event : Event ) : void
		{
			// Get the loader and remove any event listeners first
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onFriendsLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onFriendsLoadComplete );
			
			var json_data : Object = decodeData( loader.data );
			
			var vo : FacebookIdentificationCollectionData = new FacebookIdentificationCollectionData( json_data.data );
			friendsLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the friends load IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */	
		private function onFriendsLoadIOError( event : IOErrorEvent ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onFriendsLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onFriendsLoadComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the movies load completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */		
		private function onMoviesLoadComplete( event : Event ) : void
		{
			// Get the loader and remove any event listeners first
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onMoviesLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onMoviesLoadComplete );
			
			var json_data : Object = decodeData( loader.data );
			
			var vo : FacebookMovieCollectionData = new FacebookMovieCollectionData( json_data );
			moviesLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the movies load IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */	
		private function onMoviesLoadIOError( event : IOErrorEvent ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onMoviesLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onMoviesLoadComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the music load completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */		
		private function onMusicLoadComplete( event : Event ) : void
		{
			// Get the loader and remove any event listeners first
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onMusicLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onMusicLoadComplete );
			
			var json_data : Object = decodeData( loader.data );
			
			var vo : FacebookMusicCollectionData = new FacebookMusicCollectionData( json_data );
			musicLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the music load IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */	
		private function onMusicLoadIOError( event : IOErrorEvent ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onMusicLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onMusicLoadComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the books load completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */		
		private function onBooksLoadComplete( event : Event ) : void
		{
			// Get the loader and remove any event listeners first
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onBooksLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onBooksLoadComplete );
			
			var json_data : Object = decodeData( loader.data );
			
			var vo : FacebookBookCollectionData = new FacebookBookCollectionData( json_data );
			booksLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the books load IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */	
		private function onBooksLoadIOError( event : IOErrorEvent ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onBooksLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onBooksLoadComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
	}
}