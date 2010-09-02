package dareville.api.facebook.data.common
{
	import dareville.api.facebook.data.interfaces.IFacebookPagingData;

	/**
	 * The <code>FacebookPagingData</code> class is provides base accessors to 
	 * value objects that having paging abilities.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class FacebookPagingData 
		extends FacebookBaseData
		implements IFacebookPagingData
	{
		private var _paging_previous : String;
		private var _paging_next : String;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookPagingData(data:Object=null)
		{
			super(data);
		}
		
		//----------------------------------
		//  Override
		//----------------------------------
		
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
			
			if( data && data.hasOwnProperty( "paging" ) )
			{
				_paging_previous = data.paging.previous;
				_paging_next = data.paging.next;
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * URL link to retrieve the previous list of items
		 * 
		 * @return String 
		 */		
		public function get paging_previous():String
		{
			return _paging_previous;
		}
		
		/**
		 * URL link to retrieve the next list of items
		 * 
		 * @return String 
		 */	
		public function get paging_next():String
		{
			return _paging_next;
		}
	}
}