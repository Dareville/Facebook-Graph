package dareville.api.facebook.data.likes
{
	import dareville.api.facebook.data.common.FacebookBaseData;
	
	/**
	 * The <code>FacebookLikeCollectionData</code> class defines a collection
	 * of like value objects.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookLikeCollectionData
		extends FacebookBaseData
	{
		private var _likes : Array;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookLikeCollectionData(data:Object=null)
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
			
			_likes = new Array();
			
			if( data.hasOwnProperty( "data" ) )
			{
				var arr_likes : Array = data.data;
				var arr_likes_len : int = arr_likes.length;
				for( var i : int = 0; i < arr_likes_len; i++ )
				{
					var like : FacebookLikeData = new FacebookLikeData( arr_likes[i] );
					_likes.push( like );
				}
			}
		}

		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Array of <code>FacebookLikeData</code>
		 *  
		 * @return Array
		 */		
		public function get likes():Array
		{
			return _likes;
		}
	}
}