package dareville.api.facebook.services.applications
{
	import dareville.api.facebook.data.applications.FacebookApplicationData;
	import dareville.api.facebook.services.common.AbstractFacebookProfileService;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	
	import org.osflash.signals.Signal;
	
	/**
	 * The <code>FacebookApplicationService</code> class provides access to 
	 * application data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookApplicationService 
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
		 * Retrieves data asynchronously from a profile associated with an 
		 * application.
		 * 
		 * <p>If the request succeeds, a <code>profileLoaded</code> 
		 * Signal is dispatched containing an 
		 * <code>FacebookApplicationData</code> instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param application_id Application ID to request
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example retrieves the profile of the specified 
		 * application:
<listing version="3.0">
var service : FacebookApplicationService = new FacebookApplicationService();
service.profileLoaded.addOnce( onProfileSearched );
service.getProfile( access_token, "2439131959" );
 
function onProfileSearched( vo : FacebookApplicationData ):void
{
	service.profileLoaded.removeAll();
}</listing>
		 */	
		override public function getProfile( access_token : String, application_id : String ) : URLLoader
		{
			return super.getProfile( access_token, application_id );
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
			return new Signal( FacebookApplicationData );
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
			var vo : FacebookApplicationData = new FacebookApplicationData( json_data );
			profileLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
	}
}