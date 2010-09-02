package dareville.api.facebook.data.events
{
	import dareville.api.facebook.FacebookConstants;

	/**
	 * The <code>FacebookEventCreateData</code> class is a value object 
	 * representing an event data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookEventCreateData
	{
		private var _name : String;
		private var _start_time : Date;
		private var _end_time : Date;
		private var _description : String;
		private var _location : String;
		private var _venue : String;
		private var _privacy : String;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor 
		 * 
		 * @param name The event title
		 * @param description The long-form HTML description of the event
		 * @param start_time The start time of the event
		 * @param end_time The end time of the event
		 * @param location The location for this event
		 * @param venue The location of this event
		 * @param privacy The visibility of this event. Can be: 
		 * 		<code>FacebookConstants.EVENT_PRIVACY_OPEN</code> or
		 * 		<code>FacebookConstants.EVENT_PRIVACY_CLOSED</code> or
		 * 		<code>FacebookConstants.EVENT_PRIVACY_SECRET</code>
		 */		
		public function FacebookEventCreateData( 
			name : String, 
			start_time : Date, 
			end_time : Date,
			description : String = null, 
			location : String = null,
			venue : String = null,
			privacy : String = FacebookConstants.EVENT_PRIVACY_OPEN )
		{
			_name = name;
			_description = description;
			_start_time = start_time;
			_end_time = end_time;
			_location = location;
			_venue = venue;
			_privacy = privacy;
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------

		/**
		 * Name
		 *  
		 * @return String
		 */		
		public function get name():String
		{
			return _name;
		}

		/**
		 * Description 
		 *  
		 * @return String
		 */		
		public function get description():String
		{
			return _description;
		}

		/**
		 * The start time of the event
		 * 
		 * @return Date
		 */	
		public function get start_time():Date
		{
			return _start_time;
		}
		
		/**
		 * The end time of the event
		 * 
		 * @return Date
		 */		
		public function get end_time():Date
		{
			return _end_time;
		}

		/**
		 * The location for this event, a string name
		 *  
		 * @return String
		 */		
		public function get location():String
		{
			return _location;
		}
		
		/**
		 * The location of this event
		 * 
		 * @return String
		 */		
		public function get venue():String
		{
			return _venue;
		}
		
		/**
		 * The visibility of this event
		 * 
		 * @return String
		 */		
		public function get privacy():String
		{
			return _privacy;
		}
	}
}