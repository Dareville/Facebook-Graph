package dareville.api.facebook.data.feed
{
	/**
	 * The <code>FacebookFeedPostLinkData</code> class is a value object 
	 * representing a link post data on a pages feed.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookFeedPostLinkData 
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
		public function FacebookFeedPostLinkData(data:Object=null)
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
		 * Description
		 * 
		 * @return String 
		 */		
		public function get description():String
		{
			return data.description;
		}
		
		/**
		 * Photo caption
		 * 
		 * @return String 
		 */		
		public function get caption():String
		{
			return data.caption;
		}
	}
}