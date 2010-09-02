package dareville.api.facebook.data.photos
{
	import dareville.api.facebook.data.common.FacebookIdentificationData;
	
	/**
	 * The <code>FacebookPhotoTagData</code> class is a value object representing 
	 * tag data from a photo.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookPhotoTagData 
		extends FacebookIdentificationData
	{
		private var _created_time : Date;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookPhotoTagData(data:Object=null)
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
			
			if( data.hasOwnProperty( "created_time" ) )
			{
				_created_time = createDate( data.created_time );
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * X position of the tag
		 *  
		 * @return Number
		 */		
		public function get x() : Number
		{
			return data.x;
		}
		
		/**
		 * Y position of the tag 
		 * 
		 * @return Number
		 */		
		public function get y() : Number
		{
			return data.y;
		}
	}
}