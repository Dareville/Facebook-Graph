package dareville.api.facebook.data.videos
{
	import dareville.api.facebook.data.common.FacebookPagingData;
	
	/**
	 * The <code>FacebookVideoCollectionData</code> class is a value object 
	 * representing a collection of video data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookVideoCollectionData 
		extends FacebookPagingData
	{
		private var _videos : Array;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookVideoCollectionData(data:Object=null)
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
			
			_videos = new Array();
			
			if( data.hasOwnProperty( "data" ) )
			{
				var arr_videos : Array = data.data;
				var videos_len : int = arr_videos.length;
				for( var i : int = 0; i < videos_len; i++ )
				{
					var video : FacebookVideoData = new FacebookVideoData( arr_videos[i] );
					_videos.push( video );
				}
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Array of <code>FacebookVideoData</code>
		 * 
		 * @return Array
		 */		
		public function get videos():Array
		{
			return _videos;
		}
	}
}