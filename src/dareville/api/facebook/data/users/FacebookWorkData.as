package dareville.api.facebook.data.users
{
	import dareville.api.facebook.data.common.FacebookIdentificationData;
	import dareville.api.facebook.data.common.FacebookBaseData;
	
	/**
	 * The <code>FacebookWorkData</code> class is a value object representing 
	 * data from a user who has specified previous work experience.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookWorkData 
		extends FacebookBaseData
	{
		private var _employer : FacebookIdentificationData;
		private var _position : FacebookIdentificationData;
		
		private var _start_date : Date;
		private var _end_date : Date;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookWorkData(data:Object=null)
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
		override protected function init() : void
		{
			super.init();
			
			if( data.hasOwnProperty( "employer" ) )
			{
				_employer = new FacebookIdentificationData( data.employer );
			}
			
			if( data.hasOwnProperty( "position" ) )
			{
				_position = new FacebookIdentificationData( data.position );
			}
			
			if( data.hasOwnProperty( "start_date" ) )
			{
				_start_date = createDate( data.start_date );
			}
			
			if( data.hasOwnProperty( "end_date" ) )
			{
				_end_date = createDate( data.end_date );
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Employer
		 * 
		 * @return FacebookIdentificationData 
		 */	
		public function get employer():FacebookIdentificationData
		{
			return _employer;
		}
		
		/**
		 * Position
		 * 
		 * @return FacebookIdentificationData 
		 */	
		public function get position():FacebookIdentificationData
		{
			return _position;
		}
		
		/**
		 * Start date
		 * 
		 * @return Date 
		 */	
		public function get start_date():Date
		{
			return _start_date;
		}
		
		/**
		 * End date
		 * 
		 * @return Date 
		 */	
		public function get end_date():Date
		{
			return _end_date;
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
	}
}