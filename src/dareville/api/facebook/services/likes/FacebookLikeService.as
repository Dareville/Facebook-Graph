package dareville.api.facebook.services.likes
{
	import dareville.api.facebook.FacebookConstants;
	import dareville.api.facebook.data.comments.FacebookCommentCollectionData;
	import dareville.api.facebook.services.common.AbstractFacebookService;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestMethod;
	
	import org.osflash.signals.Signal;
	
	/**
	 * The <code>FacebookLikeService</code> class provides the ability to like
	 * and unlike a post/image/link/etc.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookLikeService 
		extends AbstractFacebookService
	{
		//----------------------------------
		//  Signals
		//----------------------------------
		
		/**
		 * Signal dispatched when the like has completed. Dispatches a
		 * <code>Boolean</code> as a parameter.
		 */	
		public var liked : Signal = new Signal( Boolean );
		
		/**
		 * Signal dispatched when the unlike has completed. Dispatches a
		 * <code>Boolean</code> as a parameter.
		 */	
		public var unliked : Signal = new Signal( Boolean );
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Like the specified post/photo/link/etc.
		 * 
		 * <p>When the request completes, a <code>liked</code> 
		 * Signal is dispatched containing an <code>Boolean</code> of whether 
		 * the request succeeded or not.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param post_id Post to like
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example likes the specified post:
<listing version="3.0">
var service : FacebookLikeService = new FacebookLikeService();
service.liked.addOnce( onLiked );
service.like( access_token, "{POST_ID}" );
 
function onLiked( status : Boolean ):void
{
	service.liked.removeAll(); 
}
</listing>
		 */		
		public function like( access_token : String, post_id : String ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onLikeLoadIOError );
				loader.addEventListener( Event.COMPLETE, onLikeComplete );
				
				// Call the service
				call( loader, post_id + "/" + FacebookConstants.CONNECTION_LIKES, access_token, null, URLRequestMethod.POST );
				return loader;
			}
			return null;
		}
		
		/**
		 * Unlike the specified post/photo/link/etc.
		 * 
		 * <p>When the request completes, a <code>unliked</code> 
		 * Signal is dispatched containing an <code>Boolean</code> of whether 
		 * the request succeeded or not.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param post_id Post to unlike
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example unlikes the specified post:
<listing version="3.0">
var service : FacebookLikeService = new FacebookLikeService();
service.unliked.addOnce( onUnliked );
service.unlike( access_token, "{POST_ID}" );
 
function onUnliked( status : Boolean ):void
{
	service.unliked.removeAll(); 
}
</listing>
		 */	
		public function unlike( access_token : String, post_id : String ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onUnlikeLoadIOError );
				loader.addEventListener( Event.COMPLETE, onUnlikeComplete );
				
				// Call the service
				call( loader, post_id + "/" + FacebookConstants.CONNECTION_LIKES + "?method=delete", access_token, null, URLRequestMethod.POST );
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
		 * Callback for when the like request completes
		 * 
		 * @param event <code>Event.COMPLETE</code>
		 */		
		private function onLikeComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onLikeLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onLikeComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			liked.dispatch( Boolean( json_data ) );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private 
		 * Callback for when the like request errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code>
		 */		
		private function onLikeLoadIOError( event : IOErrorEvent ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onLikeLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onLikeComplete );
			
			errored.dispatch( loader.data );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the unlike request completes
		 * 
		 * @param event <code>Event.COMPLETE</code>
		 */		
		private function onUnlikeComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onUnlikeLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onUnlikeComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			unliked.dispatch( Boolean( json_data ) );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private 
		 * Callback for when the unlike request errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code>
		 */		
		private function onUnlikeLoadIOError( event : IOErrorEvent ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onUnlikeLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onUnlikeComplete );
			
			errored.dispatch( loader.data );
			
			// NULL the loader
			loader = null;
		}
	}
}