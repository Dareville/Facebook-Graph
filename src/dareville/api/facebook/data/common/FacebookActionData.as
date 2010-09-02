package dareville.api.facebook.data.common
{
	/**
	 * The <code>FacebookActionData</code> class is a value object representing
	 * action data which is available for photos/posts. It provides links to 
	 * comment and like functionality for this item.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class FacebookActionData 
		extends FacebookBaseData
	{
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookActionData(data:Object=null)
		{
			super(data);
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Action name
		 * 
		 * @return String 
		 */		
		public function get name():String
		{
			return data.name;
		}

		/**
		 * Action link
		 *  
		 * @return String
		 */		
		public function get link():String
		{
			return data.link;
		}
	}
}