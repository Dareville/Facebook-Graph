package dareville.api.facebook.data.videos
{
	import dareville.api.facebook.data.comments.FacebookCommentCollectionData;
	import dareville.api.facebook.data.common.FacebookIdentificationData;
	
	/**
	 * The <code>FacebookVideoData</code> class is a value object representing 
	 * data for a video.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookVideoData 
		extends FacebookIdentificationData
	{
		private var _from : FacebookIdentificationData;
		
		private var _tags : Array;
		
		private var _video_url : String;
		
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
		public function FacebookVideoData(data:Object=null)
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
			
			_tags = new Array();
			if( data.hasOwnProperty( "tags" ) && data.tags.hasOwnProperty( "data" ) )
			{
				var arr_tags : Array = data.tags.data;
				var arr_tags_len : int = arr_tags.length;
				for( var i : int = 0; i < arr_tags_len; i++ )
				{
					var tag : FacebookVideoTagData = new FacebookVideoTagData( arr_tags[i] );
					_tags.push( tag );
				}
			}
			
			if( data.hasOwnProperty( "embed_html" ) )
			{
				if( embed_html.indexOf( '<embed src="' ) != -1 )
				{
					_video_url = embed_html.substring( 
						embed_html.indexOf( '<embed src="' ) + 12,
						embed_html.indexOf( '"', embed_html.indexOf( '<embed src="' ) + 12 ) );
				}
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
		 * User who created the video
		 * 
		 * @return FacebookIdentificationData 
		 */		
		public function get from():FacebookIdentificationData
		{
			return _from;
		}
		
		/**
		 * Tags of the video
		 *  
		 * @return Array of <code>FacebookVideoTagData</code>
		 */		
		public function get tags():Array
		{
			return _tags;
		}
		
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
		 * The embed HTML for the video
		 *  
		 * @return String
		 */		
		public function get embed_html():String
		{
			return data.embed_html;
		}
		
		/**
		 * Video URL string extracted from the <code>embed_html</code> property
		 * 
		 * @return String 
		 */		
		public function get video_url():String
		{
			return _video_url;
		}
		
		/**
		 * Icon
		 *  
		 * @return String
		 */		
		public function get icon():String
		{
			return data.icon;
		}
		
		/**
		 * Time the photo was created
		 *  
		 * @return Date
		 */		
		public function get created_time():Date
		{
			return _created_time;
		}
		
		/**
		 * Time the photo was updated last
		 * 
		 * @return Date 
		 */		
		public function get updated_time():Date
		{
			return _updated_time;
		}
		
		/**
		 * Photo comments
		 * 
		 * @return FacebookCommentCollectionData 
		 */		
		public function get comments():FacebookCommentCollectionData
		{
			return _comments;
		}
	}
}