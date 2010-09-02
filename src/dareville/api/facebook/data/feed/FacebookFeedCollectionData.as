package dareville.api.facebook.data.feed
{
	import dareville.api.facebook.FacebookConstants;
	import dareville.api.facebook.data.common.FacebookPagingData;
	import dareville.api.facebook.data.interfaces.IFacebookFeedPostData;
	
	/**
	 * The <code>FacebookFeedData</code> class is a value object representing a 
	 * feed data from a user/page/application.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookFeedCollectionData 
		extends FacebookPagingData
	{
		private var _feed : Array;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookFeedCollectionData(data:Object=null)
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
			
			_feed = new Array();
			if( data.hasOwnProperty( "data" ) )
			{
				var arr_feed : Array = data.data;
				var feed_len : int = arr_feed.length;
				for( var i : int = 0; i < feed_len; i++ )
				{
					var feed_item : IFacebookFeedPostData;
					var feed_type : String = arr_feed[i].type;
					switch( feed_type )
					{
						case FacebookConstants.FEED_TYPE_PHOTO :
							feed_item = new FacebookFeedPostPhotoData( arr_feed[i] );
							break;
						
						case FacebookConstants.FEED_TYPE_LINK :
							feed_item = new FacebookFeedPostLinkData( arr_feed[i] );
							break;
						
						case FacebookConstants.FEED_TYPE_VIDEO :
							feed_item = new FacebookFeedPostVideoData( arr_feed[i] );
							break;
						
						default :
							feed_item = new FacebookFeedPostData( arr_feed[i] );
							break;
					}
					_feed.push( feed_item );
				}
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Array of <code>IFacebookFeedPostData</code>
		 * 
		 * @return Array 
		 */		
		public function get feed():Array
		{
			return _feed;
		}
	}
}