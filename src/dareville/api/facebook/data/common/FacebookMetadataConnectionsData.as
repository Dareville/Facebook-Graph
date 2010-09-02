package dareville.api.facebook.data.common
{
	/**
	 * The <code>FacebookMetadataConnectionsData</code> class is a base value 
	 * object representing metadata connections data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class FacebookMetadataConnectionsData 
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
		public function FacebookMetadataConnectionsData(data:Object=null)
		{
			super(data);
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Accounts
		 * 
		 * @return String 
		 */		
		public function get accounts():String
		{
			return data.accounts;
		}

		/**
		 * Activities
		 * 
		 * @return String 
		 */		
		public function get activities():String
		{
			return data.activities;
		}
		
		/**
		 * Albums
		 * 
		 * @return String 
		 */		
		public function get albums():String
		{
			return data.albums;
		}
		
		/**
		 * Books
		 * 
		 * @return String 
		 */		
		public function get books():String
		{
			return data.books;
		}
		
		/**
		 * Checkins
		 * 
		 * @return String 
		 */		
		public function get checkins():String
		{
			return data.checkins;
		}
		
		/**
		 * Events
		 * 
		 * @return String 
		 */		
		public function get events():String
		{
			return data.events;
		}
		
		/**
		 * Family
		 * 
		 * @return String 
		 */		
		public function get family():String
		{
			return data.family;
		}
		
		/**
		 * Feed
		 * 
		 * @return String 
		 */		
		public function get feed():String
		{
			return data.feed;
		}
		
		/**
		 * Friends
		 * 
		 * @return String 
		 */		
		public function get friends():String
		{
			return data.friends;
		}
		
		/**
		 * Groups
		 * 
		 * @return String 
		 */		
		public function get groups():String
		{
			return data.groups;
		}
		
		/**
		 * Home
		 * 
		 * @return String 
		 */		
		public function get home():String
		{
			return data.home;
		}
		
		/**
		 * Inbox
		 * 
		 * @return String 
		 */		
		public function get inbox():String
		{
			return data.interests;
		}
		
		/**
		 * Likes
		 * 
		 * @return String 
		 */		
		public function get likes():String
		{
			return data.likes;
		}
		
		/**
		 * Movies
		 * 
		 * @return String 
		 */		
		public function get movies():String
		{
			return data.movies;
		}
		
		/**
		 * Music
		 * 
		 * @return String 
		 */		
		public function get music():String
		{
			return data.music;
		}
		
		/**
		 * Notes
		 * 
		 * @return String 
		 */		
		public function get notes():String
		{
			return data.notes;
		}
		
		/**
		 * Outbox
		 * 
		 * @return String 
		 */		
		public function get outbox():String
		{
			return data.outbox;
		}
		
		/**
		 * Photos
		 * 
		 * @return String 
		 */		
		public function get photos():String
		{
			return data.photos;
		}
		
		/**
		 * Picture
		 * 
		 * @return String 
		 */		
		public function get picture():String
		{
			return data.picture;
		}
		
		/**
		 * Statuses
		 * 
		 * @return String 
		 */		
		public function get statuses():String
		{
			return data.statuses;
		}
		
		/**
		 * Tagged
		 * 
		 * @return String 
		 */		
		public function get tagged():String
		{
			return data.tagged;
		}
		
		/**
		 * Television
		 * 
		 * @return String 
		 */		
		public function get television():String
		{
			return data.television;
		}
		
		/**
		 * Updates
		 * 
		 * @return String 
		 */		
		public function get updates():String
		{
			return data.updates;
		}
		
		/**
		 * Videos
		 * 
		 * @return String 
		 */		
		public function get videos():String
		{
			return data.videos;
		}
	}
}