package dareville.api.facebook.services.photos
{
	import dareville.api.facebook.FacebookConstants;
	import dareville.api.facebook.data.photos.FacebookPhotoCollectionData;
	import dareville.api.facebook.data.photos.FacebookPhotoCreateData;
	import dareville.api.facebook.services.common.AbstractFacebookService;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	
	import org.osflash.signals.Signal;
	
	import ru.inspirit.net.MultipartURLLoader;

	/**
	 * The <code>FacebookPhotoService</code> class provides access to photo
	 * data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookPhotoService
		extends AbstractFacebookService
	{
		//----------------------------------
		//  Signals
		//----------------------------------
		
		/**
		 * Signal dispatched when the photos call has loaded. Dispatches a
		 * <code>FacebookPhotoCollectionData</code> as a parameter. 
		 */		
		public var photosLoaded : Signal = new Signal( FacebookPhotoCollectionData );
		
		/**
		 * Signal dispatched when the photo created call has completed. 
		 * Dispatches a <code>String</code> as a parameter. 
		 */		
		public var photoCreated : Signal = new Signal( String );
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Retrieves a photos from a user/page/album/etc.
		 * 
		 * <p>If the request succeeds, the <code>photosLoaded</code> Signal is 
		 * dispatched containing an <code>FacebookPhotoCollectionData</code> 
		 * instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param page_id Page ID to request
		 * 
		 * @return URLLoader Loader 
		 * 
		 * @example This example retrieves the photos of the current logged 
		 * in user:
<listing version="3.0">
var service : FacebookPhotoService = new FacebookPhotoService();
service.photosLoaded.addOnce( onPhotosLoad );
service.getPhotos( access_token );
 
function onPhotosLoad( vo : FacebookPhotoCollectionData ):void
{
	service.photosLoaded.removeAll();
}</listing>
		 */ 	
		public function getPhotos( 
			access_token : String, 
			page_id : String = FacebookConstants.CONNECTION_ME ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onGetPhotosLoadIOError, false, 0, true );
				loader.addEventListener( Event.COMPLETE, onGetPhotosLoadComplete, false, 0, true );
				
				// Call the service
				call( loader, page_id + "/" + FacebookConstants.CONNECTION_PHOTOS, access_token  );
				return loader;
			}
			return null;
		}
		
		/**
		 * Creates a photo.
		 * 
		 * <p>If the request succeeds, the <code>photoCreated</code> Signal is 
		 * dispatched containing an <code>String</code> ID.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param photo Value object of the photo to be created
		 * @param page_id Page ID to post to
		 * 
		 * @return MultipartURLLoader Loader 
		 * 
		 * @example This example posts a screen capture of the stage with a 
		 * photo caption:
<listing version="3.0">
var bmd : BitmapData = new BitmapData( 300, 500 );
bmd.draw( this );
 
var jpg : JPGEncoder = new JPGEncoder( 85 );
var source : ByteArray = jpg.encode( bmd );
 
var photo : FacebookPhotoCreateData = new FacebookPhotoCreateData( "Photo caption", source );
var service : FacebookPhotoService = new FacebookPhotoService();
service.photoCreated.addOnce( onPhotoCreated );
service.createPhoto( access_token, photo );
 
function onPhotoCreated( id : String ):void
{
	service.photoCreated.removeAll();
}</listing>
		 */ 
		public function createPhoto(
			access_token : String,
			photo : FacebookPhotoCreateData,
			page_id : String = FacebookConstants.CONNECTION_ME ):MultipartURLLoader
		{
			if( access_token )
			{
				var loader : MultipartURLLoader = new MultipartURLLoader();
				loader.addVariable( "message", photo.message );
				loader.addFile( photo.byte_array, "image.jpg", "image" );
				
				loader.loader.addEventListener( Event.COMPLETE, onPhotoCreateComplete );
				loader.loader.addEventListener( IOErrorEvent.IO_ERROR, onPhotoCreateIOError );
				
				loader.load( FacebookConstants.API_SECURE_PATH + page_id + "/" + FacebookConstants.CONNECTION_PHOTOS + "?access_token="+ access_token );
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
		 * Callback for when the photos load completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */		
		private function onGetPhotosLoadComplete(event:Event):void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onGetPhotosLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onGetPhotosLoadComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			
			var vo : FacebookPhotoCollectionData = new FacebookPhotoCollectionData( json_data );			
			photosLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the photos IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */	
		private function onGetPhotosLoadIOError( event : IOErrorEvent ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onGetPhotosLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onGetPhotosLoadComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the photo create completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */		
		private function onPhotoCreateComplete(event:Event):void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onPhotoCreateIOError );
			loader.removeEventListener( Event.COMPLETE, onPhotoCreateComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			photoCreated.dispatch( String( json_data.id ) );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the photo create IO errors
		 * 
		 * @param event <code>IOErrorEvent.IO_ERROR</code> 
		 */	
		private function onPhotoCreateIOError( event : IOErrorEvent ) : void
		{
			// Rmove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onPhotoCreateIOError );
			loader.removeEventListener( Event.COMPLETE, onPhotoCreateComplete );
			
			errored.dispatch( event.text );
			
			// NULL the loader
			loader = null;
		}
	}
}