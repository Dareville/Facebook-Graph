package dareville.api.facebook.data.comments
{
	import dareville.api.facebook.data.common.FacebookPagingData;
	
	/**
	 * The <code>FacebookCommentCollectionData</code> class is a value object 
	 * representing a collection of comment data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookCommentCollectionData 
		extends FacebookPagingData
	{
		private var _comments : Array;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookCommentCollectionData(data:Object=null)
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
			
			_comments = new Array();
			if( data && data.hasOwnProperty( "data" ) )
			{
				var arr_comments : Array = data.data;
				var arr_comments_len : int = arr_comments.length;
				for( var i : int = 0; i < arr_comments_len; i++ )
				{
					var comment : FacebookCommentData = new FacebookCommentData( arr_comments[i] );
					_comments.push( comment );
				}
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Array of <code>FacebookCommentData</code>
		 * 
		 * @return Array 
		 */		
		public function get comments():Array
		{
			return _comments;
		}
		
		/**
		 * Total count of comments
		 * 
		 * @return int 
		 */		
		public function get count():int
		{
			if( data && data.count )
			{
				return data.count;
			}
			else if( data && data.data )
			{
				return data.data.length;
			}
			return 0;
		}
	}
}