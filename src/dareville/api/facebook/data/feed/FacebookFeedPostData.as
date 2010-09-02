package dareville.api.facebook.data.feed
{
	import dareville.api.facebook.data.common.FacebookActionCollectionData;
	import dareville.api.facebook.data.comments.FacebookCommentCollectionData;
	import dareville.api.facebook.data.common.FacebookIdentificationCollectionData;
	import dareville.api.facebook.data.common.FacebookIdentificationData;
	import dareville.api.facebook.data.common.FacebookPrivacyData;
	import dareville.api.facebook.data.interfaces.IFacebookFeedPostData;
	
	/**
	 * The <code>FacebookFeedPostData</code> class is a value object 
	 * representing a post data on a pages feed.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookFeedPostData 
		extends FacebookIdentificationData
		implements IFacebookFeedPostData
	{
		private var _from : FacebookIdentificationData;
		private var _to : FacebookIdentificationCollectionData;
		
		private var _created_time : Date;
		private var _updated_time : Date;
		
		private var _actions : FacebookActionCollectionData;
		
		private var _comments : FacebookCommentCollectionData;
		
		private var _privacy : FacebookPrivacyData;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookFeedPostData(data:Object=null)
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
			
			if( data.hasOwnProperty( "to" ) && data.to.hasOwnProperty( "data" ) )
			{
				_to = new FacebookIdentificationCollectionData( data.to.data );
			}
			
			if( data.hasOwnProperty( "created_time" ) )
			{
				_created_time = createDate( data.created_time );
			}
			
			if( data.hasOwnProperty( "updated_time" ) )
			{
				_updated_time = createDate( data.updated_time );
			}
			
			if( data.hasOwnProperty( "privacy" ) )
			{
				_privacy = new FacebookPrivacyData( data.privacy );
			}
			
			_comments = new FacebookCommentCollectionData( data.comments );
			_actions = new FacebookActionCollectionData( data.actions );
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * User that posted
		 * 
		 * @return FacebookIdentificationData 
		 */		
		public function get from():FacebookIdentificationData
		{
			return _from;
		}

		/**
		 * Users who the post was directed towards
		 *  
		 * @return FacebookIdentificationCollectionData
		 */		
		public function get to():FacebookIdentificationCollectionData
		{
			return _to;
		}
		
		/**
		 * Time the post was created
		 * 
		 * @return Date 
		 */		
		public function get created_time():Date
		{
			return _created_time;
		}

		/**
		 * Time the post was updated
		 * 
		 * @return Date 
		 */		
		public function get updated_time():Date
		{
			return _updated_time;
		}
		
		/**
		 * Post message
		 * 
		 * @return String 
		 */		
		public function get message():String
		{
			return data.message;
		}
		
		/**
		 * Post type
		 * 
		 * @return String 
		 */		
		public function get type():String
		{
			return data.type;
		}
		
		/**
		 * Post likes
		 * 
		 * @return Number 
		 */		
		public function get likes():int
		{
			if( data.likes )
			{
				return data.likes;
			}
			return 0;
		}

		/**
		 * Comments on the post
		 *  
		 * @return FacebookCommentCollectionData
		 */		
		public function get comments():FacebookCommentCollectionData
		{
			return _comments;
		}
		
		/**
		 * Actions available on the post
		 *  
		 * @return FacebookActionCollectionData
		 */		
		public function get actions():FacebookActionCollectionData
		{
			return _actions;
		}
		
		/**
		 * Privacy settings on this post
		 * 
		 * @return FacebookPrivacyData
		 */		
		public function get privacy():FacebookPrivacyData
		{
			return _privacy;
		}
	}
}