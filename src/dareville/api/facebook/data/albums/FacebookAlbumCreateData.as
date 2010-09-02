package dareville.api.facebook.data.albums
{
	/**
	 * The <code>FacebookAlbumCreateData</code> class is a value object 
	 * representing data for creating an album.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookAlbumCreateData
	{
		private var _name : String;
		private var _description : String;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * @param name Name
		 * @param description Description
		 */		
		public function FacebookAlbumCreateData( name : String, description : String )
		{
			_name = name;
			_description = description;
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Name 
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
	}
}