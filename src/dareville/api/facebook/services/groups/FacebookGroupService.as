package dareville.api.facebook.services.groups
{
	import dareville.api.facebook.data.groups.FacebookGroupData;
	import dareville.api.facebook.services.common.AbstractFacebookProfileService;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	
	import org.osflash.signals.Signal;
	
	/**
	 * The <code>FacebookGroupService</code> class provides access to group
	 * data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookGroupService 
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
		 * group.
		 * 
		 * <p>If the request succeeds, a <code>profileLoaded</code> 
		 * Signal is dispatched containing an 
		 * <code>FacebookGroupData</code> instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param group_id Group ID to request
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example retrieves the profile of the specified group:
<listing version="3.0">
var service : FacebookGroupService = new FacebookGroupService();
service.profileLoaded.addOnce( onProfileSearched );
service.getProfile( access_token, "2204501798" );
 
function onProfileSearched( vo : FacebookGroupData ):void
{
	service.profileLoaded.removeAll();
}</listing>
		 */	
		override public function getProfile( access_token : String, group_id : String ) : URLLoader
		{
			return super.getProfile( access_token, group_id );
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
			return new Signal( FacebookGroupData );
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
			var vo : FacebookGroupData = new FacebookGroupData( json_data );
			profileLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
	}
}