package dareville.api.facebook.data.search
{
	import dareville.api.facebook.data.common.FacebookIdentificationData;
	import dareville.api.facebook.data.common.FacebookPagingData;
	
	/**
	 * The <code>FacebookSearchUserCollectionData</code> class is a value object 
	 * representing a collection of users searched.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookSearchUserCollectionData 
		extends FacebookPagingData
	{
		private var _users : Array;
		
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
		public function FacebookSearchUserCollectionData(data:Object=null)
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
			
			_users = new Array();
			if( data && data.hasOwnProperty( "data" ) )
			{
				var arr_data : Array = data.data as Array;
				var arr_data_len : int = arr_data.length;
				for( var i : int = 0; i < arr_data_len; i++ )
				{
					var id : FacebookIdentificationData = new FacebookIdentificationData( arr_data[i] );
					_users.push( id );
				}
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Array of <code>FacebookIdentificationData</code> instances
		 * 
		 * @return Array 
		 */		
		public function get users():Array
		{
			return _users;
		}
	}
}