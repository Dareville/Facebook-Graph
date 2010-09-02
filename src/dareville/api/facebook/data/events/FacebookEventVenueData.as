package dareville.api.facebook.data.events
{
	import dareville.api.facebook.data.common.FacebookBaseData;

	/**
	 * The <code>FacebookEventVenueData</code> class is a value object 
	 * representing event venue data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookEventVenueData 
		extends FacebookBaseData
	{
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookEventVenueData(data:Object=null)
		{
			super(data);
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Street
		 * 
		 * @return String 
		 */		
		public function get street():String
		{
			return data.street;
		}
		
		/**
		 * City 
		 * 
		 * @return String
		 */		
		public function get city():String
		{
			return data.city;
		}
		
		/**
		 * State
		 * 
		 * @return String 
		 */		
		public function get state():String
		{
			return data.state;
		}
		
		/**
		 * Country
		 * 
		 * @return String
		 */		
		public function get country():String
		{
			return data.country;
		}
		
		/**
		 * Latitude
		 *  
		 * @return Number
		 */		
		public function get latitude():Number
		{
			return data.latitude;
		}
		
		/**
		 * Longitude
		 * 
		 * @return Number 
		 */		
		public function get longitude():Number
		{
			return data.longitude;
		}
	}
}