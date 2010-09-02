package dareville.api.facebook.data.feed
{
	/**
	 * The <code>FacebookFeedPostVideoData</code> class is a value object 
	 * representing a video post data on a pages feed.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookFeedPostVideoData 
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
		public function FacebookFeedPostVideoData(data:Object=null)
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
		
		/**
		 * Video source URL 
		 * 
		 * @return String
		 */		
		public function get source():String
		{
			return data.source;
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
		 * Video caption
		 * 
		 * @return String 
		 */		
		public function get caption():String
		{
			return data.caption;
		}
	}
}