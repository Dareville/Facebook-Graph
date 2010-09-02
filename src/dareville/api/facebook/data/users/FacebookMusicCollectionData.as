package dareville.api.facebook.data.users
{
	import dareville.api.facebook.data.common.FacebookBaseData;
	
	/**
	 * The <code>FacebookMusicCollectionData</code> class is a value object 
	 * representing a collection of music data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookMusicCollectionData 
		extends FacebookBaseData
	{
		private var _movies : Array;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookMusicCollectionData(data:Object=null)
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
			
			_movies = new Array();
			if( data && data.hasOwnProperty( "data" ) )
			{
				var arr_data : Array = data.data;
				var arr_data_len : int = arr_data.length;
				for( var i : int = 0; i < arr_data_len; i++ )
				{
					var movie : FacebookMusicData = new FacebookMusicData( arr_data[i] );
					_movies.push( movie );
				}
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Array of <code>FacebookMusicData</code> 
		 * 
		 * @return Array
		 */		
		public function get movies():Array
		{
			return _movies;
		}
	}
}