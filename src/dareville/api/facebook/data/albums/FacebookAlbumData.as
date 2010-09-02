package dareville.api.facebook.data.albums
{
	import dareville.api.facebook.data.comments.FacebookCommentCollectionData;
	import dareville.api.facebook.data.common.FacebookIdentificationData;
	
	/**
	 * The <code>FacebookAlbumData</code> class is a value object representing 
	 * album data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookAlbumData 
		extends FacebookIdentificationData
	{
		private var _from : FacebookIdentificationData;
		
		private var _created_time : Date;
		private var _updated_time : Date;
		
		private var _comments : FacebookCommentCollectionData;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookAlbumData(data:Object=null)
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
		override protected function init():void
		{
			super.init();
			
			if( data.hasOwnProperty( "from" ) )
			{
				_from = new FacebookIdentificationData( data.from );
			}
			
			if( data.hasOwnProperty( "created_time" ) )
			{
				_created_time = createDate( data.created_time );
			}
			
			if( data.hasOwnProperty( "updated_time" ) )
			{
				_updated_time = createDate( data.updated_time );
			}
			
			_comments = new FacebookCommentCollectionData( data.comments );
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * User who created the album
		 * 
		 * @return FacebookIdentificationData 
		 */		
		public function get from():FacebookIdentificationData
		{
			return _from;
		}
		
		/**
		 * Location of the album
		 *  
		 * @return String
		 */		
		public function get location():String
		{
			return data.location;
		}
		
		/**
		 * Link to the album
		 * 
		 * @return String 
		 */		
		public function get link():String
		{
			return data.link;
		}
		
		/**
		 * Privacy setting of the album
		 * 
		 * @return String 
		 */		
		public function get privacy():String
		{
			return data.privacy;
		}
		
		/**
		 * Number of photos in the album
		 * 
		 * @return String 
		 */		
		private function get count():Number
		{
			return data.count;
		}
		
		/**
		 * Time the album was created
		 *  
		 * @return Date
		 */		
		public function get created_time():Date
		{
			return _created_time;
		}
		
		/**
		 * Time the album was updated last
		 * 
		 * @return Date 
		 */		
		public function get updated_time():Date
		{
			return _updated_time;
		}
		
		/**
		 * Album comments
		 * 
		 * @return FacebookCommentCollectionData 
		 */		
		public function get comments():FacebookCommentCollectionData
		{
			return _comments;
		}
	}
}