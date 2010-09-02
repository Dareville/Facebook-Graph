package dareville.api.facebook
{
	/**
	 * The <code>FacebookConstants</code> class provides common constants for 
	 * use with the Facebook Graph API.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookConstants
	{
		//---------------------------------------------------------------------
		//
		//  Public constants
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  API urls
		//----------------------------------
		
		/**
		 * URL to the secure path of the API 
		 */		
		public static const API_SECURE_PATH			:String = "https://graph.facebook.com/";
		
		/**
		 * URL to the unsecure path of the API 
		 */		
		public static const API_UNSECURE_PATH		:String = "http://graph.facebook.com/";
		
		//----------------------------------
		//  Connections
		//----------------------------------
		
		/**
		 * Internal connection string to with interact with Facebook album data.
		 */
		public static const CONNECTION_ALBUMS		:String = "albums";
		
		/**
		 * Internal connection string to with interact with Facebook 
		 * application data.
		 */
		public static const CONNECTION_APPLICATIONS	:String = "applications";
		
		/**
		 * Internal connection string to with interact with Facebook books data.
		 */
		public static const CONNECTION_BOOKS		:String = "books";
		
		/**
		 * Internal connection string to with interact with Facebook 
		 * comments data.
		 */
		public static const CONNECTION_COMMENTS		:String = "comments";
		
		/**
		 * Internal connection string to with interact with Facebook event data.
		 */
		public static const CONNECTION_EVENTS		:String = "events";
		
		/**
		 * Internal connection string to with interact with Facebook feed data.
		 */
		public static const CONNECTION_FEED			:String = "feed";
		
		/**
		 * Internal connection string to with interact with Facebook 
		 * friend data.
		 */
		public static const CONNECTION_FRIENDS		:String = "friends";
		
		/**
		 * Internal connection string to with interact with Facebook group data.
		 */
		public static const CONNECTION_GROUPS		:String = "groups";
		
		/**
		 * Internal connection string to with interact with the current
		 * logged in users home/news feed data.
		 */
		public static const CONNECTION_HOME			:String = "home";
		
		/**
		 * Internal connection string to with interact with Facebook like data.
		 */
		public static const CONNECTION_LIKES		:String = "likes";
		
		/**
		 * Connection string for interacting with Facebook the current logged 
		 * in users data. This can be used instead of providing a
		 * <code>page_id</code> to grab the current logged in users information.
		 */	
		public static const CONNECTION_ME 			:String = "me";
		
		/**
		 * Internal connection string to with interact with Facebook movie data.
		 */
		public static const CONNECTION_MOVIES		:String = "movies";
		
		/**
		 * Internal connection string to with interact with Facebook music data.
		 */
		public static const CONNECTION_MUSIC		:String = "music";
		
		/**
		 * Internal connection string to with interact with Facebook news data.
		 */
		public static const CONNECTION_NEWS			:String = "news";
		
		/**
		 * Internal connection string to with interact with Facebook note data.
		 */
		public static const CONNECTION_NOTES		:String = "notes";
		
		/**
		 * Internal connection string to with interact with Facebook page data.
		 */
		public static const CONNECTION_PAGES		:String = "pages";
		
		/**
		 * Internal connection string to with interact with Facebook 
		 * picture data.
		 */
		public static const CONNECTION_PICTURE		:String = "picture";
		
		/**
		 * Internal connection string to with interact with Facebook photo data.
		 */
		public static const CONNECTION_PHOTOS		:String = "photos";
		
		/**
		 * Internal connection string to with interact with Facebook user data.
		 */
		public static const CONNECTION_USERS		:String = "users";
		
		/**
		 * Internal connection string to with interact with Facebook video data.
		 */
		public static const CONNECTION_VIDEOS		:String = "videos";
		
		//----------------------------------
		//  Feed types
		//----------------------------------
		
		/**
		 * Internal string for feed link posts
		 */
		public static const FEED_TYPE_LINK			:String = "link";
		
		/**
		 * Internal string for feed photo posts
		 */
		public static const FEED_TYPE_PHOTO			:String = "photo";
		
		/**
		 * Internal string for feed status posts
		 */
		public static const FEED_TYPE_STATUS		:String = "status";
		
		/**
		 * Internally used string for feed video posts
		 */
		public static const FEED_TYPE_VIDEO			:String = "video";
		
		//----------------------------------
		//  Search
		//----------------------------------
		
		/**
		 * Internal string for searching
		 */
		public static const SEARCH					:String = "search";
		
		/**
		 * Internal string for searching check ins
		 */
		public static const SEARCH_TYPE_CHECKIN		:String = "checkin";
		
		/**
		 * Internal string for searching groups
		 */
		public static const SEARCH_TYPE_GROUP		:String = "group";
		
		/**
		 * Internal string for searching events
		 */
		public static const SEARCH_TYPE_EVENT		:String = "event";
		
		/**
		 * Internal string for searching pages
		 */
		public static const SEARCH_TYPE_PAGE		:String = "page";
		
		/**
		 * Internal string for searching posts
		 */
		public static const SEARCH_TYPE_POST		:String = "post";
		
		/**
		 * Internal string for searching users
		 */
		public static const SEARCH_TYPE_USER		:String = "user";
		
		//----------------------------------
		//  Profile photo sizes
		//----------------------------------
		
		/**
		 * Constant for retrieving the square size profile photo of a page.
		 */
		public static const SIZE_SQUARE				:String = "square";
		
		/**
		 * Constant for retrieving the small size profile photo of a page.
		 */
		public static const SIZE_SMALL				:String = "small";
		
		/**
		 * Constant for retrieving the large size profile photo of a page.
		 */
		public static const SIZE_LARGE				:String = "large";
		
		//----------------------------------
		//  Delete
		//----------------------------------
		
		/**
		 * Internal string for deleting data
		 */
		public static const DELETE					:String = "delete";
		
		//----------------------------------
		//  Event privacy
		//----------------------------------
		
		/**
		 * Constant for setting the privacy of an event to open.
		 */
		public static const EVENT_PRIVACY_OPEN		:String = "OPEN";
		
		/**
		 * Constant for setting the privacy of an event to closed.
		 */
		public static const EVENT_PRIVACY_CLOSED	:String = "CLOSED";
		
		/**
		 * Constant for setting the privacy of an event to secret.
		 */
		public static const EVENT_PRIVACY_SECRET	:String = "SECRET";
		
		//----------------------------------
		//  Event status
		//----------------------------------
		
		/**
		 * Constant for setting the current logged in users status to an event
		 * to not replied.
		 */
		public static const EVENT_STATUS_NO_REPLY	:String = "noreply";
		
		/**
		 * Constant for setting the current logged in users status to an event
		 * to not maybe.
		 */
		public static const EVENT_STATUS_MAYBE		:String = "maybe";
		
		/**
		 * Constant for setting the current logged in users status to an event
		 * to not invitied.
		 */
		public static const EVENT_STATUS_INVITED	:String = "invited";
		
		/**
		 * Constant for setting the current logged in users status to an event
		 * to not attending.
		 */
		public static const EVENT_STATUS_ATTENDING	:String = "attending";
		
		/**
		 * Constant for setting the current logged in users status to an event
		 * to not declined.
		 */
		public static const EVENT_STATUS_DECLINED	:String = "declined";
	}
}