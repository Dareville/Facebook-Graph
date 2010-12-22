package dareville.api.facebook.data.common
{
	import com.adobe.serialization.json.JSON;
	
	import dareville.api.facebook.data.interfaces.IFacebookBaseData;

	/**
	 * The <code>FacebookBaseData</code> class is a base value object
	 * representing data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class FacebookBaseData
		implements IFacebookBaseData
	{
		private var _data : Object;
		
		private var _metadata : FacebookMetadataData;
		
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
		public function FacebookBaseData( data : Object = null )
		{
			_data = data;
			init();
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @private 
		 * Initialize the data
		 */		
		protected function init() : void
		{
			if( _data )
			{
				_metadata = new FacebookMetadataData( data.metadata );
			}
		}
		
		/**
		 * Create a date based on the timestamp format provided by Facebook
		 * ( 2010-08-01T18:52:00+0000 ). In some cases, Facebook will only 
		 * provide values up until the year/month/day/etc. Depending on the 
		 * length of the string provided, this method will validate and the
		 * value provided before assigning its contents. 
		 * 
		 * <p>The date returned will be a UTC formatted date object</p>
		 * 
		 * @param value A Facebook PHP string formatted date
		 * @return Date UTC date object
		 */		
		protected function createDate( value : String ) : Date
		{
			var year : int = 0;
			var month : int = 0;
			var day : int = 0;
			var hour : int = 0;
			var minute : int = 0;
			var second : int = 0;
			
			if( value.length >= 4 )
			{
				year = Number( value.substr( 0, 4 ) );
			}
			
			if( value.length >= 7 )
			{
				month = Number( value.substr( 5, 2 ) ) - 1;
			}
			
			if( value.length >= 10 )
			{
				day = Number( value.substr( 8, 2 ) );
			}
			
			if( value.length >= 13 )
			{
				hour = Number( value.substr( 11, 2 ) );
			}
			
			if( value.length >= 16 )
			{
				minute = Number( value.substr( 14, 2 ) );
			}
			
			if( value.length >= 19 )
			{
				Number( value.substr( 17, 2 ) )
			}
			
			return new Date( Date.UTC( year, month, day, hour, minute, second ) );
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------

		/**
		 * JSON decoded Object
		 *  
		 * @return Object
		 */		
		public function get data():Object
		{
			return _data;
		}
		
		/**
		 * Metadata
		 *  
		 * @return FacebookMetadataData
		 * 
		 */		
		public function get metadata():FacebookMetadataData
		{
			return _metadata;
		}
		
		/**
		 * Returns a string version of the encoded JSON object data from 
		 * Facebook.
		 * 
		 * @return String 
		 */		
		public function toString():String
		{
			return JSON.encode( data );
		}
	}
}