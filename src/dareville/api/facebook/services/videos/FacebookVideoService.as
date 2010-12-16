package dareville.api.facebook.services.videos
{
	import dareville.api.facebook.FacebookConstants;
	import dareville.api.facebook.data.videos.FacebookVideoCollectionData;
	import dareville.api.facebook.data.videos.FacebookVideoData;
	import dareville.api.facebook.services.common.AbstractFacebookService;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	
	import org.osflash.signals.ISignalOwner;
	import org.osflash.signals.Signal;

	/**
	 * The <code>FacebookVideoService</code> class provides access to video
	 * data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookVideoService
		extends AbstractFacebookService
	{
		//----------------------------------
		//  Signals
		//----------------------------------
		
		/**
		 * Signal dispatched when the videos call has loaded. Dispatches a
		 * <code>FacebookVideoCollectionData</code> as a parameter.
		 */		
		public var videosLoaded : ISignalOwner = new Signal( FacebookVideoCollectionData );
		
		/**
		 * Signal dispatched when the video call has loaded. Dispatches a
		 * <code>FacebookVideoData</code> as a parameter.
		 */		
		public var videoLoaded : ISignalOwner = new Signal( FacebookVideoData );
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Retrieves a videos from a user/page/album/etc.
		 * 
		 * <p>If the request succeeds, the <code>videosLoaded</code> Signal is 
		 * dispatched containing an <code>FacebookVideoCollectionData</code> 
		 * instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param page_id Page ID to request
		 * 
		 * @return URLLoader Loader 
		 * 
		 * @example This example retrieves the videos of the current logged 
		 * in user:
<listing version="3.0">
var service : FacebookVideoService = new FacebookVideoService();
service.videosLoaded.addOnce( onVideosLoad );
service.getVideos( access_token );
 
function onVideosLoad( vo : FacebookVideoCollectionData ):void
{
	service.videosLoaded.removeAll();
}</listing>
		 */ 	
		public function getVideos( 
			access_token : String, 
			page_id : String = FacebookConstants.CONNECTION_ME ) : URLLoader
		{
			var loader : URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener( IOErrorEvent.IO_ERROR, onGetVideosLoadIOError, false, 0, true );
			loader.addEventListener( Event.COMPLETE, onGetVideosLoadComplete, false, 0, true );
			
			// Call the service
			call( loader, page_id + "/" + FacebookConstants.CONNECTION_VIDEOS, access_token );
			return loader;
		}
		
		/**
		 * Retrieves a video from a user/page/album/etc.
		 * 
		 * <p>If the request succeeds, the <code>videoLoaded</code> Signal is 
		 * dispatched containing an <code>FacebookVideoData</code> instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param video_id Video ID to request
		 * 
		 * @return URLLoader Loader 
		 * 
		 * @example This example retrieves a video by it's video ID:
<listing version="3.0">
var service : FacebookVideoService = new FacebookVideoService();
service.videoLoaded.addOnce( onVideoLoad );
service.getVideo( access_token, "{VIDEO_ID}" );
 
function onVideoLoad( vo : FacebookVideoData ):void
{
	service.videoLoaded.removeAll();
}</listing>
		 */ 	
		public function getVideo( 
			access_token : String, 
			video_id : String ) : URLLoader
		{
			var loader : URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener( IOErrorEvent.IO_ERROR, onGetVideoLoadIOError, false, 0, true );
			loader.addEventListener( Event.COMPLETE, onGetVideoLoadComplete, false, 0, true );
			
			// Call the service
			call( loader, video_id, access_token );
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
		 * Callback for when the videos load completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */		
		private function onGetVideosLoadComplete(event:Event):void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onGetVideosLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onGetVideosLoadComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			
			var vo : FacebookVideoCollectionData = new FacebookVideoCollectionData( json_data );			
			videosLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the videos IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */	
		private function onGetVideosLoadIOError( event : IOErrorEvent ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onGetVideosLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onGetVideosLoadComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the video load completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */		
		private function onGetVideoLoadComplete(event:Event):void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onGetVideoLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onGetVideoLoadComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			
			var vo : FacebookVideoData = new FacebookVideoData( json_data );			
			videoLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the video IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */	
		private function onGetVideoLoadIOError( event : IOErrorEvent ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onGetVideoLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onGetVideoLoadComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
	}
}