package dareville.api.facebook.data.search
{
	import dareville.api.facebook.data.common.FacebookPagingData;
	import dareville.api.facebook.data.pages.FacebookPageData;
	
	/**
	 * The <code>FacebookSearchPageCollectionData</code> class is a value object 
	 * representing a collection of searched pages.
	 * 
	 * <p>Note: Not all items in the value object response will be filled, 
	 * as the search results seem to only respond with <code>name</code>,
	 * <code>id</code>, and <code>category</code>.</p>
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookSearchPageCollectionData 
		extends FacebookPagingData
	{
		private var _pages : Array;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * @param data JSON encoded data object
		 */
		public function FacebookSearchPageCollectionData(data:Object=null)
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
			
			_pages = new Array();
			if( data && data.hasOwnProperty( "data" ) )
			{
				var arr_data : Array = data.data as Array;
				var arr_data_len : int = arr_data.length;
				for( var i : int = 0; i < arr_data_len; i++ )
				{
					var id : FacebookPageData = new FacebookPageData( arr_data[i] );
					_pages.push( id );
				}
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Array of <code>FacebookPageData</code> instances
		 * 
		 * @return Array 
		 */		
		public function get pages():Array
		{
			return _pages;
		}
	}
}