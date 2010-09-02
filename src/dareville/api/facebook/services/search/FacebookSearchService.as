package dareville.api.facebook.services.search
{
	import dareville.api.facebook.FacebookConstants;
	import dareville.api.facebook.data.events.FacebookEventCollectionData;
	import dareville.api.facebook.data.feed.FacebookFeedCollectionData;
	import dareville.api.facebook.data.search.FacebookSearchGroupCollectionData;
	import dareville.api.facebook.data.search.FacebookSearchPageCollectionData;
	import dareville.api.facebook.data.search.FacebookSearchUserCollectionData;
	import dareville.api.facebook.services.common.AbstractFacebookService;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLVariables;
	
	import org.osflash.signals.Signal;
	
	/**
	 * The <code>FacebookSearchService</code> class provides access to searching
	 * data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookSearchService 
		extends AbstractFacebookService
	{
		//----------------------------------
		//  Signals
		//----------------------------------
		
		/**
		 * Signal dispatched when the posts search call has loaded. Dispatches a
		 * <code>FacebookFeedCollectionData</code> as a parameter. 
		 */		
		public var postsSearched : Signal = new Signal( FacebookFeedCollectionData );
		
		/**
		 * Signal dispatched when the users search call has loaded. Dispatches a
		 * <code>FacebookSearchUserCollectionData</code> as a parameter. 
		 */		
		public var usersSearched : Signal = new Signal( FacebookSearchUserCollectionData );
		
		/**
		 * Signal dispatched when the pages search call has loaded. Dispatches a
		 * <code>FacebookSearchPageCollectionData</code> as a parameter. 
		 */		
		public var pagesSearched : Signal = new Signal( FacebookSearchPageCollectionData );
		
		/**
		 * Signal dispatched when search of a specific page/user has loaded. 
		 * Dispatches a <code>FacebookFeedCollectionData</code> as a parameter. 
		 */		
		public var pageSearched : Signal = new Signal( FacebookFeedCollectionData );
		
		/**
		 * Signal dispatched when the events search call has loaded. Dispatches 
		 * a <code>FacebookEventCollectionData</code> as a parameter.  
		 */		
		public var eventsSearched : Signal = new Signal( FacebookEventCollectionData );
		
		/**
		 * Signal dispatched when the groups search call has loaded. Dispatches 
		 * a <code>FacebookSearchGroupCollectionData</code> as a parameter.  
		 */		
		public var groupsSearched : Signal = new Signal( FacebookSearchGroupCollectionData );
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Searches all public posts.
		 * 
		 * <p>If the request succeeds, a <code>postsSearched</code> Signal is 
		 * dispatched containing an <code>FacebookFeedCollectionData</code> 
		 * instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param query Query to search
		 * @param page_id Option page ID to search
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example searches users with the specified query:
<listing version="3.0">
var service : FacebookSearchService = new FacebookSearchService();
service.postsSearched.addOnce( onPostsSearched );
service.searchPosts( access_token, "vegan" );
 
function onPostsSearched( vo : FacebookFeedCollectionData ):void
{
	service.postsSearched.removeAll();
}</listing>
		 */		
		public function searchPosts( 
			access_token : String, 
			query : String,
			page_id : String = null ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onSearchPostsIOError, false, 0, true );
				loader.addEventListener( Event.COMPLETE, onSearchPostsComplete, false, 0, true );
				
				var data : URLVariables = new URLVariables();
				data.q = query;
				
				var page : String;
				if( page_id )
				{
					page = page_id;
				}
				else
				{
					page = FacebookConstants.SEARCH;
					data.type = FacebookConstants.SEARCH_TYPE_POST;
				}
				
				// Call the service
				call( loader, page, access_token, data );
				return loader;
			}
			return null;
		}
		
		/**
		 * Search all users.
		 * 
		 * <p>If the request succeeds, a <code>usersSearched</code> 
		 * Signal is dispatched containing an 
		 * <code>FacebookSearchUserCollectionData</code> instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param query Query to search
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example searches users with the specified query:
<listing version="3.0">
var service : FacebookSearchService = new FacebookSearchService();
service.usersSearched.addOnce( onUsersSearched );
service.searchUsers( access_token, "john" );
 
function onUsersSearched( vo : FacebookSearchUserCollectionData ):void
{
	service.usersSearched.removeAll();
}</listing>
		 */		
		public function searchUsers( access_token : String, query : String ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onSearchUsersIOError, false, 0, true );
				loader.addEventListener( Event.COMPLETE, onSearchUsersComplete, false, 0, true );
				
				var data : URLVariables = new URLVariables();
				data.q = query;
				data.type = FacebookConstants.SEARCH_TYPE_USER;
				
				var page : String = page = FacebookConstants.SEARCH;
				
				// Call the service
				call( loader, page, access_token, data );
				return loader;
			}
			return null;
		}
		
		/**
		 * Search all public pages.
		 * 
		 * <p>If the request succeeds, a <code>pagesSearched</code> 
		 * Signal is dispatched containing an 
		 * <code>FacebookSearchPageCollectionData</code> instance.</p>
		 * 
		 * <p>Note: Not all values in the value object response will be filled, 
		 * as the search results seem to only respond with <code>name</code>,
		 * <code>id</code>, and <code>category</code>.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param query Query to search
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example searches pages with the specified query:
<listing version="3.0">
var service : FacebookSearchService = new FacebookSearchService();
service.pagesSearched.addOnce( onPagesSearched );
service.searchPages( access_token, "vegan" );
 
function onPagesSearched( vo : FacebookSearchPageCollectionData ):void
{
	service.pagesSearched.removeAll();
}</listing>
		 */		
		public function searchPages( 
			access_token : String, 
			query : String ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onSearchPagesIOError, false, 0, true );
				loader.addEventListener( Event.COMPLETE, onSearchPagesComplete, false, 0, true );
				
				var data : URLVariables = new URLVariables();
				data.q = query;
				data.type = FacebookConstants.SEARCH_TYPE_PAGE;
				
				var page : String = page = FacebookConstants.SEARCH;
				
				// Call the service
				call( loader, page, access_token, data );
				return loader;
			}
			return null;
		}
		
		/**
		 * Search all public events.
		 * 
		 * <p>If the request succeeds, a <code>eventsSearched</code> 
		 * Signal is dispatched containing an 
		 * <code>FacebookEventCollectionData</code> instance.</p>
		 * 
		 * <p>Note: Not all values in the value object response will be filled, 
		 * as the search results seem to only respond with <code>name</code>,
		 * <code>id</code>, <code>start_time</code>, <code>end_time</code>, 
		 * and <code>location</code>.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param query Query to search
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example searches events with the specified query:
<listing version="3.0">
var service : FacebookSearchService = new FacebookSearchService();
service.eventsSearched.addOnce( onEventsSearched );
service.searchEvents( access_token, "vegan" );
 
function onEventsSearched( vo : FacebookEventCollectionData ):void
{
	service.eventsSearched.removeAll();
}</listing>
		 */		
		public function searchEvents( 
			access_token : String, 
			query : String ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onSearchEventsIOError, false, 0, true );
				loader.addEventListener( Event.COMPLETE, onSearchEventsComplete, false, 0, true );
				
				var data : URLVariables = new URLVariables();
				data.q = query;
				data.type = FacebookConstants.SEARCH_TYPE_EVENT;
				
				var page : String = page = FacebookConstants.SEARCH;
				
				// Call the service
				call( loader, page, access_token, data );
				return loader;
			}
			return null;
		}
		
		/**
		 * Search all public groups.
		 * 
		 * <p>If the request succeeds, a <code>groupsSearched</code> 
		 * Signal is dispatched containing an 
		 * <code>FacebookSearchGroupCollectionData</code> instance.</p>
		 * 
		 * <p>Note: Not all values in the value object response will be filled, 
		 * as the search results seem to only respond with <code>name</code>,
		 * <code>id</code>, and <code>category</code>.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param query Query to search
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example searches groups with the specified query:
<listing version="3.0">
var service : FacebookSearchService = new FacebookSearchService();
service.groupsSearched.addOnce( onGroupsSearched );
service.searchGroups( access_token, "vegan" );
 
function onGroupsSearched( vo : FacebookSearchGroupCollectionData ):void
{
	service.groupsSearched.removeAll();
}</listing>
		 */		
		public function searchGroups( 
			access_token : String, 
			query : String ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onSearchGroupsIOError, false, 0, true );
				loader.addEventListener( Event.COMPLETE, onSearchGroupsComplete, false, 0, true );
				
				var data : URLVariables = new URLVariables();
				data.q = query;
				data.type = FacebookConstants.SEARCH_TYPE_GROUP;
				
				var page : String = page = FacebookConstants.SEARCH;
				
				// Call the service
				call( loader, page, access_token, data );
				return loader;
			}
			return null;
		}
		
		/**
		 * Search content on a specific page based on the provided query.
		 * 
		 * <p>If the request succeeds, a <code>pageSearched</code> 
		 * Signal is dispatched containing an 
		 * <code>FacebookFeedCollectionData</code> instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param query Query to search
		 * @param page_id Page ID to search
		 * 
		 * @return URLLoader Loader 
		 * 
		 * @example This example searches a single page with the 
		 * specified query:
<listing version="3.0">
var service : FacebookSearchService = new FacebookSearchService();
service.pageSearched.addOnce( onPageSearched );
service.searchPages( access_token, "vegan" );
 
function onPageSearched( vo : FacebookFeedCollectionData ):void
{
	service.pageSearched.removeAll();
}</listing>
		 */		
		public function searchPage( 
			access_token : String, 
			query : String ,
			page_id : String ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onSearchPageIOError, false, 0, true );
				loader.addEventListener( Event.COMPLETE, onSearchPageComplete, false, 0, true );
				
				var data : URLVariables = new URLVariables();
				data.q = query;
				
				// Call the service
				call( loader, page_id, access_token, data );
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
		 * Callback for when the search posts IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */		
		private function onSearchPostsIOError( event : IOErrorEvent ) : void
		{
			// Get the loader and remove any event listeners first
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onSearchPostsIOError );
			loader.removeEventListener( Event.COMPLETE, onSearchPostsComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the search posts completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */	
		private function onSearchPostsComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onSearchPostsIOError );
			loader.removeEventListener( Event.COMPLETE, onSearchPostsComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			var vo : FacebookFeedCollectionData = new FacebookFeedCollectionData( json_data );
			postsSearched.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the search users IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */		
		private function onSearchUsersIOError( event : IOErrorEvent ) : void
		{
			// Get the loader and remove any event listeners first
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onSearchUsersIOError );
			loader.removeEventListener( Event.COMPLETE, onSearchPostsComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the search users completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */	
		private function onSearchUsersComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onSearchUsersIOError );
			loader.removeEventListener( Event.COMPLETE, onSearchUsersComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			var vo : FacebookSearchUserCollectionData = new FacebookSearchUserCollectionData( json_data );
			usersSearched.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the search pages IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */		
		private function onSearchPagesIOError( event : IOErrorEvent ) : void
		{
			// Get the loader and remove any event listeners first
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onSearchPagesIOError );
			loader.removeEventListener( Event.COMPLETE, onSearchPagesComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the search pages completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */	
		private function onSearchPagesComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onSearchPagesIOError );
			loader.removeEventListener( Event.COMPLETE, onSearchPagesComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			var vo : FacebookSearchPageCollectionData = new FacebookSearchPageCollectionData( json_data );
			pagesSearched.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the search events IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */		
		private function onSearchEventsIOError( event : IOErrorEvent ) : void
		{
			// Get the loader and remove any event listeners first
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onSearchEventsIOError );
			loader.removeEventListener( Event.COMPLETE, onSearchEventsComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the search events completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */	
		private function onSearchEventsComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onSearchEventsIOError );
			loader.removeEventListener( Event.COMPLETE, onSearchEventsComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			var vo : FacebookEventCollectionData = new FacebookEventCollectionData( json_data );
			eventsSearched.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the search groups IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */		
		private function onSearchGroupsIOError( event : IOErrorEvent ) : void
		{
			// Get the loader and remove any event listeners first
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onSearchGroupsIOError );
			loader.removeEventListener( Event.COMPLETE, onSearchEventsComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the search groups completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */	
		private function onSearchGroupsComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onSearchGroupsIOError );
			loader.removeEventListener( Event.COMPLETE, onSearchGroupsComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			var vo : FacebookSearchGroupCollectionData = new FacebookSearchGroupCollectionData( json_data );
			groupsSearched.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the search page IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */		
		private function onSearchPageIOError( event : IOErrorEvent ) : void
		{
			// Get the loader and remove any event listeners first
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onSearchPageIOError );
			loader.removeEventListener( Event.COMPLETE, onSearchPageComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the search page completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */	
		private function onSearchPageComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onSearchPageIOError );
			loader.removeEventListener( Event.COMPLETE, onSearchPageComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			var vo : FacebookFeedCollectionData = new FacebookFeedCollectionData( json_data );
			pageSearched.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
	}
}