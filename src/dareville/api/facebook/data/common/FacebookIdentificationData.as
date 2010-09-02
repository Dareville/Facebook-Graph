package dareville.api.facebook.data.common
{
	/**
	 * The <code>FacebookIdentificationData</code> class provides simple 
	 * <code>id</code> and <code>name</code> accessors to common data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class FacebookIdentificationData 
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
		public function FacebookIdentificationData(data:Object=null)
		{
			super(data);
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * ID property
		 * 
		 * @return String
		 */		
		public function get id():String
		{
			return data.id;
		}
		
		/**
		 * Name property
		 * 
		 * @return String 
		 */		
		public function get name():String
		{
			return data.name;
		}
	}
}