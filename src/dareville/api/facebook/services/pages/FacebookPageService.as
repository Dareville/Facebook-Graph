package dareville.api.facebook.services.pages
{
	import dareville.api.facebook.data.pages.FacebookPageData;
	import dareville.api.facebook.services.common.AbstractFacebookProfileService;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	
	import org.osflash.signals.Signal;
	
	/**
	 * The <code>FacebookPageService</code> class provides access to page
	 * data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookPageService 
		extends AbstractFacebookProfileService
	{	
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * Retrieves data asynchronously from a profile associated with a 
		 * page.
		 * 
		 * <p>If the request succeeds, a <code>profileLoaded</code> 
		 * Signal is dispatched containing an 
		 * <code>FacebookPageData</code> instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param page_id Page ID to request
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example retrieves the profile of the specified page:
<listing version="3.0">
var service : FacebookPageService = new FacebookPageService();
service.profileLoaded.addOnce( onProfileSearched );
service.getProfile( access_token, "cocacola" );
 
function onProfileSearched( vo : FacebookPageData ):void
{
	service.profileLoaded.removeAll();
}</listing>
		 */	
		override public function getProfile( access_token : String, page_id : String ) : URLLoader
		{
			return super.getProfile( access_token, page_id );
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
			return new Signal( FacebookPageData );
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
			var vo : FacebookPageData = new FacebookPageData( json_data );
			profileLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
	}
}