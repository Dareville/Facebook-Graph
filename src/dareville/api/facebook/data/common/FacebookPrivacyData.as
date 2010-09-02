package dareville.api.facebook.data.common
{
	/**
	 * The <code>FacebookPrivacyData</code> class provides value object
	 * accessors to privacy data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */
	public class FacebookPrivacyData 
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
		public function FacebookPrivacyData(data:Object=null)
		{
			super(data);
		}
		
		//---------------------------------------------------------------------
		//  Getter/Setter methods
		//---------------------------------------------------------------------
		
		/**
		 * Description
		 * 
		 * @return String 
		 */		
		public function get description():String
		{
			return data.privacy;
		}
		
		/**
		 * 
		 * @return String 
		 */		
		public function get value():String
		{
			return data.value;
		}
	}
}