package dareville.api.facebook.data.feed
{
	/**
	 * The <code>FacebookFeedPostPhotoData</code> class is a value object 
	 * representing a photo post data on a pages feed.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookFeedPostPhotoData 
		extends FacebookFeedPostData
	{
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookFeedPostPhotoData(data:Object=null)
		{
			super(data);
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Picture URL
		 * 
		 * @return String 
		 */		
		public function get picture():String
		{
			return data.picture;
		}
		
		/**
		 * Link URL
		 * 
		 * @return String 
		 */		
		public function get link():String
		{
			return data.link;
		}
		
		/**
		 * Icon URL
		 * 
		 * @return String 
		 */		
		public function get icon():String
		{
			return data.icon;
		}
	}
}