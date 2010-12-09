package dareville.api.facebook.services.comments
{
	import dareville.api.facebook.FacebookConstants;
	import dareville.api.facebook.data.comments.FacebookCommentCollectionData;
	import dareville.api.facebook.services.common.AbstractFacebookService;
	
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import org.osflash.signals.Signal;
	
	/**
	 * The <code>FacebookCommentService</code> class provides access to comment
	 * data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookCommentService 
		extends AbstractFacebookService
	{
		//----------------------------------
		//  Signals
		//----------------------------------
		
		/**
		 * Signal dispatched once the comments call has loaded. Dispatches a
		 * <code>FacebookCommentCollectionData</code> as a parameter.
		 */		
		public var commentsLoaded : Signal = new Signal( FacebookCommentCollectionData );
		
		/**
		 * Signal dispatched once a new comment has posted. Dispatches a
		 * <code>String</code> as a parameter.
		 */		
		public var commentPosted : Signal = new Signal( String );
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Retrieves all comments asynchronously that are associated with the 
		 * specified post/photo/link/etc
		 * 
		 * <p>If the request succeeds, a <code>commentsLoaded</code> 
		 * Signal is dispatched containing an 
		 * <code>FacebookCommentCollectionData</code> instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param post_id Comment collection to request
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example retrieves the comments from the specified post:
<listing version="3.0">
var service : FacebookCommentService = new FacebookCommentService();
service.commentsLoaded.addOnce( onCommentsLoaded );
service.getComments( access_token, "{POST_ID}" );
 
function onCommentsLoaded( vo : FacebookCommentCollectionData ):void
{
	service.commentsLoaded.removeAll();
}</listing>
		 */		
		public function getComments( access_token : String, post_id : String ) : URLLoader
		{
			var loader : URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener( IOErrorEvent.IO_ERROR, onCommentsLoadIOError );
			loader.addEventListener( Event.COMPLETE, onCommentsLoadComplete );
			
			// Call the service
			call( loader, post_id + "/" + FacebookConstants.CONNECTION_COMMENTS, access_token  );
			return loader;
		}
		
		/**
		 * Post a comment on the specified photo/post/link/etc.
		 * 
		 * <p>If the request succeeds, a <code>commentPosted</code> 
		 * Signal is dispatched containing an <code>String</code> of the 
		 * comment ID.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param post_id Post ID to request
		 * @param message Message to post
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example retrieves the comments from the specified post:
<listing version="3.0">
var service : FacebookCommentService = new FacebookCommentService();
service.commentPosted.addOnce( onCommentPosted );
service.postComment( access_token, "{COMMENT_ID}", "Great post!" );
 
function onCommentPosted( id : String ):void
{
	service.commentPosted.removeAll();
}</listing>
		 */		
		public function postComment( 
			access_token : String, 
			post_id : String, 
			message : String ) : URLLoader
		{
			var loader : URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener( IOErrorEvent.IO_ERROR, onCommentPostIOError );
			loader.addEventListener( Event.COMPLETE, onCommentPostComplete );
			
			var data : URLVariables = new URLVariables();
			data.message = message;
			
			// Call the service
			var path : String = post_id + "/" + FacebookConstants.CONNECTION_COMMENTS;
			call( loader, path, access_token, data, URLRequestMethod.POST );
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
		 * Callback for when the all comments request completes
		 * 
		 * @param event <code>Event.COMPLETE</code>
		 */		
		private function onCommentsLoadComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onCommentsLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onCommentsLoadComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			
			var vo : FacebookCommentCollectionData = new FacebookCommentCollectionData( json_data );
			commentsLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private 
		 * Callback for when the comment load request errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code>
		 */		
		private function onCommentsLoadIOError( event : IOErrorEvent ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onCommentsLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onCommentsLoadComplete );
			
			errored.dispatch( loader.data );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the comment post request completes
		 * 
		 * @param event <code>Event.COMPLETE</code>
		 */		
		private function onCommentPostComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onCommentPostIOError );
			loader.removeEventListener( Event.COMPLETE, onCommentPostComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			
			// Dispatch signal
			commentPosted.dispatch( json_data.id );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private 
		 * Callback for when the comment post request errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code>
		 */		
		private function onCommentPostIOError( event : IOErrorEvent ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onCommentPostIOError );
			loader.removeEventListener( Event.COMPLETE, onCommentPostComplete );
			
			errored.dispatch( loader.data );
			
			// NULL the loader
			loader = null;
		}
	}
}