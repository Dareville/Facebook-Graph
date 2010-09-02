package dareville.api.facebook.data.events
{
	import dareville.api.facebook.data.common.FacebookIdentificationData;
	import dareville.api.facebook.data.users.FacebookUserData;

	/**
	 * The <code>FacebookEventData</code> class is a value object representing 
	 * an event data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookEventData 
		extends FacebookIdentificationData
	{
		private var _owner : FacebookIdentificationData;
		
		private var _venue : FacebookEventVenueData;
		
		private var _start_time : Date;
		private var _end_time : Date;
		private var _updated_time : Date;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor 
		 * 
		 * @param data
		 */		
		public function FacebookEventData(data:Object=null)
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
			super.init();
			
			if( data.hasOwnProperty( "owner" ) )
			{
				_owner = new FacebookIdentificationData( data.owner );
			}
			
			if( data.hasOwnProperty( "venue" ) )
			{
				_venue = new FacebookEventVenueData( data.venue );
			}
			
			if( data.hasOwnProperty( "start_time" ) )
			{
				_start_time = createDate( data.start_time );
			}
			
			if( data.hasOwnProperty( "end_time" ) )
			{
				_end_time = createDate( data.end_time );
			}
			
			if( data.hasOwnProperty( "updated_time" ) )
			{
				_updated_time = createDate( data.updated_time );
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Owner of the event
		 * 
		 * @return FacebookIdentificationData 
		 */		
		public function get owner():FacebookIdentificationData
		{
			return _owner;
		}
		
		/**
		 * Category
		 * 
		 * @return String 
		 */		
		public function get category():String
		{
			if( data.owner )
			{
				return data.owner.category;
			}
			return null;
		}
		
		/**
		 * Description
		 * 
		 * @return String 
		 */		
		public function get description():String
		{
			return data.description;
		}
		
		/**
		 * Start time of the event
		 * 
		 * @return Date 
		 */		
		public function get start_time():Date
		{
			return _start_time;
		}

		/**
		 * End time of the event
		 *  
		 * @return Date
		 */		
		public function get end_time():Date
		{
			return _end_time;
		}

		/**
		 * Location 
		 * 
		 * @return String
		 */		
		public function get location():String
		{
			return data.location;
		}
		
		/**
		 * Event venue
		 * 
		 * @return FacebookEventVenueData 
		 */		
		public function get venue():FacebookEventVenueData
		{
			return _venue;
		}
		
		/**
		 * Privacy level of the event
		 * 
		 * @return String 
		 */		
		public function get privacy():String
		{
			return data.privacy;
		}
		
		/**
		 * Last time the event was updated
		 * 
		 * @return Date 
		 */		
		public function get updated_time():Date
		{
			return _updated_time;
		}
		
		/**
		 * RSVP status of the event
		 * 
		 * @return String 
		 */		
		public function get rsvp_status():String
		{
			return data.rsvp_status;
		}
	}
}