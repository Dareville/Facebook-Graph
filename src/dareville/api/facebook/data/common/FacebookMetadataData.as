package dareville.api.facebook.data.common
{
	/**
	 * The <code>FacebookMetadataData</code> class is a base value object
	 * representing metadata data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class FacebookMetadataData
	{
		private var _data : Object;
		
		private var _connections : FacebookMetadataConnectionsData;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookMetadataData(data:Object=null)
		{
			_data = data;
			init();
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
		protected function init():void
		{
			if( data )
			{
				_connections = new FacebookMetadataConnectionsData( data.connections );
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * JSON decoded Object
		 *  
		 * @return Object
		 */		
		public function get data():Object
		{
			return _data;
		}
		
		/**
		 * Return the connections available
		 * 
		 * @return FacebookMetadataConnectionsData
		 */		
		public function get connections():FacebookMetadataConnectionsData
		{
			return _connections;
		}
	}
}