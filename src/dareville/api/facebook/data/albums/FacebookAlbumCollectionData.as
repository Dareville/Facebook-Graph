package dareville.api.facebook.data.albums
{
	import dareville.api.facebook.data.common.FacebookPagingData;
	
	/**
	 * The <code>FacebookAlbumData</code> class is a value object representing 
	 * a collection of album data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookAlbumCollectionData 
		extends FacebookPagingData
	{
		private var _albums : Array;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookAlbumCollectionData(data:Object=null)
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
			
			_albums = new Array();
			
			if( data.hasOwnProperty( "data" ) )
			{
				var arr_albums : Array = data.data;
				var arr_albums_len : int = arr_albums.length;
				for( var i : int = 0; i < arr_albums_len; i++ )
				{
					var album : FacebookAlbumData = new FacebookAlbumData( arr_albums[i] );
					_albums.push( album );
				}
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Array of <code>FacebookAlbumData</code>
		 * 
		 * @return Array 
		 */		
		public function get albums():Array
		{
			return _albums;
		}
	}
}