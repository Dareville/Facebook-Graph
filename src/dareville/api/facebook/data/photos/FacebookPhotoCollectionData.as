package dareville.api.facebook.data.photos
{
	import dareville.api.facebook.data.common.FacebookPagingData;
	
	/**
	 * The <code>FacebookPhotoCollectionData</code> class is a value object 
	 * representing a collection of photo data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookPhotoCollectionData 
		extends FacebookPagingData
	{
		private var _photos : Array;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookPhotoCollectionData(data:Object=null)
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
			
			_photos = new Array();
			
			if( data.hasOwnProperty( "data" ) )
			{
				var arr_photos : Array = data.data;
				var photos_len : int = arr_photos.length;
				for( var i : int = 0; i < photos_len; i++ )
				{
					var photo : FacebookPhotoData = new FacebookPhotoData( arr_photos[i] );
					_photos.push( photo );
				}
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Array of <code>FacebookPhotoData</code>
		 *  
		 * @return Array
		 */		
		public function get photos():Array
		{
			return _photos;
		}
	}
}