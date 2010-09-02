package dareville.api.facebook.data.photos
{
	import flash.utils.ByteArray;

	/**
	 * The <code>FacebookPhotoCreateData</code> class is a value object 
	 * representing data from a photo to be created.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookPhotoCreateData
	{
		private var _byte_array : ByteArray;
		private var _message : String;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor 
		 * 
		 * @param message Message
		 * @param byte_array Image byte array
		 */		
		public function FacebookPhotoCreateData( message : String, byte_array : ByteArray )
		{
			_byte_array = byte_array;
			_message = message;
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Image byte array data
		 * 
		 * @return ByteArray
		 */		
		public function get byte_array():ByteArray
		{
			return _byte_array;
		}
		
		/**
		 * Message
		 * 
		 * @return String
		 */	
		public function get message():String
		{
			return _message;
		}

	}
}