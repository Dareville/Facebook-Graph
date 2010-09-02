package dareville.api.facebook.data.users
{
	import dareville.api.facebook.data.common.FacebookBaseData;
	
	/**
	 * The <code>FacebookBookCollectionData</code> class is a value object 
	 * representing a collection of book data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookBookCollectionData 
		extends FacebookBaseData
	{
		private var _books : Array;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookBookCollectionData(data:Object=null)
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
			
			_books = new Array();
			if( data && data.hasOwnProperty( "data" ) )
			{
				var arr_data : Array = data.data;
				var arr_data_len : int = arr_data.length;
				for( var i : int = 0; i < arr_data_len; i++ )
				{
					var movie : FacebookBookData = new FacebookBookData( arr_data[i] );
					_books.push( movie );
				}
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Array of <code>FacebookBookData</code> 
		 * 
		 * @return Array
		 */		
		public function get books():Array
		{
			return _books;
		}
	}
}