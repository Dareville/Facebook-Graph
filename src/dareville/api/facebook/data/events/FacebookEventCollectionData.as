package dareville.api.facebook.data.events
{
	import dareville.api.facebook.data.common.FacebookPagingData;
	
	/**
	 * The <code>FacebookEventCollectionData</code> class is a value object 
	 * representing a collection of event data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookEventCollectionData 
		extends FacebookPagingData
	{
		private var _events : Array;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookEventCollectionData(data:Object=null)
		{
			super(data);
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
		override protected function init():void
		{
			_events = new Array();
			if( data.hasOwnProperty( "data" ) )
			{
				var arr_events : Array = data.data;
				var arr_events_len : int = arr_events.length;
				for( var i : int = 0; i < arr_events_len; i++ )
				{
					var event : FacebookEventData = new FacebookEventData( arr_events[i] );
					_events.push( event );
				}
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Array of <code>FacebookEventData</code> 
		 * 
		 * @return Array
		 */		
		public function get events():Array
		{
			return _events;
		}
	}
}