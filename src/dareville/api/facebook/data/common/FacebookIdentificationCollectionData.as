package dareville.api.facebook.data.common
{
	/**
	 * The <code>FacebookIdentificationCollectionData</code> class is a
	 * collection of <code>FacebookIdentificationData</code> value objects.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class FacebookIdentificationCollectionData 
		extends FacebookBaseData
	{
		private var _identifications : Array;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * @param data 
		 */		
		public function FacebookIdentificationCollectionData( data : Object = null )
		{
			super( data );
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
			
			_identifications = new Array();
			if( data is Array )
			{
				var arr_data : Array = data as Array;
				var arr_data_len : int = arr_data.length;
				for( var i : int = 0; i < arr_data_len; i++ )
				{
					var id : FacebookIdentificationData = new FacebookIdentificationData( arr_data[i] );
					_identifications.push( id );
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
		public function get identifications():Array
		{
			return _identifications;
		}
	}
}