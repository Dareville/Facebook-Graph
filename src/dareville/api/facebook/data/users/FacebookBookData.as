package dareville.api.facebook.data.users
{
	import dareville.api.facebook.data.common.FacebookIdentificationData;
	
	/**
	 * The <code>FacebookBookData</code> class is a value object 
	 * representing data from a user who has specified their book interests.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookBookData 
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
		public function FacebookBookData(data:Object=null)
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
		 * Category
		 *  
		 * @return String
		 */		
		public function get category():String
		{
			return data.category;
		}
		
		/**
		 * Created time
		 *  
		 * @return Date
		 */		
		public function get created_time():Date
		{
			return _created_time;
		}
	}
}