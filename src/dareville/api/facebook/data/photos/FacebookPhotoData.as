package dareville.api.facebook.data.photos
{
	import dareville.api.facebook.data.comments.FacebookCommentCollectionData;
	import dareville.api.facebook.data.common.FacebookIdentificationData;
	
	/**
	 * The <code>FacebookPhotoData</code> class is a value object representing 
	 * data from a photo.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookPhotoData 
		extends FacebookIdentificationData
	{
		private var _from : FacebookIdentificationData;
		
		private var _tags : Array;
		
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
		public function FacebookPhotoData(data:Object=null)
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
		
		override protected function init():void
		{
			super.init();
			
			if( data.hasOwnProperty( "from" ) )
			{
				_from = new FacebookIdentificationData( data.from );
			}
			
			_tags = new Array();
			if( data.hasOwnProperty( "tags" ) )
			{
				var arr_tags : Array = data.tags.data;
				var arr_tags_len : int = arr_tags.length;
				for( var i : int = 0; i < arr_tags_len; i++ )
				{
					var tag : FacebookPhotoTagData = new FacebookPhotoTagData( arr_tags[i] );
					_tags.push( tag );
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
		 * User who created the photo
		 * 
		 * @return FacebookIdentificationData 
		 */	
		public function get from():FacebookIdentificationData
		{
			return _from;
		}
		
		/**
		 * Array of <code>FacebookPhotoTagData</code>
		 * 
		 * @return Array 
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
		 * Source URL
		 *  
		 * @return String
		 */	
		public function get source():String
		{
			return data.source;
		}
		
		/**
		 * Photo height
		 *  
		 * @return Number
		 */		
		public function get height():Number
		{
			return data.height
		}
		
		/**
		 * Photo width
		 *  
		 * @return Number
		 */	
		public function get width():Number
		{
			return data.width;
		}
		
		/**
		 * Link 
		 * 
		 * @return String 
		 */		
		public function get link():String
		{
			return data.link;
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